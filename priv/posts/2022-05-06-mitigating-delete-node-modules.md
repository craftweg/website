---
title: "Mitigating 'delete node_modules'"
categories: ['javascript', 'open-source', 'tooling']
---

If you've worked in the Javascript ecosystem, you might already be familiar with the *"delete node_modules"* solution commonly suggested on [StackOverflow](https://stackoverflow.com/) and GitHub Issues. People make fun of it, but it's a frustrating scenario that ruins the developer's experience using a tool or a framework.

After immersed me in the Javascript ecosystem as part of my work at [Shopify](https://shopify.com/) and on [Gestalt](https://gestaltjs.org/), I understood better what leads to this scenario. It's the combination of an ecosystem favoring **many small packages over fewer but larger ones** and the reliance on humans to follow [semantic versioning](https://semver.org/) from their packages. When one out of thousand packages introduces breaking changes that are not reflected by the version of the package, that causes the contract with other nodes in the graph to break, and the broken contract often surfaces as a broken workflow for the user.

A **solution** to this problem would come down to having smaller dependency graphs and having more acceptance tests in packages that can manifest breaking changes on CI, but that's unfortunately not an overnight change considering the size of the ecosystem. Because of that, in Gestalt, we decided to defend ourselves against sources of non-determinism like that one. We did so by leveraging the bundling process through Rollup. I know this sounds weird if you are used to using bundlers to optimize the artifact that's served to the user, but believe me, it plays a crucial role in improving the experience for Gestalt users.

Our packages have their external dependencies as **devDependencies**. The versions are pinned through [Gestalt's lock file](https://github.com/gestaltjs/gestalt/blob/main/pnpm-lock.yaml). They are [tree-shaked](https://webpack.js.org/guides/tree-shaking/) and bundled as part of the bundle of the package, and that's the bundle that we use for running our e2e tests, including in the NPM package that users install. If the bundle passes our e2e tests, it'll work as expected on the user side. We make exceptions for mature dependencies and have solid test suites because we have a higher trust in their usage of semantic versioning.

We've been using [Rollup](https://rollupjs.org/) for bundling, and we couldn't be happier with it. It also helps transform CJS dependencies that we can't interoperate with because they don't follow the Node conventions. [Here's](https://github.com/gestaltjs/gestalt/blob/main/packages/core/rollup.config.js) an example of the configuration used for bundling the *@gestaltjs/core* package.

Every tiny detail can have a significant impact on the developers' experience. Therefore we can't embrace "delete node_modules" as it is what it is when there are strategies we can adopt to minimize it.
