---
title: 'My first open-source Svelte component, svelte-scroll-progress-bar'
categories: ['open-source', 'svelte', 'components']
---

I've developed and open-sourced my first Svelte component, [svelte-scroll-progress-bar](https://github.com/pepicrft/svelte-scroll-progress-bar), a component for showing a bar at the top of a page that reflects the scroll's percentage.
SvelteKit has built-in support for [packaging](https://kit.svelte.dev/docs#packaging), which makes the procress very straightfoward. All you need to do is to run the `package` command and the framework will export everything under `src/lib`.
The command creates a `package` directory that you can directly publish to the [NPM registry](https://www.npmjs.com/).
Because the project is a SvelteKit app, you can add pages to `src/routes` to preview the component.
For instance, a preview of this component is available [here](https://svelte-scroll-progress-bar.pepicrft.com/).

Kudos to [Noman](https://github.com/NomanGul), whose project, [](https://github.com/NomanGul/svelte-page-progress), has been a great inspiration and reference to implement svelte-scroll-progress-bar.
