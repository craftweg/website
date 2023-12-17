---
title: "Open-sourcing the lightning_css Elixir package"
description: "In this blog post I talk about the motivations that led me to build and open-source lightning_css, an Elixir package to bring a more advanced CSS bundler to Elixir and Phoenix projects."
tags: ['Elixir', 'CSS', 'Open-source', 'Web']
---

I've been reading a lot and connecting with the idea of embracing the web platform and building right on it,
without layers and layers of abstractions that make it harder to understand what's going on under the hood,
and that make the software less future-proof.
For instance,
I got rid of [Tailwind](/blog/2023/11/21/peeling-layers) from this website.

When it comes to **styling**,
I've been following the [Enduring CSS](https://ecss.benfrain.com/chapter5.html) methodology.
This provides answers for many challenges that CSS presents and embraces accessibility attributes to hold state leading to more accessible websites.
Nevertheless,
one challenge that I found,
in particular in the context of [Elixir](https://elixir-lang.org) and [Phoenix](https://www.phoenixframework.org),
is that it's hard to follow [the directory convention](https://ecss.benfrain.com) that they propose to get styles close to the components.
Doing so requires using a tool that's able to resolve **glob patterns** to locate CSS files and bundle them into an output CSS bundle,
and the tool that asset pipeline tool Phoenix projects use by default,
powered by [ESBuild](https://esbuild.github.io),
doesn't provide that functionality for CSS.

Luckily, there's a solution for that in the community: [Lightning CSS](https://lightningcss.dev).
Yet, the integration into Elixir projects requires some tedious plumbing.
Because I wanted to overcome that, and also scratch the itch of building an Elixir package.
I built and open-sourced [lightning_css](https://github.com/glossia/lightning_css).
The interface is similar to the one that the Elixir's `esbuild` package proposes.
You first configure profiles in your Mix project's configuration file:

```language-elixir
config :lightning_css,
  version: "1.22.1",
  default: [
    args: ~w(assets/css/app.css --bundle --output-file=priv/static/styles/bundle.css),
    watch_files: "assets/css/**/*.css",
    cd: Path.expand("..", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]
```

And then you can invoke it right from the terminal using the Mix CLI passing the profile, `lightning_css default`.
In the case of Phoenix projects, you need some [additional steps](https://github.com/glossia/lightning_css#phoenix) to integrate it into Phoenix tasks and watchers.

I still need to add some tests,
which is another itch I want to scratch: getting familiar with Elixir's testing framework.
However, I'll leave that for the near future.
I'll adjust this website to make use of glob patterns,
and start using it in [Glossia](https://glossia.ai),
in which I plan to continue investing early next year.
