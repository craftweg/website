---
title: My thoughts on using React Native
excerpt: I describe in this article what for me are the positive and negative points towards using React Native as technology for building your mobile apps.
categories: [react native, mobile, swift, javascript]
---

We hear a lot about React Native these days. More companies are trying it out and building small features in their apps. They can iterate and prototype faster without having to compile large codebases in their development cycles. For those who don’t know about RN, it’s a native/javascript framework for Android and iOS that provides you a Javascript layer for coding your apps. It converts your code into a native representation. In other words, you code like if you were coding a website, but the DOM, in this case is the native app. Although there are many good points towards using RN in your projects, it also comes with some downsides that it’s important to be aware of.

I’ve used RN the last couple of months and I’d like to share in this post, what, in my opinion, is very positive about RN, which things need to be improved, and in which scenarios is a good technology to consider. Let’s tart with the positive points.

## Positive

### Fast iterations

If you have experience working on mobile code bases, you most likely know how frustrating it’s having to wait to the compiler to finish to see your changes on the screen. While this is a good time to grab a coffee and chat with your colleagues, at the end of the month, you’ll lose a lot of time waiting for your compiler. The bigger the project is, the more apparent it is. At some point not only you’ll be frustrated, but also the product managers and the company: _Why is this team taking so long to build this simple feature?_ Thanks to RN that problem goes away. When you run the app locally, it executes a local HTTP server that serves the main Javascript file that contains the app, and whenever a change is introduced, it regenerates then file and notifies the app about it. You don’t have to compile the app anymore when you introduce changes. This is the coolest thing of RN, and the reason that is leading the big companies to try it out.

### Reusability

If you work on a mobile product that has iOS and Android apps, RN will be your best friend. RN is built on top of React, where you build your UI defined what it’s called _“components”_. RN comes with a list of native components, the majority of them cross-platform _(e.g. View, Button, ListView)_. When you use them in your app, the framework converts your component into the equivalent element in the platform you are building for. It’s very transparent, you just build the component using cross-platform components and it’ll most likely work on Android and iOS _(you might need to tweak it a little bit)_. I was able to reuse 90% of the Javascript code between the two platforms. The only part that I had to change was the navigation because the patterns are different on each platform.

### Javascript libraries

By using RN, you have access to a vast catalog of libraries and tools. For example, if you use [Redux], you can use the Chrome extension for debugging the states in the app, [Redux Web Tools](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en). Unless the library that you are linking against to is using any browser-specific API, you’ll most likely be able to integrate it with your app. The packaging that RN uses is very transparent; you don’t need to care about how the external dependencies are bundled. By just adding it to NPM/Yarn and importing them from your Javascript file, RN will take care of the rest. It’s elegant!

### Dynamism

Due to its origin, Javascript is a very dynamic language. Coming from static languages where the compiler is a key piece in the equation, using a dynamic language might sound a bit risky and dangerous. Luckily there are some tools that we can use to be more confident but still benefit from the language dynamism. One example of these tools is [Flow] from Facebook, a static type checker for Javascript. You can easily integrate it in your workflow and your IDE and get errors whenever there’s something wrong with the types that you are using. Having worked with Objective-C and Swift, it’s great to see the IDE telling you that you are trying to access a value that might be nil.

### TDD

The fact that you don’t have to compile your code makes TDD possible. You can just save your changes and get instant results. There are a lot of plugins for the IDEs that you can use to get the results on the UI. For example, [this plugin], shows you a dot next to your test, with a green or red color, depending on the result of the test. Moreover, you’ll find different testing approaches and tools so you can find the one that suits your needs. For example, you can use [Jest](https://facebook.github.io/jest/) _(also from Facebook)_ that provides a cool snapshot testing feature.

## Negative

### Upgrading

Honestly, RN is very bad at this. I’ve gone through this nightmare in different projects, and it’s not very straightforward. RN offers a [command line tool] that you can execute and tries to migrate your project. However, the tool doesn’t work as well as expected, and sometimes you might even end up [solving conflicts manually]. I’ve seen developers solving this problem by generating another RN project using the last version of the framework, and then copying and pasting files and config from the previous project. _This is really bad!_
Upgrading sometimes implies changes in the native setup _(Android and Xcode projects)_, and if you tweaked it a lot, RN might break/reset your project during the upgrading process. It’s not something funny that you’d like to go through!

### Layout loading

On the web ecosystem, frameworks have tried to abstract developers from accessing the DOM directly, and have allowed them to focus on defining how the layout looks like. From the developer’s point of view, working on a website using these frameworks is nicer, and faster, and from the user’s one, it might be the same, or better _(it all depends on how you architect your website)_. Nevertheless, if you apply the same principle on mobile, the experience from the user might not be the same as if the app was built entirely with native code. **Why?** To ensure the experience using the app is the best, iOS and Android frameworks provide optimized components that are designed to have a good performance and responsiveness. RN components are designed to be cross-platform, and easy to use for developers, but when they get rendered, they sometimes don’t have the expected native behavior. You need to tweak the components and their lifecycle to get closer to the native experience.

### Animations

Animations have always been a challenge for RN. They usually rely on delivering/observing a stream of events _(think about a parallax effect in a scroll view)_. Since that stream is sent through a single-threaded bridge between React and native, other events might get delayed, and it ends up affecting the responsiveness of the app. One of the approaches RN it trying out to solve this problem is coming up with a declarative manner for defining your animations. Instead of having a stream, the specification of the animation would be sent to native at the beginning, and the rest would be performed on the native side. While this works if the animations are simple, you might find it limiting if you want to build up something more custom. In that case, my recommendation is that you build the component natively, and handle the animations from there.

## Where should I use React Native?

This is my personal opinion based on my experience, and it might change soon since the framework is evolving at a really good pace. If I had to choose between using RN or not, I’d keep the things in the list below in mind:

- If the component that you are building is very heavy regarding **animations**, I’d build it in native. Although they are trying to improve the animation APIs, by using them, you might compromise the responsiveness of your app.
- Having a person with the experience with the native tools is a good thing to have. `Xcode` build system, `Android` project, and `Gradle` might not be that straightforward for a web developer. Although you might not need any help from then 90% of your time, as soon as you touch something in the config, you might break the whole setup easily. That person could help you analyze and understand the errors that you might get from the build system.
- RN is great for **prototyping**; I’d definitively use it for it since you can try things pretty quickly and use real APIs that developers will use when they build the final product.
- There isn’t a clear navigation pattern established yet so I wouldn’t define the navigation from RN. It allows you to combine views that are entirely native and views that are RN.
- If the code base is purely native, and you plan to build a new feature in RN because you want to reuse it with other platforms, I’d try that feature to be as atomic as possible. You should be able to think of the feature as an input-output box, minimizing dependencies with the app.

Do you have experience working with RN? I’d like to hear about the things that you liked and disliked from the framework, and what are your wishes for future versions. Reach out to me or leave a comment below. Thanks for reading and I hope you liked the post.
