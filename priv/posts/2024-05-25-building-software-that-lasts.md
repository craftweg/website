---
title: "Simplicity, standards, and the platform"
description: "In this blog post I share the principles that we embrace at Tuist to build a future-proof productivity platform for app developers."
tags: ["Standards", "Principles"]
---

While listening to an interview with [José Valim](https://www.youtube.com/watch?v=KIrLxaM_ipk),
the creator of [the Elixir programming language](https://elixir-lang.org/),
I started thinking about the principles that we've been following at [Tuist](https://tuist.io) to build a future-proof platform for App productivity.

As you might know,
we migrated [Tuist](https://tuist.io)'s server implementation from Ruby to Elixir.
Whenever we brought this up,
it was common to hear developers saying that it sounded unnecessary.
Almost as if we didn't care about the problem space and we were distracted by the technology.
But the reality is quite the opposite.

Many organizations bootstrapping businesses treat their initial work as a disposable prototype.
If it works, they'll rewrite it with a more robust technology.
But Tuist is a validated product and foundation that needs to be as future-proof as possible.
And it's bootstrapped, which means we don't have the luxury of throwing extra money at problems or paying for services that abstract complexity away.
And that's where Elixir shines.

So our approach to building a future-proof platform for App productivity builds on the following principles:

- Embrace simplicity
- Embrace the platform
- Embrace standards

**Erlang's programming model enhanced by Elixir's language is what we'd describe as a simple yet powerful technology that scales well.** Dot. It's been three decades since Erlang was created to solve telecommunication challenges that resemble the ones that we face today with Internet companies and that we are trying to solve with endless layers of abstractions. Will we have access to less resources and talent than other technologies? Very likely, but the few that we'll have access to will last longer compared to ecosystems like JavaScript, which are in constant flux.

Note that abstracted complexity is still complexity.
It's just deferred complexity.
Down the road, you'll have to deal with it yourself,
either by throwing expensive resources at it (e.g., engineers),
or paying for services that abstract it away while creating a vendor lock-in.
This is in a nutshell the JavaScript ecosystem,
which on top of it adds the disposable and fragmented nature to the layers of abstractions.
How fun is that?

**Then there are the platforms that we build upon,
Apple's platforms and the web.**
They might not be perfect,
but they are the most stable and future-proof platforms that we have access to.
We are intentionally avoiding abstracting them.
For example,
we don't use build tools on the Tuist web app.
Instead, let the browser load CSS and JS files.
We love and believe in CSS.
Our Swift codebase doesn't use any convoluted architecture or code patterns.
It's just classes and structs (and soon actors) that pass data around trying to follow good programming practices.
Is it perfect? No.
But anyone can jump in and look around without having to learn abstractions.
It's priceless in open-source,
which we expect to embrace end-to-end.

And last but not least,
we are **embracing standards over proprietary formats.**
Many companies these days have incentives to create proprietary formats that lock users in.
We bet on platforms that bet on standards.
For example,
our cloud provider, [Fly](https://fly.io/),
uses Docker containers as a deployment format,
a runtime-agnostic solution, [Flame](https://fly.io/blog/rethinking-serverless-with-flame/) for elastic auto-scaling of applications,
or [Grafana](https://fly.io/docs/metrics-and-logs/metrics/#managed-grafana) for data visualization.
Standard is something we are going to embrace too when designing the Tuist product,
drawing a lot of inspiration from Fly, which is a company that we admire.

We are in the early days of building a productivity platform for app developers,
but we believe that by embracing simplicity, the platform, and standards,
we'll build a future-proof platform that will last for decades.
