---
title: 'Zero cost abstractions'
categories: ['javascript', 'web', 'open-source']
---

A concept I recently came across while learning Rust is [_zero cost abstractions_](https://doc.rust-lang.org/stable/embedded-book/static-guarantees/zero-cost-abstractions.html). High-level programming languages like [Ruby](https://www.ruby-lang.org/en/) and [Javascript](https://en.wikipedia.org/wiki/JavaScript) abstract you away from low-level intricacies, but they do it at a cost, for example, performance. I think this is **a concept worth exploring in the context of web frameworks**, where many are providing great abstractions but with costs.

The one cost we’ve seen persisting across some modern frameworks and that I find particularly annoying is having to expose an API and deal with state client-side for the sake of having access to specific abstractions like [React’s](https://reactjs.org/). They are well-known [SPAs](https://en.wikipedia.org/wiki/Single-page_application). I don’t have anything against them. It’s simply that I don’t want to be writing an API when I could simply pass and consume data from the views, whether a view is a template or a React, [Vue](https://vuejs.org/), or [Svelte](https://svelte.dev/) component.
The hesitance of [Rails](https://rubyonrails.org/) developers towards adopting those abstractions is tied to their rejection of absorbing the cost and complexity that comes with it.

Fortunately, this is changing lately with frameworks like [NextJS](https://nextjs.org/), [Remix](https://remix.run/), [SvelteKit](https://kit.svelte.dev/), and [Astro](https://astro.build/). They all have in common that they leverage Javascript processors and bundlers to provide abstractions with zero cost. For years, the abstractions, mainly in the UI layer, have supported different rendering methods. However, embracing them in a project implied a lot of configuration and refinement on the user. They had to configure tools like [Webpack](https://webpack.js.org/) or [Vite](https://vitejs.dev/) to use the router and the components’ information to dynamically apply different rendering strategies. _Who wants to carry on the burden of maintaining such a setup? Wouldn’t it be great if a framework dealt with that for you?_

At [GestaltJS](https://github.com/gestaltjs), we are adopting an approach that builds upon ideas from the frameworks above to **minimize the costs of our abstractions**.

First, we take from Astro the idea of giving users **the option to choose their UI framework**. SvelteKit, NextJS, and Remix tied you to a specific framework that might not align with your team’s expertise.

From SvelteKit we are taking the idea of [**adapters**](https://kit.svelte.dev/docs#adapters) that give developers the flexibility to adapt their apps to their deployment strategy. _Do they want to go with a long-running server?_ Use that adapter. _Do they prefer functions to forget about scaling them up?_ There’s an adapter for that too. It’s ok believing that serverless is the future and push the technology beyond its limits, but the traditional model also has its upsides. By not supporting it, you might be leaving users out of your abstractions.

And last, we are taking from Remix and [InertiaJS](https://inertiajs.com/) the **rendering** approach that removes the need for dealing with API-exposed state client-side. The first page is server-side rendered, and after that, data is prefetched and used to initialize pages resulting in a very smooth navigation experience. Moreover, users will be able to specify if they want some pages to be static, and they’ll be generated at deployment time, for example, to serve from a [CDN](https://en.wikipedia.org/wiki/Content_delivery_network).

I believe in abstractions with zero cost, and **we’ll leverage Vite and Rollup to make that happen in GestaltJS.** It’s a significant undertaking because we’ll have to understand the internals of Javascript processors and treat them as compilers, but we are excited to explore this further.
