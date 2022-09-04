---
title: 'Rendering and deployment plumbing'
categories: ['javascript', 'gestaltjs', 'open-source']
---

I noticed that some web frameworks **force users onto a particular rendering method** for their app routes, even if it’s not the most suitable option for the app they are trying to build. For example, they might require you to render client-side and build a [SPA](https://en.wikipedia.org/wiki/Single-page_application) that reads and manages a state from an API. Perhaps writing an API was not in your plans, but all of a sudden, it is. It’s the cost you need to pay to get the other benefits of the framework.

A **framework should be opinionated** when opinions lead to high value for the users and help them scale up their projects without much work. When we are opinionated about the rendering strategy, we might complicate things for the users. Take a framework that does CSR. A user using the framework might need to implement some static pages, but they can’t because the framework they settled on is geared towards SPA apps. _How do you then port over some of your abstractions and UI blocks onto your static pages?_ Some users bring another framework to the table; others venture into doing some plumbing themselves and carry on with the maintenance burden.

For [GestaltJS](https://github.com/gestaltjs), we are pondering absorbing the complexity of **supporting all the rendering options to give the users the flexibility they need**. In particular, we are thinking about the following abstraction that builds upon ideas from [Remix](https://remix.run/) and [SvelteKit](https://kit.svelte.dev/):

```
routes/
  blog.static.{jsx,tsx,vue,svelte}
  blog.data.{ts,js}
  about.server.{jsx,tsx,vue,svelte}
  admin/
    index.client.{jsx,tsx,vue,svelte}
  app/
    index.dynamic.{jsx,tsx,vue,svelte}
```

Routes specify the rendering strategy through the extension — client, server, static, or dynamic. **Dynamic rendering** leaves it up to the framework to decide the rendering. If it’s the first route loaded by the user, it’ll SSR for quick load, but if the user navigates to it from another route, it might just serve the data that’s then hooked into the route component client-side. Note that there are `.data.{js,ts}` files that are responsible for fetching the data that becomes the input of the rendered page. When a page is loaded client-side, the framework preloads and serves the data for smooth navigation and minimum work on your end. Frameworks Remix already do this, but their APIs are coupled to [React](https://reactjs.org/) (e.g. using hooks). We want to **provide a generic solution independent of the UI framework**.

A similar train of thought goes to **the deployment method**. Some frameworks bet strongly on a deployment solution. Edge computing is exciting, and it keeps getting better, but it might not be what I need for my project. I might want to have more control over the cloud resources using [Kubernetes](https://kubernetes.io/). In that scenario, I expect the framework and its internal build pipeline to help me adapt the app to the deployment target; ideally, without telling me to follow a set of manual steps to execute something that looks more like a hack instead of a proper solution.

**Build tools and systems have got incredibly good**,
and we can leverage them to [conceptually compress the complexity](https://m.signalvnoise.com/conceptual-compression-means-beginners-dont-need-to-know-sql-hallelujah/) of accommodating an app for its deployment.
We need to take in a lot of complexity, but users will be thankful for that.
Imagine a user of the framework encountering a limitation with [Cloudflare workers](https://workers.cloudflare.com/) and deciding to move to a NodeJS server deployed with Kubernetes. It should be possible with only a few changes.
We are aiming to build build this flexibility into GestaltJS,
and we’ll heavily take inspiration from SvelteKit and [their adapters](https://kit.svelte.dev/docs/adapters#community-adapters).

I love **understanding complexity to build tools that are easy to use**.
Gestalt will be one of those tools.
We’ll have opinions, but we provide value in those places and don’t get into users’ way.
We want to be there when people are just getting started and when they’ve reached a particular scale and are presented with new challenges.
