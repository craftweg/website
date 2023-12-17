---
title: "3 package managers + 2 build tools = One big mess "
description: "I shared a bit of a reflection on what are the issues with current Apple's tooling touching on some of the points that I presented in my Swiftable 2023 talk."
tags: ['Tuist', 'Xcode', 'Swift Package Manager']
---

As you know,
I've dedicated the past 6 years to overcoming the challenges of using Xcode at scale.
That was the theme of my recent talk at Swiftable, [From challenge to joy: My journey developing Tuist for scalable Xcode Projects](https://speakerdeck.com/pepibumur/from-challenge-to-joy-my-journey-developing-tuist-for-scalable-xcode-projects).
The more I dive into this topic,
work on it,
and talk with developers about it,
I realize in which difficult spot Apple finds itself.

Xcode builds on the Xcode build system, which works with Xcode project files.
As the environment changed and things became more complex,
Xcode project files were stretched beyond their limits and presented developers with a lot of challenges.
Some examples of those are frequent Git conflicts,
invalid dependency imports implicitly resolved, and frequent clean builds that make developers lose their time.
This is the day-to-day of many developers,
or at least it was and is mine when I use Xcode with a modular project.

**Apple failed to evolve the project files and the build system that builds on it.**

They left the community with only one API to overcome challenges:
project generation.
This is not great and tells a lot about the foundation.
[CocoaPods](https://cocoapods.org) pioneered this approach,
and then project generations like [XcodeGen](https://github.com/yonaskolb/XcodeGen) and [Tuist](https://tuist.io) followed.
Most recently developers started to use the Swift Package Manager,
which Apple integrated tightly with Xcode,
to overcome the most pressing challenge,
frequent Git conflicts.

But the matter has gotten worse.
We have now a fragmentation of dependency management solutions,
and many organizations are struggling to move from CocoaPods because it provides a level of extensibility and configurability that the Swift Package Manager doesn't.
The same implicitness that Xcode had,
and that caused many problems to developers,
is now making its way to the Swift Package Manager,
like the "automatic" linking mode that Swift Packages now has.
Since when is the build system's responsibility to decide the linking of a dependency?
Optimizations?
Not even think about them.
It's Apple's responsibility.
If the integration with the Swift Package Manager is suboptimal,
you have to wait for Apple to fix it.
I'm sorry, but this is too bad.

**Apple built a package manager and faced a community using it as a project manager because they were tired of Xcode project issues.**

Apple is now in a difficult spot,
but one they could move from with support from the community and a clear vision.
I think they've reached a point where they need to go back to first principles and evaluate the foundations of the platform.
Is it time to evolve everything that's around the Xcode project files?
I think so.
It's time for the build system to be something closer to what Gradle or Bazel are.
A build system that's deterministic, configurable, optimizable, extensible, and overall, easy to reason about.
If the convenience that they need for the people getting started is a concern,
they can always build a layer of convenience on top of low-level primitives.
Android has done that with Gradle.
You drop a plugin, and that takes care of everything for you.
And if you need to,
you can peel layers of complexity.

But there are no signs of that happening.
Chatting with developers at the Swiftable conference,
I noticed that developers are more confused than ever.
They want to use the official tools,
but while doing so they realize that they add more complexity and challenges to their problems.
It's positive for [Tuist](https://tuist.io),
because it's a huge opportunity for us to help them,
but I feel really bad for those development environments that are not fun to work in.
I was in one of them,
and you know what leadership decided to do?
Move away from native development to [React Native](https://reactnative.dev).
Simply because leadership doesn't understand that you need to wait an entire year to hopefully have Apple fixing the productivity problems.
It's bizarre when looked at from the productivity angle.

I know put a `Project.swift` next to every package or in every new project that I create.
Why?
Because the productivity levels that Tuist provides are unmatched.
If you haven't tried,
I encourage you to do so.
You can clone the Tuist repository and play with it.
Hopefully,
there'll be one day where we won't need project generation anymore,
and we can move our optimizations to a more sophisticated build system.
But until then,
project generation is our answer, and it works damn great.
