---
title: "Users don't care about your web app's portable binary"
tags: ['golang', 'open-source', 'binaries']
---

We,
software crafters,
naturally tend to **distance ourselves from users** led by excitement for technological cycles and innovation.
Our industry is full of examples.
For instance,
the crypto trend is an excellent example of that.
No one can obviate the fact that there's innovation in [blockchain](https://en.wikipedia.org/wiki/Blockchain).
Yet, it's not solving people's problems.
It's doing more harm than good,
but this is a topic for another blog post.
The one distancing that got my attention recently is this idea of building a web app as a portable binary.
[Go](https://go.dev/) started the trend with its ability to inline resources in the output binary.
[Deno](https://deno.land/) has jumped on it with its `deno compile` command that many web developers are getting excited about.

Distributing software as a portable binary is an excellent idea for CLIs because you don't want to require users to install additional dependencies in their environment.
But in the context of web apps,
**users don't give a shit about your web app being a binary.**
They care about the app's usability, reliability, and performance more than anything else.
How an app runs in a server is an implementation detail.
In pre-[Kubernetes](https://kubernetes.io/) and [Docker](https://www.docker.com/) times,
there'd have been a strong argument in favor of binaries to ease deployments.
But times have changed, and that's not a problem anymore.
Platforms like [Heroku](https://heroku.com) or [Fly](https://fly.io) can infer your app's project deployment.

I'm writing this down and sharing it to remind myself and others that might come across the same argument that **we build ultimately for users**.
If you get excited about a technological cycle or innovation, ask yourself whether you are playing with a new technology or building for users.
And in the case of the latter, wonder if users care about the technological decision you are pondering.
[Shopify](https://shopify.com) was criticized back when they chose [React Native](https://reactnative.dev/) for the mobile apps,
but it was a decision that has had a positive impact on users' experience, which really matters.
