---
title: 'Open source vendor-locking'
categories: ['open source', 'svelte', 'vercel', 'nextjs']
---

A pattern I’ve been noticing a lot recently in the industry is investors-backed (and often Silicon Valley-based) companies using open-source to vendor-lock people into their products. We’ve seen [Vercel](https://vercel.com/) doing that through [NextJS](https://nextjs.org/), [Expo](https://expo.dev/) through [React Native](https://reactnative.dev/), and even [Microsoft](https://www.microsoft.com/) through [GitHub](https://github.com).

Is the pattern negative for the industry? Not necessarily. Private investment often leads to innovation. We are seeing that a lot with Vercel and the developer experiences that they are creating. I have to say I was mind-blown while watching Vercel’s [recent conference](https://nextjs.org/conf). The problem comes when we **forget the standards we are building upon**, and thus we don’t contribute back to them, or not as much as they could. I believe this is important because the day a company fails to achieve its mission and reach investors’ goals, they can die, and we’ll be happy to have their innovation codified in the standards.

We could say that building in the open is a way to contribute, but if the project is designed with a strong coupling to a closed-sourced platform, then it’s something half-good. NextJS’ DX shines but shines more when deployed to Vercel. Swift is a beautiful programming language but taken outside of Apple’s ecosystem to build, let’s say web apps, it sucks. Apple’s interest is to sell devices. They don’t get money out of people running Swift-powered binaries in Linux servers.

Because interests will always exist from either the company behind the project and the community, my stance is **picking projects where the community’s interests have more weight than the business’**.

For this reason, I love [Ruby](https://www.ruby-lang.org/en/) and [Rails](https://rubyonrails.org/) so much. It’s entirely community-driven. [Shopify](https://shopify.com), my current employer, benefits from the technology and contributes to improving the framework and making the programming language faster. It’s also one of the reasons why I’m learning [Rust](https://www.rust-lang.org/). I want to use it for writing portable CLIs instead of Swift if it makes sense (it doesn’t in the case of [Tuist](https://tuist.io) where contributors are familiar with Swift). Moreover, I recently started learning [Svelte](https://svelte.dev/) to distance myself from React and Facebook. [SvelteKit Adapters](https://kit.svelte.dev/docs#adapters) are a great example of not coupling a framework to a closed-source platform.

And that’s my stance. I believe in the power of open-source to **create long-lasting technology** and not as a means to make the rich richer with ephemeral technology.
