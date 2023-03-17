---
title: Elixir or Typescript
description: "Typescript and Elixir both have their strengths and weaknesses. While Typescript offers a vibrant ecosystem of resources, Elixir provides a more harmonious and lean approach to development, with a strong focus on maintainability and scalability thanks to the power of the BEAM. Ultimately, the choice between the two will depend on your project's needs and priorities."
categories: [typescript, elixir]
---

When I start a new web app,
I always wonder whether I should use [Elixir](https://elixir-lang.org/),
which I've been learning lately,
or [Typescript](https://www.typescriptlang.org/), which I used at work and got very familiar with.

**Typescript** gives you access to a vibrant ecosystem of packages and resources to build upon.
I've never seen anything before like the Javascript ecosystem.
Many NPM packages provide type declarations, and there are packages like [Prisma](https://www.prisma.io) whose developer ergonomics are unbeatable.
However,
that's a double-edged sword.
You might start depending on project X,
which will stop being maintained two months from now because a new trend has come out.

Moreover, many companies are trying to monetize every layer of the stack, from runtimes to libraries, making me very skeptical of creating a dependency not with the tech but with the investors backing the project.
Will Prisma continue to be maintained and improved if it stops receiving [investments](https://www.prisma.io/blog/series-b-announcement-v8t12ksi6x)?
It's hard to tell.
Frameworks noticed this (and the runtime inconsistencies) and provided a building block,
adapters,
to defend you from runtimes taking unexpected turns that don't align with your project's plans.

If I were to build on a framework,
I'd choose [Remix](http://remix.run/),
which I know [Shopify](https://shopify.com) is heavily invested into.
The framework is already good and has a solid foundation and mental models.
Shopify does an amazing job with the technologies it contributes to (I look at you Ruby, and Ruby on Rails).

**Elixir**, on the other side, is more harmonious and lean.
Like Rails, the community naturally leans towards contributing to the existing foundation instead of constantly creating new things.
Its ecosystem is not as vibrant as Javascript's,
but it gives you access to the power of the [BEAM](https://en.wikipedia.org/wiki/BEAM_(Erlang_virtual_machine)) (Erlang's virtual machine).
Thanks to it, you end up with a stack that's easy to maintain and scale by a single person without depending on proprietary tech like serverless or background jobs solutions.
The model is easy to reason about; it's an app running on a virtual machine on a server,
which gives you many tools for debugging, monitoring, and scaling.
Unlike Rails,
you don't need to make your system more complex to scale or process background tasks.
BEAM has a primitive,
[processes](https://www.erlang.org/doc/reference_manual/processes.html),
to help with that.
You can even [use pre-trained Neural Network models](https://github.com/elixir-nx/bumblebee) right from your request-response cycles or even do a [hot-fix in production](https://www.youtube.com/watch?v=JvBT4XBdoUE).
That's unthinkable with other technologies.

Both options have pros and cons, but **my inclination remains on the Elixir side**.
From the above,
it might be tempting to think that Elixir is all about scaling,
which is premature thinking when a project is getting started.
However,
I look at it from the angle of **maintainability and focus**.
The functional nature of the language makes code more deterministic and thus easier to reason about, test, and maintain.
Its ecosystem,
not as vibrant as NPM's,
has a more foundational mindset,
which leads to less fatigue in catching up with things, and, thus, more energy to invest in the project.
For example, while the Javascript world is trying to figure out where the rendering should happen (client vs. server), Phoenix provided [an elegant solution](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html) long ago.

Elixir and Erlang are exciting technologies, and I'm eager to dive deeper into them and feel more comfortable writing functional Elixir code and understanding the [OTP](https://serokell.io/blog/elixir-otp-guide) primitives better.
