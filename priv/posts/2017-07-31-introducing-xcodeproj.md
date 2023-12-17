---
title: Introducing xcodeproj
description: Read, update and write your Xcode projects from Swift
tags: [xcodeproj, swift, xcode]
---

Today I’m pleased to announce a new open source project I’ve been working on for the last few months, [xcodeproj](https://github.com/carambalabs/xcodeproj). Xcodeproj is a library written in Swift that allows you interact with your Xcode projects from Swift. It provides a foundational API to build up your scripts and tools on top of it. It’s entirely written in Swift, documented and ready to be used. In this post, I’ll explain the motivation behind working on xcodeproj, show you the “get started” steps to start using the library, and give you some hints about ideas that I have to leverage this tool.

## Motivation

This year, I’ve been very passionate about leveraging modularization to overcome scalability issues in mobile projects/teams. For every new module that I created I had to always go through the same manual steps: create the project, set the config, link dependencies, update the schemes… It was a very repetitive process, and it was easy to forget any of the steps, having some inconsistencies in the setup. I tried automating it by coming up with a script that clones a template Xcode project, and modifies some values in it. Although it solves the problem, it does it partially. It’s not flexible at all since it was hard to extend the template _(you had to update the original one, or create copies of it according to your requirements)_.

At some point I thought, what if there was a way to specify the project that you want, and there was a tool that would generate it for you? Something like: _“I want a project, with an iOS app, an iMessage extension, and a framework to share some code between them”_.

The closest tool that I found was [xcake](https://github.com/jcamp). It does exactly what I was thinking of. It’s written in Ruby and it uses a gem from the CocoaPods team, [xcodeproj](https://github.com/CocoaPods/Xcodeproj) that allows you modifying your Xcode projects and workspaces. Although I’ve done some Ruby before, and I know the APIs a little bit, I’m not very familiar with them and I wanted to experiment with Swift. I thought it would be a good idea to come up with something written in Swift, that other Swift developers could use to build their own tools on top of a foundational API. I started writing the swift version of [xcodeproj](https://github.com/xcodeproj).

Xcodeproj is a swift library that provides components for reading, modifying and writing Xcode projects and workspaces. In other words, it opens a new API for interacting with your Xcode projects. If you wonder what you can use xcodeproj for here are some ideas:

- Finding duplicate files.
- Checking if the groups hierarchy matches the system one.
- Detecting which targets have to be run/tested as a result of some files being modified.
- Generating projects from a specification file.

There are bunch of opportunities and I’m eager to see what developers can build using this new API.

## How to use it

If you are very excited and can’t wait to try it out, these are the steps that you can follow to start using xcodeproj within your projects.

First of all you have to add the dependency. You can do it by specifying the dependency in your Package.swift

`gist:pepibumur/b0d53f59b471047abb7a4275008964d6`

If you are using [Marathon](https://github.com/JohnSundell/Marathon), you can update your `Marathonfile` to specify the dependency

`gist:pepibumur/f069ea32f1685fa85680608670d9ed14`

Once done, you can use it by just importing xcodeproj. Here you have some examples of things that you can do with xcodeproj:

`gist:pepibumur/649fa8fe22f27d176ddf78c5e524e536`

## What’s next

While I was working on xcodeproj I got a few ideas about how to use xcodeproj. Here are some of them.

- **Generation of Xcode projects**. That was my original motivation but [@yonaskolb](https://twitter.com/yonaskolb) was faster than me and started building [XcodeGen](https://github.com/yonaskolb/XcodeGen). Instead of starting another project I think it makes more sense to support the project contribute with it.
- **Project linting:** Have you been in that situation when the compiler tells you about duplicated files, or when a file is missing but it’s still your project group (because those things happen when you screw it up solving your project conflicts). I’d like to provide linting for projects that identify those problems in your projects, alert you about them and offer the option to fix them automatically.
- **TDD:** I was fascinated when I saw [scala-sbt](http://www.scala-sbt.org/), the build tool for Scala. When you use it in your projects it has a mode that detects changes in files and runs only the tests of the files that have been impacted by those changes. I’d like to port that idea to the Xcode build system and being able to do something similar. That would allow developers iterate faster with confidence.

## Thanks

This project wouldn’t have been possible without all the resources and open source projects that I’ve listed in the sections below. Also, I’d like to thank [@yonaskolb](https://twitter.com/yonaskolb), first official user of xcodeproj that is leveraging it to build [XcodeGen](https://github.com/yonaskolb/XcodeGen), a tool for generating Xcode projects from a specification file. He’s contributed a lot to the library.
Also thanks to @saky and @sergigram reviewing the post.

Also thanks to [@saky](https://twitter.com/saky) and [@sergigram](https://twitter.com/sergigram) reviewing the post.

## References

- [Swift Package Manager — Xcodeproj](https://github.com/apple/swift-package-manager/tree/master/Sources/Xcodeproj)
- [Facebook Buck](https://buckbuild.com/javadoc/com/facebook/buck/apple/xcode/xcodeproj/package-summary.html)
- [Pbxproj identifiers](https://pewpewthespells.com/blog/pbxproj_identifiers.html)
- [A brief look at the Xcode project format](http://danwright.info/blog/2010/10/xcode-pbxproject-files/)
- [Xcode Project File Format](http://www.monobjc.net/xcode-project-file-format.html)
- XcodeGen
