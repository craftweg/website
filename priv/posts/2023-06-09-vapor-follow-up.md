---
title: Issues Dockerizing a Vapor project in M2
description: "Fly CLI + Docker on M1/M2 architecture caused issues, so I switched to GitHub Actions for deployment. No more problem!"
categories: [Swift, Vapor, Deployments]
---

It turns out that [telling the Fly CLI to build with a local Docker](/blog/2023/06/08/vapor-memory) is insufficient.
When run in an M1 or M2 architecture,
Docker uses [QEMU](https://twitter.com/FranzJBusch/status/1667109741452054529?s=20) to cross-compile the binary, 
and that causes the issues that I was seeing.
To fix it,
I could have configured Docker to use [Rosetta](https://en.wikipedia.org/wiki/Rosetta_(software)),
but instead, 
I decided to run the deployment from a [GitHub Action](https://github.com/tuist/cloud/blob/main/.github/workflows/deploy.yml).
Due to the GitHub Actions environment's architecture, issues don't arise, and I was able to deploy the app successfully.
