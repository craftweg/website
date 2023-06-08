---
title: Hitting memory limits deploying Vapor apps to Fly
description: xx
categories: [Swift, Vapor, Deployments]
---

I've been trying to deploy a [Vapor](https://vapor.codes) app to [Fly](https://fly.io), and the deploy command continuously aborted unexpectedly.
It turns out that Swift's static linter needs more memory than the one available in the builders that Fly provides, 2048 MB.
I tried to increase the memory using `fly scale` as suggested in the community forum, but it didn't work.
Perhaps because the scale command cannot be used with the builder.
I used the `--local-only` flag to build locally using my local running instance of Docker.
Once the image is built,
the Fly CLI pushes it to its image registry and continues the deployment.
