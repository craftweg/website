---
title: "Why you need the -ObjC flag"
description: "In this blog post, I explain why you might need to set the -ObjC flag in the OTHER_LDFLAGS build setting of your Xcode project."
tags: ["Swift", "Xcode"]
---

Tuist provides a [method](https://docs.tuist.io/guide/project/dependencies.html#tuist-s-xcodeproj-based-integration) for integrating Swift Packages, previously resolved by SPM, into Xcode projects using XcodeProj primitives such as targets, build settings and phases.
This feature uncovered a need that some packages in the ecosystem have,
and that's the need for upstream targets to pass `-force_load` or `-ObjC` through the build setting `OTHER_LDFLAGS`.
Why is that needed?
Thanks to [David](https://github.com/thedavidharris), who put together some [troubleshooting](https://docs.tuist.io/guide/project/dependencies.html#troubleshooting) guidance and provided [some references](https://github.com/tuist/tuist/issues/6320#issuecomment-2146534862) to discussions, I could better understand what the problem was.
This post is my attempt to write down my understanding of the problem, to help other developers in the future come across the same issue. 


In simple words,
the problem is that the linker **overoptimizes the binary removing symbols that are needed at runtime.**
The linker's dead-stripping logic can't delete dynamically referenced symbols.
And this is something that happens not only when referencing Objective-C symbols, but [Swift too](https://forums.swift.org/t/linker-flag-objc-force-loads-swift-libraries/47466/3).
For example, when integrating Composable Architecture,
when integrating it with Tuist via Xcode targets, developers might need to add explicit references to those symbols or the flags above to the build settings.

What's the solution? There are a few options:

- The package maintainer can add static references to those symbols to prevent the dead-stripping logic from removing them  (e.g., [Promises](https://github.com/google/promises/pull/221), [IGListKit](https://github.com/Instagram/IGListKit/pull/957))
- You set the `-force_load` or `-ObjC` flag in the `OTHER_LDFLAGS` build setting of the target that links those packages statically. Note that this has some effects, like potentially increasing the binary size.
- You turn those dependencies into dynamic targets, which as a caveat might end up increasing the launch time of your app.

This is a bit unfortunate because it requires developers to go a bit deeper in understanding their dependencies
, but hopefully this write-up helps you understand the problem and the potential solutions.
