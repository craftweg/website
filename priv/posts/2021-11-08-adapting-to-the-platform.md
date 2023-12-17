---
title: 'Adapting to a platform'
tags: ['netlify', 'sveltekit', 'deployment', 'developer tooling']
---

In a simplistic way,
we can see web frameworks as convenient **functions** that take your app as input and return deployable artifacts.
[GatsbyJS](https://www.gatsbyjs.com/) generates static HTML, CSS, and Javascript that platforms like [Netlify](https://netlify.com) know how to deploy.
[Rails](https://rubyonrails.org/) generates static assets and provides an entry point to run a process on a platform like [Heroku](https://heroku.com).
Note that the artifacts need to be **adapted** to the deployment target.
Heroku does it through [buildpacks](https://devcenter.heroku.com/articles/buildpacks) and [Procfiles](https://devcenter.heroku.com/articles/procfile) that instruct the platform on building and running a server.
Netlify achieves the same through a [configuration file](https://docs.netlify.com/configure-builds/file-based-configuration/) where developers describe how to build and deploy their websites.
Traditionally, the adaptation process has either fallen on the platform or developers’ sides (e.g. through a CI deployment pipeline)

**What if frameworks have adaptation as a built-in primitive?**
That's what SvelteKit provides through [Adapters](https://kit.svelte.dev/docs#adapters).
It's an API for third-party developers to define how to adapt a SvelteKit app to different hosting providers.
For example, the [netlify-adapter](https://github.com/sveltejs/kit/tree/master/packages/adapter-netlify) adapts the output to Netlify and does things like turning endpoints and SSR pages into functions that run on-demand.
Because the framework allows [SSR](https://developers.google.com/web/updates/2019/02/rendering-on-the-web#server-rendering), [CSR](https://developers.google.com/web/updates/2019/02/rendering-on-the-web#csr), and [static rendering](https://developers.google.com/web/updates/2019/02/rendering-on-the-web#static-rendering),
a SvelteKit project can contain the web app, documentation website, and marketing and landing pages.
Cool? Isn't it.
Adapters decouple the deployment platform from the framework to prevent [vendor-locking](/2021/11/08/open-source-vendor-locking).

I’m still new to the framework, but I think its concepts are powerful, and adapters are an excellent example of that.
