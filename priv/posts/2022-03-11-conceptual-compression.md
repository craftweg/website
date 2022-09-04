---
title: 'Conceptual compression in web frameworks'
categories: ['javascript', 'gestaltjs', 'open-source']
---

I ask myself a lot these days while forming ideas for [GestaltJS](https://github.com/gestaltjs/gestalt) is the intricacies users don’t need to be exposed to when building apps. DHH calls it [conceptual compression](https://m.signalvnoise.com/conceptual-compression-means-beginners-dont-need-to-know-sql-hallelujah/).
He uses SQL as an example: _who wants to be writing SQL queries manually these days?_
Most developers don't want to,
and that's the reason why ORMs like [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html) and [Prisma](https://www.prisma.io/) exist.
The good thing about conceptual compression is that it's an onion;
if you need to, you can peel layers from it and write SQL queries.

I think Javascript **build tools like Vite has become so powerful** that there's a huge opportunity to conceptually compress more intricacies.
One example that keeps coming to my mind, and I believe [Remix](https://remix.run/) has nailed, is the interaction between the frontend and backend.
They blurred the gap between both domains to the point that you no longer think about working on both sides,
but rather,
you work on an app.
It's beautiful, and we'll take a lot of inspiration from it for GestaltJS.
You build endpoints, some of which return data and some others UI.
You don't need to deal with state or coordinate data loading and absorb all the complexity that comes with it.
**It's all conceptually compressed**.
The server is an implementation detail.

Conceptually compression is also a fantastic tool in a world where there's a lot of innovation in the infrastructure (e.g. [Cloudflare workers](https://workers.cloudflare.com/)) and the Javascript runtimes (e.g. [Deno](https://deno.land/)).
The build system becomes an **interpreter that adapts a project to different runtimes and deployment solutions**.
[SvelteKit](https://kit.svelte.dev/docs/adapters) was one of the first frameworks to explore this idea, and [Remix](https://remix.run/docs/en/v1/other-api/adapter) followed.

I'm excited to see frameworks moving in this direction because it means simplicity for the users.
If we want to lower the entry barrier to the web,
we need more experiences with low cognitive load and more fun experiences.
Conceptual compression plays a vital role in that.
