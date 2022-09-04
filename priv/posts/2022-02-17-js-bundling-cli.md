---
title: 'Thoughts around Javascript bundling in the context of a CLI'
categories: ['javascript', 'cli', 'dependencies']
---

I’ve always had this idea that one bundles Javascript to serve it in browsers that don’t support [ESM](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules) and in browsers that support it, to avoid many round-trips to the Internet. However, I recently realized that **bundling is also useful in the context of a CLI project**. Here are the reasons why.

First, the community is in this **transition state** where some packages only support [CommonJS](https://en.wikipedia.org/wiki/CommonJS), others only ESM, and a few both module systems. In theory, ES modules can import CommonJS, but it doesn’t work that well because packages don’t follow the [CommonJS conventions](https://nodejs.org/api/modules.html#modules-commonjs-modules). For example, using `.cjs` extensions or having a `main` attribute in the `package.json`. The bundling of your code alongside the external dependencies can output pure ESM and CJS bundles (as long as the CJS code is not using CJS-only features like dynamic requires).

Second, you **flatten the dependency graph into a single package**. When users install your CLI, they get a self-contained bundle that has everything it needs to run in it. We eliminate the installation of dependencies as a source of nondeterminism. This wouldn’t be necessary for other ecosystems like Ruby’s, where dependency graphs are less deep and fewer but larger dependencies are preferred over many but smaller packages. We reduce the likelihood of telling developers to delete `node_modules` hoping for the new installation of dependencies to yield a valid dependency graph.

And last but not least, **bundlers tree-shake the code**, meaning that what users will install is only the code that the CLI uses, nothing else. It’s important to note that the effectiveness of the tree-shaking is tied to the staticness of the code. If we use dependencies that use dynamic requires, the bundler might include the entire dependency.

[Gestalt](https://github.com/gestaltjs/gestalt) and the [Shopify CLI](https://github.com/shopify/shopify-cli) projects build upon this setup, which will positively impact the users. It’s taken a lot of tinkering with [Typescript](https://www.typescriptlang.org/), [Rollup](https://rollupjs.org/guide/en/), and [Nx](https://nx.dev/), but we seem to have found a setup that works incredibly well and plays nicely with VSCode. You can check [Gestalt’s repository](https://github.com/gestaltjs/gestalt) to see a tangible example.
