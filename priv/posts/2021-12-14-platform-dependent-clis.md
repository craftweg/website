---
title: 'Platform-dependent CLIs'
tags: ['development', 'platforms', 'cli']
---

I'm a firm believer that **shaping products as developer platforms is an amazing idea to let developers from all over the world make your product diverse**.
Otherwise,
you have products like [Facebook](https://facebook.com) and [Apple](https://apple.com)'s that work great in California but conflict with the rest of the world,
and what's worse, end up imposing a model that often becomes the source of serious problems.
For example,
the idea that people need to be connected and feel part of the community (the what) is accurate,
but doing it through addictive technology (the how) has led to terrible consequences for people's mental health.
Instead,
**they could have provided building blocks** to model social interactions and communities and let developers use them to model how communities and social interactions work in their countries.
Wouldn't that have been awesome?

[Shopify](https://shopify.com) is a platform.
They acknowledged **the definition of e-commerce changes across countries**.
They can't build as many e-commerce versions as countries that exist in the world.
But they can build the LEGO pieces and the core business logic and provide APIs for developers to build upon.
The more I contribute to this platform from the inside,
the more I realize how brilliant the idea is.
It seems a simple idea, but I'm sure [Tobi](https://twitter.com/tobi) has put a lot of thought into this.

I have the opportunity to work on the [CLI](https://github.com/shopify/shopify-cli) that first and third-party developers use to build and deploy to the platform.
As part of this work,
one of the challenges we came across is **breaking or abstracting away the dependency that projects have with the platform.**
If you've used CLIs to build for other platforms,
you might have noticed that most of them don't require the platform in the development phase.
If you create an iOS app, you only need the platform when you upload the app. Until then, you can use Xcode and the simulators to develop and test the app locally.
If you create a web app with a framework like [NextJS](https://nextjs.org/),
you can run the app locally and only interact with [Vercel](https://vercel.com/) when you need to deploy the app.
There's only a moment in time when the user has to navigate from the CLI and the local environment to the server-side platform.

But that's not the case at Shopify.
**[Theme development](https://shopify.dev/themes)** depends on the production storefront renderer to preview the themes during development.
The same is true for **[Extensions](https://shopify.dev/apps/tools/cli/extension-commands)**.
An extension only makes sense when it's loaded within the context of the Shopify platform.
For example, if the extension represents a checkout extension, you want to see it loaded in an actual checkout flow.

**During development, the dependency on the platform makes it extremely challenging to provide a great DX.**
It's not impossible, but something I've been thinking about ever since I came to that realization.
I don’t have solutions yet, only ideas for improving the DX.
For example,
imagine Shopify providing a server-side [Storybook-like](https://storybook.js.org/) functionality that acts as a disposable sandbox environment.
The dependency with the platform remains,
but there's a platform-side dedicated tool to ensure the preview experience is the best.
Storybook's stories concept would map so nicely.
For example,
we could provide different checkout scenarios that you can easily switch between without going through the checkout process.

Another approach could be **taking platform functionality down to the client to simulate locally.**
However, that requires first designing those pieces to be modular enough so that the preview piece can be pulled locally.
Second,
write them in a compiled language such that you hide implementation details of the business domain.
If you are familiar with iOS development,
it'd be the same as providing a simulator for the Shopify platform.

**Improving the current state would shorten the development cycles, and developers would have more focus and motivation when building for the platform.**
I remember my days of iOS development when I could not preview my changes because of signing issues.
It felt so frustrating that I don't want Shopify developers to feel the same way.
