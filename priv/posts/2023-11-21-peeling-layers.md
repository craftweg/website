---
title: "Peeling layers"
description: "This blog post contains a recent reflection over the often over-abstracted web platform, and how powerful it's become, making many of the normalized abstractions feel unnecessary."
categories: ['Web Platform', 'Complexities']
---

If you've read the content in this blog,
you might have noticed that I have little experience building for the web.
The few interactions that I had with it were geared towards putting my personal blog or [Tuist](https://tuist.io)'s website on the Internet.
The process often goes like this:

- Find a template that I like on the Internet.
- Learn about the framework the template is powered with (often JavaScript-based).
- Adjust content and structure accordignly.
- Publish

Did you know that this website has been implemented with technologies like Gatsby, [NextJS](https://nextjs.com), Jekyll, Rust, Phoenix?

Sometimes the technology decision was driven by a technology I was getting excited about,
like it's the case with the current iteration of this website, which is implemented with Phoenix and Elixir.
Other times, it was driven by the template that I'd found–Tuist's template drove the decision to use Astro.
Playing with all these different technologies is a lot of fun.
Nonetheless,
it seems to come at the cost of making projects less future-proof in part,
due, in part, to the high stack of layers (abstractions and tools) they build upon.
We make the web,
a platform that's designed to be backwards-compatible,
feel quite the opposite,
a platform that breaks more often than not.

I get that **abstractions and tooling are necessary**.
For example,
to generate HTML pages at build or runtime from templates and content.
However,
I can't avoid but wonder if we might sometimes be going too high in the stack.
This is a question that I find particularly interesting.
It's in fact one of the reasons why I like following the Phoenix and Ruby on Rails ecosystems closely.
Their love for the web as a platform makes them question every abstraction that arises (TODO: Add a note about the bias that's connected to this point).
I find somewhat some-provoking the swing of the pendulum from the server to the client with SPAs,
and recently back to the server but with the additional legacy that they've accumulated in the swinging.
React Server Components is a good example of that.
They are back at the server,
but with a vast list of NPM packages with components that make assumptions about their rendering.
It feels wrong.
Another one is Tailwind,
which has gone from being a tool to being a layer on which entire design systems and templates are built.
All you want is to add a design system to your project,
and then you find yourself having to integrate the Tailwind toolchain into your stack.
Why?

Some organizations and developers might like that working setup.
I completely understand it.
But I decided that I'm doing the opposite.
I'm **diving deep into understanding the web platform to peel layers of abstractions** and build projects that are more future-proof and easier to maintain.
Recent conversations with Marek,
about the approach we'd take for Tuist Cloud,
inspired me to embrace this philosophy.
Here's a list of principles and ideas that I embraced in this website and that I'll embrace going forward:

- **Only build tools that are strictly necessary:** For example, no ESBuild and no Tailwind. Recent standards and browser capabilities reduce the list of scenarios for which you needed build tools.
- **Plain CSS:** There isn't really a need to learn a new layer of semantics that fill HTML elements with endless lists of utility classes like the ones that Tailwind proposes. CSS has evolved a lot and provides solutions for the problems that led to the emergence of utility-class frameworks like Tailwind. CSS is the abstraction itself, and I can achieve consistency via CSS variables, some of which I can take from the wonderful Open Props.
- **Web components:** Web components are supported by the evergreen browsers. If you create a web component, you can rest assured that it'll work forever. The same is not true in *use-a-bloated-JS-rendering-technology*, where you might need to allocate time in a year or two to adopt a framework, because the technology says it's the recommended way to develop with it, or updating your components to adapt to breaking changes.
- **Embrace HTML semantics:** I used to be that developer that `<div>`'ed everything making my websites very inaccessible. Now, the first thing that I do is trying to get the semantics right while keeping the design aside. Then, I bring the design into the equation using ARIA attributes to store state, as suggested in the [Enduring CSS]() methodology.

The new iteration of this website no longer depends on ESBuild and Tailwind,
and uses web standards.
Note that the design is simple by design,
not by the simplification of the underlying stack.
The only dependency is on Elixir and Phoenix,
which are responsible for running the HTTP server that serves the website.
Can I make it more future-proof by scripting something myself in JavaScript?
Definitively.
It can be a built-time-generated static website.
However, I might add some server-side things down the road,
so I'd rather keep the server piece,
ensuring I use technologies like Phoenix that embrace the platform instead of abstracting it away.

It's been an elightening process that has shown me how powerful the web platform is.
I'll follow the new ideas that abstractions bring to the table,
while I slowly build on the lowest layer available.
