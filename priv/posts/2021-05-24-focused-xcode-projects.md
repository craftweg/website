---
title: Focused Xcode projects
tags: ['tuist', 'open-source']
---

A while ago,
and inspired by Facebook's internal tooling,
we added a new command to Tuist, `tuist focus`.
As it names says,
it's intended to be used when you want to work on a given target.
If you have a project of,
let's say 300 targets,
you don't want all of them when you open the project with Xcode.
_The reason?_
It makes Xcode slower.
The more you open, the more needs to be indexed.
You change a file,
and Xcode needs to figure out how the change impacts the whole project.

Focus takes your project's dependency graph,
and prunes the elements that are not necessary for you to work on target X.
That includes references from schemes.
Since there are times when you might want to focus on more than one target at once,
you can pass the list of targets as arguments: `tuist focus MyApp Search`.
But that's not all.
We integrated this concept with the caching of target binaries.
In a nutshell,
the direct and transitive dependencies of your focused targets are replaced with their binary representation.
The binary can come from a local cache,
and soon,
from a server-side counterpart, [TuistLab](https://github.com/tuist/lab).
Amazing,
isn't it?
This is what I've been hoping to see landing in Xcode,
but instead,
we've been told that the only solution is to replace Xcode's build system with [Bazel](https://bazel.build/).
I don't have anything against Bazel.
I think it's damn amazing.
But it's not compatible with Apple's way of building tools,
and because the integration leads to a bad developer experience,
or good but with a huge ongoing investment,
I avoid it.

Surprisingly,
and as the [stats](https://stats.tuist.io) show,
`tuist focus` is not as used as `tuist generate`.
It's hard to know the why,
but my guess is that this is a workflow that developers are not that used to,
and it requires some ongoing education and evangelization from our side.
_Or maybe there's something not working as expected and we don't know?_
If that's the case we'll soon find out because we are dog-fooding Tuist by building TuistLab.

As I mentioned in past blog posts,
the opportunity to explore ideas with Tuist is what makes the project so exciting,
and `tuist focus` is a good example of that.
If you are using Tuist,
I recommend you to give the command a shot.
You won't get disappointed.
