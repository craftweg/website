---
title: Thinking in terms of problems
categories: ['product development', 'developer tooling', 'software']
---

One of the things that I find the most challenging these days when building tools for developers is **thinking in terms of problems**.

Very often Tuist's users ask for features that they have seen in Xcode and that they'd like to see in Tuist too:
_is there support for script build phases?_ or _can I run a command right after generating the project?_
It's temptin to say that we don't support it,
but that we can add support for it.
However we'd end up with the same concepts and complexities that motivated them to use Tuist.

The approach that I take instead is aking them **whys:**
_why do you need a script build phase_ or _why do you need to add this build setting?_
Thanks to this,
we have been able to simplify some of Xcode's complexities like defining dependencies.
If we understand what are users' motivations,
we can provide them with simpler and more optimized solutions.
And this is something that excites me a lot about the way we are building Tuist.
It's all about helping teams with the challenges that the face.
The **how** is up to us to figure out.

For example,
I know that one of the challenges that teams face is **slow builds.**
Some teams went straight into adopting build systems like Bazel or Buck because they saw that's something that worked for other companies.
However,
they might have not realized that the fact that it worked for them doesn't mean that it'll work for them too.
This often leads to teams going too deep into rabbit holes,
or what's worse,
introducing layers of complexities that make projects hard to maintain and work with.
If you have seen projects using CocoaPods, Carthage, and the Swift Package Manager for managing dependencies, you probably know what I'm talking about.

As one of the maintainers of Tuist,
one of the roles that I set for myself is evangelizing this idea on how to build tools.
**I'd love them to think of Tuist as a product**;
a product that solves concrete problems that we understand well.
If we want to build something that developers love to use,
we need to understand why we are building it in the first place.

- **We built updates into Tuist** because the existing solution for managing the installation of system dependencies _(e.g. Homebrew)_ might yield non-deterministic results that cause frustrations to developers.
- **We built project generation** because Xcode difficults defining a modular project consistently, which is crucial for sharing code and keeping build times low with architectures like uFeatures.
- **We are adding cache** because developers use ⌘+K often and end up wasting a lot of time doing clean builds with Xcode.
- **We are adding automation** because Fastlane's approach in practice result in large and complex `Fastfiles` that are hard to maintain.
- **We are synthesizing interfaces for resources** to prevent runtime errors when accessing non-existing resources.

If you are also working on tools for developers,
I'd recommend adopting this mindset.
Listen to your users,
understand their needs,
and build the best solution for them.
Resist the temptation of building just what they ask for.
