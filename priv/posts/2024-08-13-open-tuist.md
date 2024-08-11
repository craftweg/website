---
title: "Fair software: Sustainability with no customer risk"
description: "In this post, I explore the idea of a fully open Tuist platform."
tags: ["Fair souce", "Open business", "Tuist"]
---

As you might know, we aim to make [Tuist](https://tuist.io) a fully open project.
A project with thriving businesses behind it that protects organizations' and developers' freedom and minimizes any risks when betting on us.

We achieve this by:

1. Building on and embracing standards over proprietary formats.
2. Exposing and documenting programmatic interfaces so developers can access the data from Tuist's domain.
3. Opening the code that powers the platform.

It sounds fantastic on paper, but in practice, 3. poses the most significant challenge. How do we prevent putting Tuist at risk?

Open Source and permissive licenses like [MIT](https://opensource.org/license/mit/) and [Apache](https://www.apache.org/licenses/LICENSE-2.0) bring freedom but don't protect the business. Companies can try to benefit from it in a predatory way without ensuring a healthy balance that benefits all stakeholders. They even dare to [go wild publicly](https://bitrise.io/blog/post/tuist-bitrise-build-cache-update) when you spoil their plans to protect Tuist.

Other organizations seek protection by adopting AGPLv3, which many companies have policies against, and selling dual licenses and enterprise features. Those businesses are often referred to as [Open Core](https://en.wikipedia.org/wiki/Open-core_model). However, companies are still facing litigation risks, which we do not want for our customers. So what's the alternative?

I think the answer for Tuist is Sentry's new license concept: [Fair Source](https://fair.io/), particularly their [Functional Source License (FSL)](https://fsl.software/). The license beautifully strikes a good balance between the freedom of Open Source and the protection of the business.

The code is available (Customer freedom). You can check out the code, use it, extend it, contribute to it, and host it as long as you don't try to compete with the business (Business protection) so that the project can thrive and benefit everyone. And after two years, the code becomes MIT, so if the business dies, anyone can take it over and continue to thrive.

David Cramer puts it very well in his blog post [Open Source is not a Business Model](https://cra.mr/open-source-is-not-a-business-model):

> "If they choose AGPL they’ll deter all but the most determined competitors, but given its a GPL-based license, it might also scare off certain customers. If they choose MIT they might as well rely on thoughts and prayers, as nothing protects them from predatory companies. So what do they do? Well, most of them choose Closed Source."


So I think a fully open Tuist platform could unfold this way:

- **We expand our current narrow TAM.** The milestone here will be releasing Tuist Workflows. This continuous integration blurs the line between CI/CD, a build system, and local and remote environments, opening Tuist up to many ecosystems. Swift will become the ecosystem where we started and the tool to enable the best developer experience of the Tuist platform.
- **We open the server code under FSL** allowing companies to self-host and charge companies for hosting the software ourselves, which we'll be experts at.

Not everything needs to be FSL. Some components like the Tuist CLI or technologies we'll develop to enable this vision can and will be MIT. They'll be our gifts to inspire others to build thriving open businesses. 

Marek and I are still sleeping on these ideas, but we intend to make this happen. We can only build the best in class productivity platform if we embrace openness.
