---
title: 'Thoughts on Javascript and testing'
categories: ['javascript', 'gestaltjs', 'open-source']
---

While working on [GestaltJS](https://github.com/gestaltjs), I see the internals of many other Javascript tools and frameworks from where I get ideas and insights. For instance, I always wondered how to enable file-based routing and,
I now have a mental model around how to achieve it with a build tool like [Vite](https://vitejs.dev/).

The one thing that got my attention in that journey was the little attention to having a good test suite to prevent regressions and detect breaking changes.
Many have few or no tests, and some are well-known,
with large companies building upon them. I don’t want to be in those companies’ positions.
It’s scary.
[Rails](https://rubyonrails.org/) and the Ruby ecosystem are different.
Developers have a stronger inclination towards building well-architected and tested software. It’s not a surprise to me that Rails remains unbeatable.

After a lot of thinking, I don’t think it’s the language or the tooling. I’ve been using ES modules and [Vitest](https://vitest.dev/), and I developed modular architectures following the [SOLID principles](https://en.wikipedia.org/wiki/SOLID) and testing every piece that I wrote. Javascript is not to blame. However, I think **it’s a mindset problem.** The Javascript environment is frenzy, and people don’t feel like doing long-term commitments. Their role is akin to a magician. They stitch many pieces together to create a new magic trick that they can share with the people. _Tests don’t contribute to enabling the trick, so why invest in them?_ In fact, they feel slower with them. While they are adding tests, there are other magicians creating tricks faster. They don’t want to be left behind because they have to test their code.

**GestaltJS is a long-term commitment**. We have no rush. Ideas take time to arise and click, and we’ll give them the space for that. Building reliable software is more important than providing a WOW-software that organizations might regret building upon. I’m a firm believer that long-term code commitments pay off because code speaks by itself. This is something that I learned through [Tuist](https://tuist.io). In that journey, I got questioned many times if the tool made sense considering there were others seemingly doing the same thing, and I persisted until the people could experience by themselves what I was talking about. GestaltJS will be the same.

**Expect the project to be thoroughly tested before we ask you to build upon it.** You might not see it as magic as other tools out there, but we promise to save you from some
future frustrations.
