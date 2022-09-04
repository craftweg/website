---
title: This app could not be installed at this time
excerpt: Because sometimes Xcode cannot install your apps, and you have to figure out why.
categories: [ios, watch, xcode, install]
---

I've spent a whole Sunday trying to get an Xcode project running. The project contains an iOS and watchOS app sharing code using frameworks. Moreover, I've automated the generation of the Xcode projects using [XcodeGen](https://github.com/yonaskolb/xcodegen). Everything seemed to be fine; I was able to generate the projects, compile the modules individually, run their tests, but at some point, I got stuck at something that after a few hours, can't understand. Whenever I tried to run the iOS app or the watchOS application I got the error that you can see in the screenshot below:

![Xcode error saying that the app could not be installed this time](/images/posts/app-could-not-be-installed.png)

**This app could not be installed at this time.** At first I thought my compiler became time sensitive, but after a while, nothing changed. Xcode kept complaining about the same thing. The second thing that I tried was creating the project manually. I dragged and drop a bunch of stuff, update the project build settings, and to my surprise, the same thing happened 🙄. I've never had a good experience working on watchOS applications using Xcode. I haven't done it for a while but it seems that there hasn't been much improvement. I think this is so far the second most frustrating issues that I've got so far from Xcode. The first one is of course, **Segmentation Fault**. I love that one, especially when you have to debug it, and you end up reverting all the code that you recently added.

I try to be optimistic but lately, working using Apple's tools have been very frustrating. I feel they are investing a lot of effort in pushing Swift but that they are forgetting about some elemental things like the editor that most of the people use to develop in Swift.

Anyways! I was building an app that I plan to build in a workshop that I'm giving at [Romobos](http://romobos.com/). The preparation of the workshop was going very smoothly until I came across this nice Xcode gift. I haven't been able to understand the issue so far, and I think I'll end up building a today extension, rather than a watchOS application. If you are interested in the project and would like to try it by yourself you can check out this git repository `https://github.com/pepicrft/xcode-modular-apps-workshop` and go to the tag `0.6.0`.
