---
title: Derived Info.plist files
description: In this mini-post I talk about some recent work that I've done in Tuist to support defining Info.plist files in the manifest file.
categories: [tuist, infoplist, xcode]
---

Today I found some time to do some work on [this PR](https://github.com/tuist/tuist/pull/380),
which allows Tuist users to define the content of their `Info.plist` files in the project manifest.
Although it doesn't add much value compared to having the content in a `Info.plist` file,
it opens the door to a powerful abstraction:
inheriting product-base values that developers can extend with their target-specific keys.

```language-swift
let infoPlist = InfoPlist.default(extend:[
  "CFBundleShortVersionString": "1.0",
  "CFBundleVersion": "1"
])
let target = Target(name: "MyFramework", infoPlist: infoPlist)
```

As we can see,
we just need to override the values that our target is interested in providing,
the rest is provided by Tuist.
As part of the project generation,
Tuist creates the file at `/path/to/project/Derived/InfoPlists/MyFramework.plist`.

The `Derived` directory only contains the `Info.plist` files for now,
but we may store more types of files in the future.
For instance,
I'm considering integrating [SwiftGen](https://github.com/SwiftGen/SwiftGen) into Tuist,
storing the generated code under `Derived/SiftGen*`.

It's exciting seeing Tuist abstracting all the complexities and most importantly,
seeing how the architectural decisions that we made are enabling this effort.
