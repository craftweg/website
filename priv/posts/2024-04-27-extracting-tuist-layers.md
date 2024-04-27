---
title: "Layering Tuist"
description: "Drawing inspiration from the VueJS, we'll start extracting some layers from Tuist to make them Tuist-agnostic, and take the opportunity to ensure Linux compatibility, embrace Swift's structured concurrency, and remove the dependency on shared instances that complicate parallelization of tests at the above layers."
tags: ["Open source", "Tuist"]
---

Drawing inspiration from the [VueJS](https://vuejs.org/),
we'll start extracting some layers from [Tuist](https://github.com/tuist/tuist) to make them Tuist-agnostic,
and take the opportunity to ensure Linux compatibility,
embrace Swift's structured concurrency,
and remove the dependency on shared instances that complicate parallelization of tests at the above layers.
Those layers will be open source, and some will start as a fork of some [swift-tools-support-core](https://github.com/apple/swift-tools-support-core) utilities since the package is no longer maintained.

Those utilities in order of priority are:

- [**Path**](https://github.com/tuist/path): Utilities to model absolute and relative paths in a type-safe manner.
- [**Command**](https://github.com/tuist/command): Utilities to run system processes.
- **FileSystem (coming):** Utilities to perform file system operations such as copying files or creating directories.
- [**SwiftTerminal:**](https://github.com/tuist/swiftterminal) A design system for building command-line interfaces in Swift.
- [**Dependencies:**](https://github.com/tuist/dependencies) Utilities to declare the registration of a dependency graph.
- **XcodeProjectGenerator (coming):** A foundation for generating Xcode projects and workspaces from the graph description.

All the packages will accept a [swift-log](https://github.com/apple/swift-log)'s `Logger` instance to give users control over how they'd like the packages to log messages.

Note that they are still in the early stages of development. We want to make sure each of them is well-tested across the supported platforms and that they include documentation.
