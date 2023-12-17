---
title: Catching crashes at launch time on Android React Native apps
tags: ['react-native', 'android', 'crashes']
---

One thing that I noticed about React Native is that with the setup that most teams have on CI **launch-time crashes can go unnoticed**.
Those crashes often happen when the contract between React Native and native is not met.
That scenario is not caught when transpiling the Javascript or running tests on either the Javascript or the native side.

_What's the consequence of that?_ Crashes landing on master, developers frustrated because the app don't launch after rebasing changes from master, or even worse, users getting an app that doesn't launch.

At Shopify, I tasked myself to put a system in place to catch those errors on **CI**. In this short blog post, I'll share what we ended up doing.

Since we use the [Firebase test lab](https://firebase.google.com/docs/test-lab), the contract with whatever we build needs to build a test.
After a bit of reading because I'm not very familiar with Android as a platform,
and in particular how testing works in it,
I managed to implement the following test:

```kt
@RunWith(AndroidJUnit4::class)
class LaunchTest {
  @get:Rule var rule = ActivityTestRule(MainActivity::class.java, true, true)
  @Test
  fun default() {
    Thread.sleep(20000)
  }
}
```

As you can see, it does nothing but just launching the main app activity and wait for 20 seconds.
I first tried to subscribe to the React Native loading events but I couldn't find a public interface for that.
20 seconds should be enough time for an app to boot on an Android emulator.
If the test fails because it takes more than 20 seconds to boot, there's probably something else to be looked at because that's a terrible experience for the user.

The test passed for an app that launched successfully, but it also passed for an app that was supposed to crash. _Why was that?_

## Disabling the developer support mode

As you might know,
React Native has a developer support mode that is enabled when the app is compiled for debug.
That mode prevents the app from crashing and shows a red error screen instead.
Because of that, the activity was not crashing causing the test to throw a false positive.
The 2 first options that I ended up discarding where the following:

- **Use the release variant:** Although that could have probably worked, it's not common to run tests using a release configuration. Moreover, we'd have had to sign the app before sending it to the test lab, which is something that we didn't want to do.
- **Add a debugTesting variant:** That extended from debug, and set a build config variable that we can read from the Application to disable the developer support mode. However, that resulted in compilation issues that bubbled up from React Native dependencies.

What I did in the end was defining a custom test runner that leverages [shared preferences](https://developer.android.com/training/data-storage/shared-preferences) to pass some variables to the application when it's being run from the test:

```kt
class LaunchTestRunner : AndroidJUnitRunner() {
  override fun callApplicationOnCreate(app: Application?) {
    val preferences = InstrumentationRegistry.getInstrumentation().targetContext.getSharedPreferences("TESTING", 0)
    val editor = preferences.edit()
    editor.putBoolean("IS_LAUNCH_TEST", true)
    editor.commit()
    super.callApplicationOnCreate(app)
  }
}
```

Thanks to that, we could adjust the logic in the application class, to read the value and adjust the developer mode accordingly:

```kt
override fun getUseDeveloperSupport() = BuildConfig.DEBUG && !applicationContext.getSharedPreferences("TESTING", 0).getBoolean("IS_LAUNCH_TEST", false)
```

Moreover, we had to change the testing configuration to use our custom test runner:

```
testInstrumentationRunner 'com.shopify.app.LaunchTestRunner'
```

After that,
the test was passing when the app launched successfully, and failed when the application crashed.

> By default, when building a React Native app for debug it doesn't bundle the Javascript and the resources because it reads them from a local HTTP server that runs alongside the application. Since that's not what we want, before building the app, we run the following command: `react-native bundle --platform android --dev false --entry-file index.js --bundle-output app/android/app/src/main/assets/index.android.bundle --assets-dest app/android/app/src/main/res --config metro.config.js`

In a follow-up blog post I'll talk about how we achieve a similar thing on iOS.
In that case, we didn't have to implement an XCTest test;
instead, we added a Rake task that built the app and attempted to launch it on an iOS simulator using the `simctl` tool.
