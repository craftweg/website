---
title: Back to Jekyll
tags: ['ruby', 'jekyll', 'blogging']
---

I recently changed my stand in regards to the technologies that I use when building software.
In particular,
I decided to **minimize the amount of Javascript** that I use in my projects.
In my experience,
Javascript is usually synonym of indirection, complexities, and instability:
_dependency updates that blow up your whole stack,
cryptic build errors that are hard to debug,
setup that is hard to reason about and unnecessarily complex._

On the other side,
[Ruby](https://www.ruby-lang.org/en/) and its ecosystem is more harmonious and peaceful.
If something works,
it's very unlikely that it breaks.
If there's already a Ruby gem that does something,
people are more inclined to contribute to it instead of reinventing the wheel.
No hype fatigue.
The language that you ship is the language that you write.
You don't need layers of transformations to accommodate your code to the environment in which it'll run.

Because of all of the above,
I've migrated this blog back to [Jekyll](https://jekyllrb.com/) from [GatsbyJS](https://www.gatsbyjs.com/) and I've taken the opportunity to overhaul the design with something more boring and developerish.
I want the focus to be on the content and not the aesthetics.

I've so decided to stay away from unnecessary abstractions upon standards like [HTML](https://en.wikipedia.org/wiki/HTML) and [CSS](https://en.wikipedia.org/wiki/CSS).
I got hyped into the [CSS-in-JS](https://cssinjs.org/) and [TailwindCSS](https://tailwindcss.com/) without realizing the value they provide is not really necessary in my projects.
Moreover, the closer to the standards and the fewer abstractions the better for the long-term sustainability of the projects.
If I write HTML and CSS today, I can open it in years from now, and it'll very likely work.
If I to do the same with a [React](https://reactjs.org/)-based website that is processed by Gatsby through Babel,
the chances are that it won't work in a few years.

It's been great to learn about those technologies and seeing companies pushing the web forward through them,
but HTML and CSS and a bit of Javascript are enough to create value and share my ideas with everyone.

Stay safe!
