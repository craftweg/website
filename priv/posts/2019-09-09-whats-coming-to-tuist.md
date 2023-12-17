---
title: What's coming to Tuist
description: A Monday blog post with some reflections about the current state of Tuist and its future.
tags: [tuist, open source, xcode, swift]
---

I continue to be excited about Tuist.
It's one of those things that brings me a lot of joy when I work on it.
What makes me the most exciting is the challenge of abstracting Xcode intricacies that arise when Xcode projects grow.
I relate Tuist to Rails,
a framework that I had the experience to learn and fall in love with very recently.
Rails provides beautiful and simple abstractions for most of the features that are required nowadays to build web apps.
**What Tuist's abstractions will look like** is still to be defined,
but I'm glad that we are on the right track to define them.

One of the things that we plan to work on,
and that [Kas](https://twitter.com/kwridan) is leading,
is morph the architecture of the project into a more modular approach.
That'll make the code safer,
easier to understand,
and will increase the extendibility of the projects generation.
He pushed the idea that we are pondering to the [tuist-labs](https://github.com/tuist/tuist-labs) tha we created to explore ideas outside the main repository.

In regards to features,
these are the ones that I've been pondering lately and that I'd like to see in Tuist:

- **Swift interface for accessing resources:** I think Tuist could leverage [SwiftGen](https://github.com/SwiftGen/SwiftGen) to generate type-safe Swift code to access resources. The generated Swift code would be added automatically to the target the resources belong to.
- **Support for resources in libraries:** Libraries can't contain libraries, but we could enable that by generating a resources bundle and providing a Swift interface to access the resources from the right directory within the product bundle. I've seen projects workarounding this by having a build phase that copies the resources into the right directory. That's not easy to maintain though.
- **Shared manifest files:** One of the advantages of writing the manifests in Swift vs defining them in a Yaml is that we can leverage the Swift compiler to make things like reusing pieces of the manifest possible. Imagine adding more modules to your project is all about calling a function, `module(name: "Settings", dependencies: ["DesignKit"])` that is defined in a `Shared.swift`. That'd remove one of the biggest barriers when it comes to growing the number of modules of a project.

Stay tuned because those and more features will land soon in Tuist. If you would like to use Tuist in your projects or even contribute, you are welcome to do so. I'd gladly walk you through the project to have a solid understanding to start using it in your projects or contributing.

Have a great week!
