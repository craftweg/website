---
title: "Incremental Xcode workflows across environments"
description: "Xcode struggles to achieve incremental builds within the same environment. What about across environments? Not even close. Tuist is working on bringing incremental builds and test execution to Xcode projects across environments."
tags: ["Xcode", "Apple", "Tuist"]
---

[Incremental compilations](https://en.wikipedia.org/wiki/Incremental_compiler) are the build-systems' answer to speed up the development cycle.
Some like [Bazel](https://bazel.build) are able to span the incrementallity across environments.
But what about Xcode build system?
They struggle even to achieve it within the same environment.
The reason?
[Xcode is too magic](/blog/2024/01/24/xcode-is-too-magic).
There's some [work happening](https://github.com/apple/swift-driver/pulls?q=%5BCaching%5D),
to improve the situation at the `swift-driver` level, but they are far from what Bazel can achieve.

Luckily,
we have an excellent foundation in [Tuist](https://tuist.io) to tackle that.
The first thing that we built was **binary-caching**,
which skips some compilation steps.
[Tuist Cloud](https://tuist.io/cloud) is a service that spans that incrementality across environments.
The second feature that we landed to take that incrementality to the next level is **selective testing**.
Leveraging the same hashing solution that we use for binary caching, we can run only the test targets that are impacted by the changes.
The **combination of binary caching and selective testing** can cut CI times quite significantly.
But we are not done yet,
we are going to **bring binary caching** to the `tuist build` workflow too.
And, last but not least, we are going to skip the dependency resolution via Swift Package Manager,
which can easily add a pair of minutes to every CI build.

The best of all?
It's built into Tuist.
If your project is described using Tuist's DSL, you get all of the above right away.

```language-bash
tuist cache # Warm the cache with binaries
tuist fetch # Fetch dependencies from the cache (seconds)
tuist test # Use selective testing and binary caching
tuist build # Use cache binaries
```

We are working hard on providing organizations with the best balance between convenience and performance.
