---
title: "DX vendor locking"
description: "In a world where companies are increasingly locking us into their ecosystems, it's important to invest in tools and standards that allow us to craft software the way we want."
tags: ["DX", "Developer tooling"]
---

Today, many internet companies have taken control of our content and data, placing it behind paywalls and subscription models to lock us into their ecosystems. Our photos are in the cloud, our music is behind a Spotify subscription, and our photo editing tools are accessible only through Adobe Cloud services. Isn’t this peculiar, especially considering the increasing power of our hardware? It becomes even more concerning when they use our data to train AI models to further maximize their profits.

This pattern, which originated in the consumer space, has also infiltrated the developer tooling space. Companies argue that runtimes and ecosystems like JavaScript are too complex, so they create coupled abstractions for their services. Tasks that can be solved client-side are often pushed to the server to sell services. While some problems genuinely require server-side solutions, those that can be handled on the client side should be, in my opinion.

Need a database? Use a remote one we manage for you, with a CLI to interact with. Implementing authentication? There’s a remote service for that too. Running your app in the same environment as production? Use a proprietary runtime accessible through the company’s CLI. Want to avoid environment setup? Use the browser, and we’ll provide an environment for you.

This not only causes a loss of control over your data and content but also over your development experience, costs, and the ability to craft software offline. I can't subscribe to that model.

Elixir and Erlang might not be trendy, but they don’t create unnecessary complexity like JavaScript does with its “Complexity Abstraction As A Service” (CAAAS). Proprietary abstractions rarely claim to solve problems that can be easily addressed with a few lines of code in Elixir. Long-running server processes? Mainstream solutions suggest serverless, but serverless doesn’t handle background jobs well. So, there are additional services for that. You’d think production uses the same local NodeJS runtime, right? Not exactly; you need the platform’s proprietary environment. And the list goes on.

If this is the future of software development, I’m out. I’ll invest my time in learning and using tools and standards that allow me to craft software the way I want.

