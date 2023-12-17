---
title: An explicit build graph with Nx for a better DX
description:
tags: [nx, javascript, workspaces]
---

When I started doing Javascript more actively,
something that got my attention was the absence of a build system that allowed declaring a build graph explicitly.
Most of the time, developers combine `package.json` scripts with shell operators:

```language-json
{
    "scripts": {
        "clean": "rimraf dist/",
        "build": "pnpm clean && tsc"
    }
}
```

The above setup is standard across Javascript tasks.
A task for cleaning the output directory, `clean`,
and another to output Javascript from the Typescript source code,
`build`,
which **depends on** `clean`.
Because `package.json`'s `scripts` section doesn't have the notion of dependencies,
developers have to resort to workarounds like using `&&`:
_Do clean, and if it succeeds, build._

Defining dependencies that way works if the project is small.
However,
if a project gets larger and automation more complex,
the dependency graph will inevitably be hard to reason about, hindering contribution to the project.

Luckily when I started working on [GestaltJS](https://github.com/gestaltjs)
I came across the [Nx](https://nx.dev/) build system,
which solves the above problem beautifully.
Their approach was not new to me since the problem they are solving and how they are solving it is something that I had to do for Xcode projects in [Tuist](https://tuist.io).
You have a bunch of interdependent modules that a developer can interact with (e.g., test, build, lint),
and you want the information to be codified in a graph that can be leveraged to introduce optimizations.

Some minds behind Nx are ex-Googlers that had the chance to work on Google's build system, [Bazel](https://bazel.build/).
Unlike Bazel, which has a steep learning curve,
and you have to learn a Python-like syntax,
Nx is extremely easy to get started and add to an existing project.
The developer experience (DX) is top-notch.

Once the tasks and the dependencies are declared,
you have access to a whole set of tools that can save you a lot of time.
One of them is **incremental builds** and being able to run tasks only for the [affected packages](https://nx.dev/concepts/affected). How cool is that?
They can also cache task outputs across local and remote builds.
It reminds me so much of the work we had to do to bring caching to Tuist.
You also get a [**graph**](https://nx.dev/core-features/explore-graph) command to visualize the automation dependency graph.
So no more navigating across `package.json` files to understand how tasks are interconnected.

I'd recommend giving the tool a shot if you have a workspace.
[Shopify's CLI](https://github.com/Shopify/cli/blob/main/nx.json) has also had Nx set up since the project was created,
and it's been a wonderful experience so far.
We haven't had any issues with the tool,
and it keeps improving with every release.

**Nx is one of my references when devising iterations for the Shopify CLI**
