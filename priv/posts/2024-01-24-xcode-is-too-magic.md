---
title: "Xcode is too magic"
description: "Xcode is a great tool for beginners, but it makes it hard for developers to understand what's going on under the hood and optimize their workflows."
tags: ["Xcode", "Apple", "DevX"]
---

While preparing [my talk](https://www.youtube.com/watch?v=BqKBnFTiWQg) for [Swiftable](https://www.swiftable.co/),
and thinking about the Xcode challenges that developers face and how Tuist helps overcome them,
I realized that a lot of the challenges are rooted in Apple's approach to products with Xcode.
They **lean on the convenience side of the spectrum**, which is great for beginners,
but it makes it hard for developers to understand what's going on under the hood and optimize their workflows.

There are a handful of examples in Xcode.
For example,
the **Find implicit dependencies** option in Xcode schemes.
It opens an interesting debate about whether a graph with dependencies not explicitly declared in the project should be a valid graph.
What we learned with [Tuist](https://tuist.io) is that the more explicit and side-effect-free the build graph is,
the easier it is to reason about it and optimize it.
So developers lean on the side of implicitness,
which is alright at the beginning because you can type `import MyFramework` and declare a dependency with `MyFramework` in code, but a few months later,
when the project grows,
some features like Xcode Previews don't work and you don't understand why.
We've seen organizations adopting Tuist and reporting that their build times became faster after they migrated or that Swift Previews started working.
So part of the work that we do with Tuist consists of designing APIs that prevent implicitness in projects.

Another example is Xcode exporting the built products into a directory that's linkable from any target of the project.
So if you have a dependency scenario like `A > B > C` where `>` represents "depends on",
A might be able to import C because by the time Xcode starts building A,
the built products of C are already available in the directory that Xcode uses to link the products.
You might think this product principle is unique to Xcode projects, but the Swift Package Manager has inherited it too.
**Package libraries can mark themselves as [automatic](https://github.com/apple/swift-package-manager/blob/d25b6345a52c8097010899fdcc961a3820c607aa/Sources/PackageModel/Product.swift#L84)**, letting the build system decide what the best linking strategy is.
I want to make that decision myself.
Especially when the linking might impact the size of the output bundle,
for example by having the same static library linked from multiple dynamic frameworks.
Once again, leaning on the side of convenience, at the cost of presenting developers with other issues.

As you might have noticed,
all this convenience is achieved by making Xcode's build process more magical.
You hit compile,
and there are a bunch of things in your project that Xcode might be able to resolve magically,
or maybe not, and you end up with one of those cryptic errors that developers try to resolve by cleaning the derived data folder.

The more I think about this,
the more I think Apple should go back to first principles,
flag those as anti-patterns,
and provide a migration path for existing projects.
The reason why that implicitness was introduced in the first place is because declaring **a dependency graph in Xcode exposes a lot of complexity to the user.**
For example, when a dynamic framework should be embedded or not into a final product is something they can infer based on the graph,
why are they requiring users to do so?
We do that for users and they love it because it's one less thing they have to worry about.
What about potential bundle size increase due to static libraries liked in different parts of the dependency graph?
They could detect that too and present the user with a warning before they hit compile.
There's a lot they could do to make Xcode a tool and a build system that works with large-scale projects,
but I guess they are not incentivized to do so.
The organizations that have reached that scale,
can resort to other build systems like Bazel, or tools like Tuist.

Imagine if they took the opportunity to build a foundation that's extensible like Gradle is so that developers don't have to replace their build systems or resort to additional tools.
I think I'm dreaming too much.
