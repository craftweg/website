---
title: Deep linking into macOS apps
description: Some comments on what's the state of art of macOS handling deeplinks.
categories: [deeplink, macos, cocoa, safari]
---

Today I happened to play with deep links on macOS. Having worked a lot on the iOS platform, I assumed things would be alike. To my surprise, it wasn't like that.

As you might know, websites can include a manifest file that associates a website with a given application on iOS. When the webview detects that the website is _deeplinkable_, it suggests the user to continue the navigation inside the app. _Seamless, isn't it?_ There could arguably be more flexible and better ways of dealing with deeplinks on iOS, but I think the approach that iOS currently provides is enough for the needs of most projects. The example below shows the format of that `apple-app-site-association.json` manifest file:

```json
{
	"applinks": {
		"apps": [],
		"details": [
			{
				"appID": "com.mycompany.App",
				"paths": ["*"]
			}
		]
	}
}
```

Things are pretty different on macOS. First of all, macOS apps can't be associated to a website through a manifest. What they can do though is defining URL schemes that they support. When a webview tries to load a URL, whose scheme matches any of the schemes defined by the installed apps, it'll launch the app pasing the URL to it. _One might think that that's all needs right?_ Let me refute that by giving you an example, proof of a bad user experience.

You navigate a website or a service that can deeplink into a macOS client. At some point of the user navigation, it triggers the deeplink and it turns out that the user doesn't have the app installed. The system errors because the request was not handled by anyone and the browser can't show an error because it doesn't know what happened after the link was fired off.

> The browser can just trigger the request hoping for the os to handle it gracefully. Unfortunately, the system interrupts the flow when there isn't an app to process the request.

One solution to this problem could come from Apple. They could align macOS to iOS and allow defining associations between websites and desktop apps. Given that they are putting effort into aligning macOS to the other platforms, I would not be surprised if that happens any time soon.

Another solution, yet not perfect, could be implemented by using some Javascript and HTML. The first thing that I tried was changing the website location using Javascript and detect whether the browser was able to replace the location using a timeout. That solution worked for Chrome and Firefox but not for Safari. Regardless of the system being able to handle the request, Safari navigates to an invalid page, in which our Javascript session with the timeout gets wiped out.

After some reading, I found a little hack that also works in Safari. We can embed an `<iframe>` element in which we can load the deeplink. By doing that, we can trigger the processing of the deeplink by the system and prevent Safari from navigating to an invalid page. Not ideal, but works. If you are familiar with React, here is how I ended up wrapping everything into a component:

```jsx
class RedirectShowPage extends React.Component {

  render() {
    let body = (
      <p>
        <b>Redirecting to the app...</b>
        <br />
        If you don't have the app installed, you can download it using the
        following <a href="link_to_app">link</a>.
      </p>
    );
    const path = this.props.path;
    const location = `scheme://${path}`;
    return (
      <Page>
        {body}
        <iframe ref="iframe" style=\{\{ visibility: "hidden" \}\} src={location}/>
      </Page>
    );
  }
}
```

I tried to figure out if it'd be possible to detect when the deeplink could not be handled but unfortunately, that's something neither the browser nor the system can help us with.

## References

- [Universal links](https://developer.apple.com/ios/universal-links/)
