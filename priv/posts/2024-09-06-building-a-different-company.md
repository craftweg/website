---
title: "A different approach to building a software company"
description: "Tuist is doing things differently in the tech world. We’re building great software people actually want to pay for, without chasing big investor money. By keeping things simple, open-source, and scalable, we’re proving you don’t need millions in funding to make cool stuff that respects users’ freedom. It’s challenging, but we’re shaking up the game one line of code at a time."
tags: ["Tuist"]
---

Since Tuist’s inception as a business, it became clear that we were building a different type of company: one born from the love of crafting great software that people and companies would willingly pay for. We’ve proven that there’s still space for this type of company in an industry where businesses typically view success as a zero-sum game, enabled by streams of capital with the sole end goal of going public.

Building a company this way has both positive and negative aspects, depending on your perspective: we are limited in capital. This constraint influences some early decisions that we believe will have a significant impact on the company’s success in the market.

## Technology Choices

We select technologies that are simple by default and embrace the standards of the platforms on which they run. This is why we chose Elixir and Phoenix over JavaScript web frameworks, and vanilla CSS over build or runtime abstractions of the language semantics. Choosing these technologies validated our belief that our industry might have gone too far with layers of abstractions, most of which are sustained by VC capital or struggling with OSS sustainability challenges. Thanks to this approach, we don’t need to spend days or weeks of development dealing with dependency updates that crash our app at run or build time, or because a framework maintainer decides to embrace a new trend and ship breaking changes. We use all that time to build Tuist.

## Scalability and Cost-Effectiveness

Moreover, we make decisions that scale well and cheaply. When people often say that every technology scales, they’re right, but they usually forget to complete the sentence with: “if you throw enough money at it.” Since we don’t have that money, we choose technologies that scale cheaply. Elixir is a prime example of this approach. You can go a long way by adding more cores and CPUs to your machines. Will we ever need a different scaling method? Maybe, but we defer that decision as much as possible. We also stay away from “serverless” platforms that promise “pay-what-you-use” pricing, which often translates to “charge-even-more-than-with-a-single-server-running.” We view these concepts as new monetization strategies wrapped in attractive “go to the edge” narratives.

## Open Source and Openness

Another key element in staying relevant without streams of capital is our commitment to open source and openness. While many players see it as a marketing tool, we embrace open source as a means to build more diverse software and foster new solutions that can build on new layers of commodities. We plan to take some of the innovation that has happened behind the walls of our competitors—often intentionally designed to vendor-lock customers—and offer it for free to the community. Because we don’t need to “exit” Tuist, we can afford to give organizations back some of the freedom and agency that was taken from them. We’ll monetize by integrating all these tools into a service that we’ll maintain and run for them. The underlying technologies will all be open source with permissive licenses, similar to Grafana’s approach.

## Building on Open Source

We also build on open source solutions. We look for alternatives to mainstream services where we often end up being the product. We use Chatwoot over Intercom, CloudNext over Google Drive, Documenso over DocuSign, and Penpot over Figma. This approach not only supports the ecosystem of companies that embrace openness as their core values but also minimizes risks associated with depending on closed-source services. These services often make it difficult to export your accounts and data, limiting your freedom to move to the best solution for your business. We also support these projects either by using their self-hosted services or by donating to the people and organizations behind them.

## Achievements and Future Outlook

With just one full-time developer, a part-time developer (myself), and a talented designer joining soon, we are proud of the quality and quantity of solutions we’ve been able to produce. Although mentally taxing at times, being limited in capital was key in embracing decision-making principles early on that will have a huge impact on our ability to stay relevant, discover new market opportunities, and respect our customers’ rights and freedoms.

Tuist is here to shake up the game.