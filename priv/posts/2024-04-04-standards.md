---
title: "Standards, standards, standards"
description: "Proprietary solutions are a dime a dozen, but standards will outlast them all."
tags: ["Technology", "Standards"]
---
     
In the tech world, where ["enshittification"](https://en.wikipedia.org/wiki/Enshittification) is rampant, the importance of standards becomes clear as they protect us from platform interests that may not align with our own. As you observe your surroundings, you'll find numerous examples:

- Why opt for [Figma](https://figma.com) and its proprietary file format when you could use [Penpot](https://penpot.app/), which utilizes SVG?
- Why use serverless proprietary JavaScript runtimes when you can deploy [OCI images](https://github.com/opencontainers/image-spec) to platforms like [Fly](https://fly.io)?
- Why choose [Tailwind](https://tailwindcss.com/) for styling your website when you can achieve the same with standard CSS, which has improved significantly over the years?
- Why use [Notion](https://notion.com) when you can write your content in Markdown files and manage them with tools like [Obsidian](https://obsidian.md/) or [Logseq](https://logseq.com/)?
- Why bind yourself to the complexity of [React](https://logseq.com/) when you could embrace the platform and use [web components](https://developer.mozilla.org/en-US/docs/Web/API/Web_components)?

I understand... standards can seem dull. They often lack the flashy, modern websites that play on psychology to convince you of their worth, yet they possess a unique value. They will outlast any proprietary format. *React?* It will eventually lose its appeal, leading people to chase the next trend. You have the chance to decide whether this results in a burdensome migration for you or has no impact at all. *Should Notion decide to change its terms of service and raise the price for accessing your content?* You can choose to avoid that situation entirely.

With the current overload of noise on social channels, it's easy to mistake something's value for how frequently it's discussed. You won't find many tech influencers evangelizing Markdown because it's not deemed "cool." It's more fashionable to talk about a React-like Markdown format that blends Markdown with JSX. *Unfamiliar with it?* Consider introducing it to your project.

The JavaScript ecosystem undoubtedly epitomizes the realm of proprietary solutions. The absence of standards beyond the language itself has transformed the ecosystem into a Wild West. Try to name a single problem layer where solutions are standardized; you'll find none. Take runtime as an example: each attempts to introduce a proprietary set of APIs until they realize the inevitability of Node's standards, forcing them to ensure compatibility with Node's APIs so that packages in the NPM ecosystem work seamlessly. Or consider cloud runtimes that mimic Node but aren't actually Node. The code that functions locally fails in production because you're using Node locally and something different in the cloud. As a result, new layers emerge to shield developers from the myriad proprietary solutions, like [Honos](https://github.com/honojs/hono), which abstracts the various methods of handling HTTP request-response cycles.

There are developers who enjoy hopping from one proprietary solution to another. I don't. Perhaps it's a sign of aging or a decreasing tolerance for trends that distract from creating anything of value. However, **the moment I see a company promoting something proprietary, I instantly become wary**. That's why I prefer CSS over Tailwind, Fly over Vercel, Markdown over Notion, and runtimes like Erlang over Deno or Bun. The peace of mind that comes from betting on standards is invaluable, granting me the focus needed to build great tools with technology.
