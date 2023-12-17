---
title: "Modular projects, Typescript, and developer experience"
tags: ['typescript', 'developer experience', 'modularity']
---

Have you tried to set up a modular Typescript project with multiple NPM packages?
It's painful.
Typescript tried to solve that with [project references](https://www.typescriptlang.org/docs/handbook/project-references.html),
an API to declare the project graph to Typescript for it to build the packages in the correct order.
Still,
it presents a terrible developer experience (DX) editing the code.
It's widespread,
especially when the project is in a clean state (i.e., `dist/` not populated with Javascript and definition files),
that the language server protocol can't find interfaces.
One can mitigate the issue by calling `tsc` to emit declaration files,
but they get outdated as soon as you start changing the public interfaces across packages.

The **solution** we adopted on the new [Shopify CLI](https://github.com/shopify/cli) and [Gestalt](https://github.com/gestaltjs/gestalt) is using the [paths](https://www.typescriptlang.org/tsconfig#paths) option in the `tsconfig.json` file.
The API is intended to be used for re-mapping imports within a particular module,
but it also works to define aliases cross packages.
[Here](https://github.com/Shopify/cli/blob/main/configurations/tsconfig.json#L17) is an example of how we use them in the Shopify CLI.
Thanks to it, Typescript can resolve cross-package typed contracts instantly.
Note that when transpiling or bundling the code of each package,
you'll need to tell the build tool to treat those imports as external dependencies and leave them as they are.
[Here](https://github.com/Shopify/cli/blob/main/configurations/rollup.config.js#L13) is an example of how we do it for [Rollup](https://rollupjs.org).

One **caveat** of the above approach is that since the Typescript configuration is static,
you won't be able to extract the aliasing configuration and share it across Typescript and build tools.
This means you'll end up with various sources of truth for the same information.
I hope that Typescript allows the configuration to be more dynamic through a Javascript-based interface.

If you run into a similar use case,
I hope you find the setup described in this blog post helpful.
Also,
if you know another strategy that works better than this one, I'd love to know about it.

Happy Typescripting!
