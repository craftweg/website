---
title: Processing feedback from Shopify CLI's appearance on HN
description:
categories: [node, javascript, shopify]
---

I only check [Hacker News](https://news.ycombinator.com/) if I stumble upon someone mentioning that they made it to the front page.
Yesterday, I stumbled upon messages from colleagues saying that it was me who made it to the front page with this [blog post](https://shopify.engineering/overhauling-shopify-cli-for-a-better-developer-experience).
Who knows why,
but probably because it's unusual seeing a Ruby company like [Shopify](https://shopify.coms) talking about Javascript and Node.

At first,
I didn't feel like reading the comments because they tend to be pessimistic.
But then I dove into them, pursuing feedback.
What I found is an utter rejection of Javascript and Node.
Some referred to the **long list of dependencies** you need for a project to run, which is fine — it's absurd compared to other ecosystems.
*But does it matter if we build a great developer experience (DX) on it?*
We've done extensive work ensuring that dependencies can't make any DX we build fall apart.
Another theme of feedback was **portability**.
As mentioned in the post, Go, and Rust are better positioned there.
However, portability is also possible in Node,
as Tailwind has proved with their [standalone CLI](https://github.com/tailwindlabs/tailwindcss/tree/master/standalone-cli).
Many use it in non-Node projects like Rails or Elixir apps without realizing they are using Javascript and Node under the hood.
Once again,
if you build a great experience,
technologies don't matter.

There was also feedback about the **experience** not being great.
Which is something we are working on solving, unrelated to the technology we build upon.
We'll get there, and I believe this decision set us on the right path.
We can move more confidently thanks to Typescript and faster thanks to a rich ecosystem of tools, NPM, that keeps improving daily.
The team is doing very novel work, thinking about every corner of the CLI and the experiences that we provide.
Give us some time.

