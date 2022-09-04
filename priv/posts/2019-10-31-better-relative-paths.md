---
title: Better relative paths
excerpt: We are providing a new API from Tuist to define relative paths and this blog post describes the motivation behind it and the solution that we are adopting.
categories: [tuist, open source]
---

One of the best decisions that we made when we envisioned Tuist was using Swift as a language for describing projects. Its compiler can validate the syntax, users get documentation right in the code editor, Xcode, and very soon, it’ll allow defining paths that are relative to Tuist-specific directories.

One of the concerns that surfaced when we proposed introducing project description helpers was being able to define paths relative to those helpers, or why not, relative to the root directory of the project. The good thing is that with some tricks, and some Swift interface, we found a solution for that. Let’s say there’s a helper that generates a standardized feature framework project:

```swift
// FrameworkHelper.swift

func framework(name: String) -> Project {
  // Your initialization logic here
}
```

With some rare exceptions, the Info.plist files the framework targets usually point to have the same content. It’s clearly a good candidate to be reduced to a single file that we can place in the root directory of our project to be reused by all the targets. With the current Tuist API, developers would have to write something along the lines of:

```swift
// FrameworkHelper.swift

let path = ""../../Shared/Framework.plist"
```

It’s a bit ugly, and the helper is making an assumptions on the directory where the manifest using the helper is located.

Thanks to some work that we are doing, developers will be able to do something along the lines of:

```swift
// FrameworkHelper.swift

let path = Path.from(root: "Shared/Framework.plist")
```

The definition is shorter, and there are no assumptions, it can be used from anywhere because the root directory of the project will remain the same.

The feature work is still progress but you can check out the [pull request](https://github.com/tuist/tuist/pull/617) and give us feedback.
