---
title: "Meeting developers where they are"
description: "In this blog post I reflect on why I believe not more organizations are adopting Bazel and why Tuist is taking a different approach."
tags: ["Bazel", "Tuist"]
---

I've been thinking a lot lately about how Tuist compares to [Bazel](https://bazel.build),
a build system commonly used by large enterprises that face scaling issues with Xcode.
Using Bazel reminds me [Nix](https://nixos.org/).
The theory behind them is astounding.
They are an engineering masterpiece.
However,
I don't find any joy in using them.
I'll try to unpack why.

Ecosystems traditionally have their default or broadly adopted build systems.
Android has [Gradle](https://gradle.org/),
the JavaScript ecosystem has [Vite](https://vitejs.dev/) (among many others),
and the Swift ecosystem has Xcode's build system.
They might not be as advanced as Bazel,
but over the years,
they defined building blocks, mental models, and extensibility APIs upon which ecosystems have been built.
Vite is a great example of the latter.
Extending the build system is as easy as adding a plugin,
usually distributed as an NPM package,
and adding one line to the configuration file.

When you use Bazel,
you are trading off not only the ecosystem of tools,
but very likely a lot of ideas, patterns, and resources from the community.
This is a big deal that can't be underestimated.
If the community innovates in a particular direction,
you might not be able to leverage that innovation because you are using a different build system.
Oftentimes, you have to port those ideas over to Bazel yourself or wait for someone to do it for you.
In an ideal world,
everyone uses Bazel,
and everyone innovates on the same foundation,
but how likely is that to happen?
Very unlikely I'd say.
I believe this explains why many organizations remain hesitant to adopt Bazel.
Put differently,
the few that adopt it, are because they adopt it across the board and therefore the cost is more justified.

My stance,
and also Tuist's stance,
is that we embrace the limitations of existing build systems,
and try to innovate within those constraints.
By doing so,
we don't disrupt organizations' workflows,
and they are still able to leverage the community's innovations.
Moreover, we also meet developers where they are by embracing elements that are familiar to them.
For example,
we purposely chose [Swift](https://www.swift.org/) over something like [Starlark](https://bazel.build/rules/language) to describe projects.
It might seem like a subtle thing, but it's not.
Developers love using Swift and Xcode, so why not leverage that?
We also reused the same concepts that Xcode uses: schemes, targets, build settings...
Why push a new language onto them if the existing one works?
When you combine all these elements,
then organizations find a tool that's a joy to use.
Sure,
it won't reach the level of sophistication of a build system like Bazel,
which has been battle-tested by Google and many other companies across various tech stacks,
but it provides organizations with the right trade-offs.

I strongly believe that problems should not only be looked at from a technical perspective.
Ecosystems have opinions, trends, and communities, that can either be embraced and integrated with, or ignored.
Doing the latter often leads to a tool that's technically superior but people don't want to use.
