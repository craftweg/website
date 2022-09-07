---
title: "Laying out a software project foundation"
excerpt: "In this blog post I share my thoughts around the role that a foundation plays in a new software project and give some concrete examples in the context of the Gestalt framework."
categories: ['gestalt', 'open source']
---

When starting a software project, I like to spend time defining mental models, principles, and ideas that I codify into a code foundation. It’s a project phase where it’s better not to take shortcuts because everything else will build upon it. When a project lacks a foundation or is poorly designed, it indirectly impacts the software users.

In Gestalt, the foundation is [`@gestaltjs/core`](https://github.com/gestaltjs/gestalt/tree/main/packages/core), and I’m spending a fair amount of time in it. Because the framework builds upon [Node](https://nodejs.org/en/), spending time in the foundation becomes even more critical for a few reasons:

- APIs behave inconsistently across OSs and Node versions. I can’t prevent it from happening, but I can mitigate them quickly if features don’t consume Node APIs directly.
- APIs are also inconsistently designed, which negatively impacts the experience by contributing new features and improvements. I want contributors to work with APIs that are a joy to use.
- With new runtimes being released (e.g., [Bun](https://bun.sh/), [Deno](https://deno.land/)) and the fast-paced Javascript ecosystem, the framework is part of it’s crucial that we can adapt quickly.

The **foundation** prevents dependencies on runtimes and external dependencies from scattering throughout the repo. They make it tedious to support new runtimes or replace dependencies without resorting to [module shimming](https://github.com/guybedford/es-module-shims).
As part of this effort, I’m also coming up with models to represent modules in memory. I’ve seen projects working directly at the build-tool level with Javascript modules without having the notion of what a *project* is, and that also leads to logic that’s hard to reason about and optimize. That won’t be the case in [Gestalt](https://gestaltjs.org). At [Tuist](https://tuist.io), I did the same. Thanks to it, we could provide local and remote caching and other optimizations that wouldn’t have been possible without that in-memory representation of projects.
