---
title: Abstracting Info.plist files
description: On this blog post I talk about an idea that I'm pondering for Tuist. In the aim of abstracting implementation details from Xcode projects, I think there's an opportunity for Tuist to abstract `Info.plist` files which are barely modified by developers after they get created.
categories: [xcode, swift, ios, info.plist]
---

If you have worked with Xcode projects before, you might know what `Info.plist` files are. For those of you who are not familiar with them, they are plain xml files with key-value pairs that define app settings such as the icon or the build number. Below you find an example of the structure of the file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleDisplayName</key>
	<string>MyApp</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	...
	<key>AppIdentifierPrefix</key>
	<string>$(AppIdentifierPrefix)</string>
</dict>
</plist>
```

`Info.plist` files are created when developers create a new target _(e.g. a new iOS application)_. Most of the entries in the file are necessary but they are barely modified after the file is created. The entries that developers change the most is the version and build numbers. For others like the main storyboard or the icon, Xcode provides a UI interface to change the value.

As you might know, one of the aims of [Tuist](https://tuist.io) is abstracting away the details that we believe developers shouldn't be exposed to. I think those `Info.plist` values that are barely touched are a perfect candidate for abstraction.

I've been thinking about how that abstraction would be, and this is the idea I came up with:

```swift
enum InfoPlist {
    case file(Path)
    case dictionary([String: Any])
    static func productDefaults(extend: [String: Any]) -> InfoPlist
}
```

- **file:** If the user project has already an `Info.plist` file and they'd like to continue maintaining it themselves, this is the best option. The target will be generated accordingly to point to the local file. Notice that this is the only option that Tuist offers currently.
- **dictionary:** If the wants to define the content of the file in the project manifest and let Tuist generate the `Info.plist` file this is the option. When Tuist generates the project, it'll also generate the file right next to the project in a directory that contains this and other generated files.
- **productDefaults:** As I mentioned earlier, developers barely modify the values in that file. The one that they usually modify when they release a new version of the app is the build and version numbers. This option tells Tuist to use the default values of the target product, allowing the user to extend them as needed.

Below you find some examples of how the definition of the target would look. Note that for simplicity of the examples, the targets don't take all the arguments that are required:

```swift
// Existing Info.plist file
let watchApp = Target(name: "MyWatchApp", infoPlist: .file("./WatchApp.plist"))

// Generated Info.plist file with the given dictionary
let framework = Target(name: "MyFramework", infoPlist: .dictionary([
  "CFBundleExecutable": "$(EXECUTABLE_NAME)",
  "AppIdentifierPrefix": "$(AppIdentifierPrefix)"
]))

// Generated Info.plist file extending the platform default values.
let app = Target(name: "MyApp", infoPlist: .productDefaults(extend: [
  "CFBundleInfoDictionaryVersion": "6.0",
  "CFBundleVersion": "1.0"
]))
```

One of the most beautiful features of Tuist in my humble opinion is that manifests are written in Swift. That allows us to take benefit of extensions and `Foundation` protocols to simplify the interface:

```swift
extension InfoPlist: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (String, Any)...) {
        self = .dictionary(Dictionary(uniqueKeysWithValues: elements))
    }
}

extension InfoPlist: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self = .file(value)
    }
}
```

Thanks to those extensions, we can turn the examples into:

```swift
// Existing Info.plist file
let watchApp = Target(name: "MyWatchApp", infoPlist: "./WatchApp.plist")

// Generated Info.plist file with the given dictionary
let framework = Target(name: "MyFramework", infoPlist: [
  "CFBundleExecutable": "$(EXECUTABLE_NAME)",
  "AppIdentifierPrefix": "$(AppIdentifierPrefix)"
])
```

By giving Tuist more control over those files, we can **run validations** and verify that they contain the required attributes with the right values. As an example, watchOS extensions have a strict requirement when it comes to the bundle id of the extension. Since that's an attribute configured in the `Info.plist`, we could verify that the value is right according to the watch app they are associated to.

Although developers can git-ignore those files because they get generated automatically when they run Tuist, I'd encourage them to keep them in the repository so that developers can checkout any revision of the project and compile it with Xcode without having to install Tuist.

An idea that I'm still pondering is how to structure the directory that contains the generated files. `Info.plist` files will be the first ones living in this directory but I'm sure they won't be the only ones. Here's a rough idea that I just had:

```bash
./Project.swift
./Generated
   InfoPlists/
     App.plist
     MyFramework.plist
```

I'll sleep over the idea experiment with it to see how it feels in practice. If you have an opinion on it and don't mind sharing, I'd appreciate it a lot. Don't hesitate to ping me on Twitter, send me an email, our join [Tuist's Slack](https://slack.tuist.io) where you can talk to other contributors and maintainers.

I wanted to start coding on my flight ✈️ to Alicante but unfortunately, I forgot to run `swift package generate-xcodeproj` and now I can't fetch the dependencies to do some coding 😕.
