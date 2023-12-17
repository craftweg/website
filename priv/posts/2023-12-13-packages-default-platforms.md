---
title: "Swift Packages default to supporting all platforms"
description: "Swift Package Manager defaults to supporting all platforms when they don't specify any. This is a problem for tooling like Tuist that integrates Swift Packages as Xcode project targets."
tags: ["Swift", "Packages", "Xcode"]
---

**Did you know that Swift Packages default to supporting all platforms when they don't specify any?**
We, at [Tuist](https://tuist.io),
didn't know either until we added support recently for multi-platform targets.
Tuist integrates Swift Packages as Xcode project targets that give users more control over them and allow optimizations.
By the way, kudos to [Mike Simons](https://github.com/waltflanagan) for the amazing work on this one.

Because Swift Package targets have now multiple platforms,
we included the platforms that the Swift Package Manager indicates that are supported.
And that works,
until it turns out that a given package doesn't support a platform that they seemingly support (at least according to the defaults).
In that case, Xcode fails to compile the target.
To overcome the issue and eliminate blocks for users,
we started adding code like `if 'Firebase'`...
but that would not scale so we needed to do something about it.

Because Tuist knows the dependency graph,
we cascade the platform of the project targets down to the dependencies.
For example,
if the upstream targets compile for iOS,
we can narrow down the list of supported platforms for dependencies to iOS.
I believe this is something that Xcode must be doing under the hood.
The difference with Xcode is that they do it at build time and we do it at generation time.

This shows that assuming that a package supports all platforms by default was not a good idea.
Especially when giving support for multiple platforms was not trivial due to inconsistent APIs across Apple and other platforms like Linux.
This will hopefully change soon with the new era of `Foundation`,
but until then,
Xcode and tooling like Tuist will have to forever deal with this decision.

Please, if you are a package maintainer,
**make sure you are very explicit about the platforms that you support and that you validate that through CI**.
You'll be making a great favor to the community and to the tooling that depends on your package.
