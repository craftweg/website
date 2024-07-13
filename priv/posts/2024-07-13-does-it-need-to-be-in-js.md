---
title: "Does it need to be in JavaScript?"
description: "Is JavaScript necessary to enable atomic and reusable components on the web?"
tags: ["UI", "Web"]
---


I believe the reason why React and the many JS-based UI paradigms became so popular is because they brought closer markup, style, and behavior making components an atomic and shareable unit of composition. It’s unquestionable that it’s a mental model that developers like, so much, that other technologies started introducing the idea of components.

Similarly, Tailwind enabled the portability of styled components. And developers loved that. So much, so that it’s rare to see a UI tool kit or design system that’s not built on Tailwind. Developers prefer to learn the semantics of an abstraction, instead of the semantics of the underlying standard. It’s bizarre when you think of it, but portability is key, and it’s becoming even more apparent with all those AI tools that generate a website for you.

The problem with it is that if your stack is not JS, you feel left out. Developers find themselves having to decide between having access to that ecosystem of paradigms and reusable component kits at the cost of adding a JavaScript runtime to their stack, or not adding any JavaScript runtime and having limited access to resources and DX. Many end up leading on the former, which often also means building an SPA, and you know all the implications that come with it. The cost is high.

For some time I've been thinking about whether JavaScript is required to enable that experience, or if it was more of an accidental implementation detail because React started with a focus on the client (browser) where a JavaScript runtime is available by default. The more I thought about it, the more it became clear that it's very likely an accidental implementation detail. At the end of the day, those technologies are functions from components and data to HTML, CSS, and JS (or Wasm). So why not have the compiler in let's say Rust, with bindings for the many languages and runtimes with popular web frameworks like Ruby, Python, and Elixir? I believe pushing the solution one level down and making it runtime-agnostic would suddenly decide on technology more of a language preference than anything else.

Such a solution could come with a registry to share components. Imagine a design agency bundling a design system and distributing it to you to consume regardless of your technology stack. We'd save all those organizations an insane amount of time and money having to port their solutions to the multiple technologies they support. It'd become the missing [narrow-waist](https://www.oilshell.org/blog/2022/02/diagrams.html) in how people build UI for the web.
Or imagine something like [Storybook](https://storybook.js.org/) too. It'd unlock a whole new world of possibilities and perhaps a new type of discipline: UI developers, which would feel comfortable writing components and iterating on them without the distractions and complexities of a full-stack application.

*Where am I going with this?* I don't know, but I want to tinker a bit with the idea in my spare time and see how far can go. It's also an excuse to write a bit of Rust :).

Happy Saturday.
