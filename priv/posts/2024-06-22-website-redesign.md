---
title: "Website redesign"
description: "I redesigned my website to make it visually simpler and added new pages."
tags: ["CSS", "Web"]
---

Working on [Tuist](https://tuist.io) dashboard,
and learning and writing HTML and CSS,
motivated me to redesign my [website](https://github.com/pepicrft/website),
which is powered by [Elixir Phoenix](https://phoenixframework.org/).

The **design principle** that I followed was to make it as simple as possible.
I used the same `font-size` and `font` throughout the website and played with the `font-weight` and `gap` to create a visual hierarchy.
I'm quite happy with the result.

I took the opportunity to add **new pages**.
I added a [feed](/feed) page to surface my posts from Mastodon,
and [photos](/photos) to do the same with my Pixelfed posts.
Since those pages are rendered on the server, I fetch the data from the respective APIs and populate the pages with it.
I also added a [now](/now) page that I plan to keep up to date with the latest ideas, thoughts, and things I'm interested in.

After having done this work,
I'm quite excited about using the web platform in its rawest form.
No TailwindCSS, no static site generators, [#nobuild](https://world.hey.com/dhh/you-can-t-get-faster-than-no-build-7a44131c) setup.
