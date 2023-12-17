---
title: A standard CLI for Xcode projects
tags: [tuist, open source, swift, xcode, project generation]
---

There’s an idea that I’d love [Tuist](https://tuist.io) to move towards: provide a CLI that is standard across all the projects defined using Tuist.
This is not a new idea;
we can see it in frameworks like [Rails](https://rubyonrails.org) that thanks to being opinionated about the structure of the projects they can be opinionated about the CLI that users interact with most of the time.
We can also see it in the [Swift Package Managers](https://swift.org/package-manager/),
which is also opinionated about the structure of the packages.

What I find beautiful about this idea are **2 things**:

- Developers don’t need to maintain a translation layer like Fastlane that maps intents to calls to Apple tools.
  This often becomes a common source of issues and complexity in projects.
- They can learn a concise list of commands that they can use to interact with any project defined with Tuist.

My motivation for building new features into Tuist usually comes from trying to iron out some inconveniences,
or creating new workflows as I'd like them to be.
For instance,
implementing project generation in Tuist embracing Swift as an interface language and abstracting the definition of dependencies was motivated by the fact that having more Xcode projects at [SoundCloud](https://soundcloud.com) was becoming painful and error-prone.
I implemented an API for describing dependencies that was simple and understandable by anyone.

It's a similar scenario when it comes to automation.
The industry accepted [Fastlane](https://fastlane.tools) as the go-to solution to define a CLI for projects.
It does a really good job,
and we owe a lot to it,
but I used at scale results in a lot of duplication and complexity spread across Fastfiles that no one wants to maintain.
For that reason,
I think Tuist could go one step further and make things simpler leveraging project generation and the foundation that we have built.
The way I picture myself as developer working in a large project is the following:

> I'd cd into the directory that contains the project that I plan to work on. `tuist focus` would give me an Xcode project that I can use to edit the code, and I can use `tuist build`, `tuist test`, and `tuist lint` to make sure that the code does what's supposed to do and that it follows the styling conventions.

As simple as that.
I can go to any directory that contains a `Project.swift` file,
and run any of those commands knowing that Tuist will know how to proceed.

I'm so excited for this that today I put the [first stone](https://github.com/tuist/tuist/pull/1019) towards this vision.
