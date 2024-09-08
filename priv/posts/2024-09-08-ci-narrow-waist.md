---
title: "The missing narrow waist in CI"
description: "It’s time for innovation to happen in the CI space through the narrow waist that Dagger brings to the table."
tags: ["Tuist"]
---

Did you notice how much development power CI companies have wasted on creating solutions that flood the market with nearly identical offerings? It’s a waste of talent that could have been directed toward innovation. The closest we’ve come to innovation—at least in the app development space—has been the concept of Mobile DevOps, if you can even call that innovation. In simple terms, they’ve attempted to create vendor lock-in through a proprietary automation layer built on a foundation of community steps, which developers have little incentive to maintain. It’s 2024, and the space is in desperate need of fresh ideas.

Remember the revolution that containers brought to the shipping industry? Suddenly, transportation methods adhered to a standard, allowing innovation at different layers. There are many examples of this on the internet, and the phenomenon is called the “narrow waist.” Narrow waists shift focus from redundant efforts to new forms of innovation.

What we are missing in automation is the equivalent of containers or narrow waists. Fortunately, Dagger is building just that. No more vendor lock-in through proprietary pipeline formats or walled-off automation experiences built into SaaS products. A brighter future for automation is on the horizon, and Tuist is betting on it.

Mobile DevOps? Free Automation Ops is better. It’s free because it gives organizations the freedom to choose and move across services with minimal costs. As a result, it forces existing CI providers to innovate. My guess is that many will fall victim to the sunk cost fallacy, throwing money at marketing their Mobile DevOps solutions. Good luck! We need to bring freedom back to organizations.

Dagger will not only be instrumental in gaining freedom but also in transitioning automation from languages like Ruby or bash scripts to languages such as Swift, Kotlin, or any other language of choice. Yes, you read that right: transitioning away from Fastlane is possible. Fastlane is fantastic, but when you blur the line between automation and CI—allowing workflows to run locally or remotely, as needed—the developer experience becomes truly magical. Developers will also have access to a community-driven ecosystem of steps from Dagger.

Tuist will enable Dagger pipelines to run in macOS environments, triggered by a CLI command or a GitHub event. It’s simple:

```bash
tuist workflows run test –remote xcode-15
```

This command means: “Take my project, run the workflow in a remote environment with Xcode 15, and make it feel like it’s running locally by forwarding the standard pipeline events.”

Want to see a running build? Easy:

```bash
tuist workflows logs 1234 –tail
```

There’s no need to build web-based terminal experiences when developers already spend their time in terminals.

In 2024 or early 2025, Xcode developers will be able to do this and choose a CI provider that maximizes their freedom.