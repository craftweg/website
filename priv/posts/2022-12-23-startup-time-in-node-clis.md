---
title: Static imports with ESM and startup time
description:
tags: [node, javascript]
---

When building a [Command-line interface (CLI)](https://en.wikipedia.org/wiki/Command-line_interface) with Javascript and [ESM](https://hacks.mozilla.org/2018/03/es-modules-a-cartoon-deep-dive/) to run on [NodeJS](https://nodejs.org/en/),
one can end up with a CLI that's slow to launch (above hundreds of milliseconds).
It's common for developers to use static imports at the top of the source files:

```language-js
import { groupBy } from "lodash-es"
```

Those imports form a module graph that **needs to be loaded before any code gets executed**.
And because loading a graph entails doing IO and in-memory parsing operations,
some of which can be parallelized,
there's a **strong correlation between the size of the graph and the time it takes to load.**
It's indeed one of the reasons,
among others,
why developers choose Rust or Go as programming languages to implement their CLIs.
Compilers statically link all the code and the startup time is insignificant.

Note that the problem goes away when working on a client-side rendered app because bundling tools smash all the modules into a single or handful of modules.
[Vite](https://vitejs.dev/) embraces ESM in development but does some bundling-based optimizations with third-party dependencies.
In the case of web servers (e.g., Express-based HTTP server) or SPAs,
the startup time also gets impacted,
but additional seconds during deployment don't impact the developer experience significantly.
Orchestrators like Kubernetes wait until the server runs to send traffic to it.

**What can we do about this?**
You can remain with [CommonJS](https://en.wikipedia.org/wiki/CommonJS), although I'd advise not to.
ESM is the standard, and more NPM packages are making it their default.
CommonJS works synchronously and doesn't have to wait for the whole graph to load to start executing code.
First, I recommend **minimizing the number of dependencies** of your project.
It is also suitable for security and graph determinism at installation time.
If you need to add a dependency, check how they export modules.
If they have a single export from where you import everything,
then use dynamic imports:

```language-js
// Static import
import { bar } from "bar"

async function foo() {
  // Dynamic import
  const bar = await import("bar")
}
```

The best scenario is the dependencies using [subpath exports](https://nodejs.org/api/packages.html#subpath-exports),
meaning that you only import what you need.
However, few dependencies in the ecosystem are designed this way, so it's rare to come across one.
As a last resource, you can introduce a compiler that can tree-shake external dependencies and delete unused code.
However,
code transformation might output Javascript code that blows up at runtime,
so you'll have to invest in integration tests.
