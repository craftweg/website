---
title: Why am I obsessed with developers being productive using Xcode?
description: In the last months I've been investing a big chunk of my free time on building tools to make developers productive working with Xcode. In this blog post I reflect on what led me to start working on that tool, Tuist, and how I'm addressing some of the challenges that are presented when using Xcode at scale.
categories: [xcode, scale, swift, tuist, developer]
---

These days I'm attending Shopify's RnD summit where different teams give talks and workshops about some areas of the company. In today's talks, there was a topic that resonated with me: **being obsessed with developers productivity**. It made me think about a tool which I've been building for a few months, [Tuist](https://github.com/tuist), and what led me to devote part of my free time to build it.

> The name of Tuist comes from merging build and test.

I've been doing iOS development for most of my career. I started building apps myself, then I jumped into building them within a team, and eventually, I ended up researching and working on how to architect them to make sure that they scaled well with the growth of the team and the project. If you are building a simple app with a few targets, it's probably enough to use Xcode and maybe some automation tool like Fastlane that takes some manual work off from you. If you have the size of a company like Facebook, you can create a team of engineers to address your project needs. Unfortunately, not all the companies are Facebook which can create a team focused on making sure that the project scales and developers are productive working on it.

> As an example, at Shopify there's a team focused on that, mobile tooling, which I belong to. We are not too large, but enough to have an impact on developers productivity. We maintain part of the CI infrastructure as well as the tooling and processes that developers use to interact with their projects.

One of the things that I like the most about working in tech is the ability to help other people. This was a great opportunity for me to take action and help developers focus and be productive on what they like the most, **building great apps**. I hated spending time spending time waiting for the compiler to finish, trying to understand the errors that Xcode threw, or doing a lot of manual work to add new projects/targets. I wondered so many times why did I have to do all those things myself when a tool or Xcode could take care of those things.

A few years later Xcode remains the same, except with some nice features like refactoring and dark mode. Jokes aside, Xcode keeps being optimized for simple apps. The reality is though, that apps are more complex. One might think that we could just keep the structure of our apps simple, but that's unavoidable if your project is large. Sooner or later you add targets for other platforms, like a watchOS application, or have other teams that want to reuse some of the classes that are already built, forcing you to create a framework for that.

> Apps become complex and the tools that we are given doesn't help us deal with that complexity

Things are great when we create new projects with Xcode. We are given an assistant where we can select the type of application that we'd like to create or the testing targets that we'd like to add. Those projects come with an implicit configuration that we are sometimes not aware of, but which is crucial for things to work. As we keep adding and changing things, it's very likely that we touch it resulting in our setup breaking and developers spending time figuring out why. Have you been there before?

Let me give you an example to better understand what I'm talking about. If you have an iOS app and add a watchOS one, the following things are added by Xcode:

- A watchOS app and extension targets.
- The extension target has the same bundle id as the app but prepending `.watchkitextension`.
- The iOS app has a new build phase that embeds the app inside the products `$(CONTENTS_FOLDER_PATH)/Watch` folder.
- The watchOS app has a target dependency with the extension. It also has a build phase to embed the extension into the plugins folder.

If any of the settings above is changed or removed by mistake, you'll get weird errors trying to run the watch app. Should Xcode make those things more explicit? I think it should. Could Xcode catch those issues? It could. But why it doesn't? 🤔.

I strongly believe that the setup and maintenance of projects should be taken away from the developer's responsibilities by making things more explicit. Furthermore, any misconfiguration should be detected as early as possible and thrown to the user with understandable messages that facilitate the fix.
The way [Tuist](https://github.com/tuist/tuist) solves this problem is by providing a new project format. The tool generates Xcode projects from it and offers a convenient and easy to use set of tools that developers can use from their terminal.

Another thing that motivates me about building projects like Tuist or [xcodeproj](https://github.com/tuist/xcodeproj) is that I'm also opening new APIs that teams can leverage to build their own tools. When I look at the Android ecosystem I'm jealous of the tools that they are given. The build system, Gradle, allows defining the build process in Kotlin and extending it through plugins. It also offers convenient command line tools whose interface depends on the current directory. For example, if there's a module that we can build for release, you can execute `./gradlew assembleRelease` and you'll get your build for release. Imagine if you had such a thing in Xcode, a wrapper around xcodebuild that figures out the arguments for you to keep the interface as simple as possible. This is also something I'm aiming for in Tuist.

While working on this project **I had a few downs**. One of them was feeling that I would be working on something that no one would use. In my experience working with iOS developers, it's hard to convince them to use something that doesn't come from Apple. Some are often hopeful for Apple to make their lives easier, and skeptical regarding the usage of non-official tools such as a CocoaPods, Carthage, or similar. They see the usage of third-party tools a risk that they are not willing to take. Apple has a strong influence on how it wants its ecosystem to be, and that makes it difficult for projects like Tuist to find motivation and support from more people.

I'm very optimistic about the future of Tuist and the opportunity of having an impact in the apps that are being built nowadays. Before writing the first line of code of Tuist, I had had a chat with some iOS developers who expressed me their struggles working in their codebases. That was around a year ago and nothing has changed so far. I'm working on Tuist with the uncertainty of Apple extending the scope of the Swift Package Manager, but even if that happens, I'll be happy to have put a seed in what the future of productivity-focused tools for Xcode should look like and all the things that I'll have learned along the way.

If Tuist sounds interesting and you would like to give it a try, or just contribute to the project just let me know. I'm eager to hear your experience using Xcode and get ideas for things Tuist could help you with. There'll be an official blog post and documentation once the first version gets published. In the meantime, feel free to head over to the [organization on GitHub](https://github.com/tuist) or check out the [project repository](https://github.com/tuist/tuist).

> If making mobile developers productive sounds interesting to you and you have some experience on Ruby drop me a line.
