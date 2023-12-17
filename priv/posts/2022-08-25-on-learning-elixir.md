---
title: "On learning Elixir"
tags: ['elixir', 'erlang']
---

As you might have noticed, I’ve been learning [Elixir](https://elixir-lang.org/) for the past few weeks. Why? You might wonder. I’m a programming languages nerd. I like learning about how different languages solve the same challenges, which gives me new perspectives and ideas for solving upcoming problems.

I came across a talk about the [Erlang](https://www.erlang.org/) virtual machine, [BEAM](https://en.wikipedia.org/wiki/BEAM_(Erlang_virtual_machine)), and it blew my mind. I then read about Elixir, and its similarity with Ruby instantly clicked with me. The more I read about it, the more I liked it. At the same time, I also started to feel that I'd better not spend more time with Javascript than what's strictly necessary. The constant need to re-invent every layer of the stack, the VCs' urge to make their way into those layers, and how uncommon it is to embrace good software practices made me highly uncomfortable and stressed. I've discussed this in past blog posts, so I won't repeat myself.

One thing that fascinated me about Erlang is that it defers introducing complexity to your Elixir projects. Needs for which you'd introduce elements like [Redis](https://redis.io/), [Kubernetes](https://kubernetes.io/), load balancers, and background jobs solutions into your system are well addressed by the VM when you get started. Its pattern matching is different, and I find their approach to functional programming easy to reason about and work with. I believe in building pure functions and dealing with immutable states, but the syntax of strongly functional programming languages like [Clojure](https://clojure.org/) hasn't clicked on me yet. Talking about sharing mutable states… this is something that bugs me when working with Ruby or Javascript. It's common to see states being stored and mutated at the module level. Everything works until it doesn't, or tests become flaky because of it.

I'm considering moving this blog to Elixir using [Phoenix](https://www.phoenixframework.org/) to consolidate my learnings. I came across the [nimble_publisher](https://github.com/dashbitco/nimble_publisher) package that allows embedding static content, for example, blog posts in a Git repo, into the BEAM binaries that end up being deployed. I know this might sound too much for a blog, but what's better than your blog for a bit of over-engineering? Turning my blog into a long-running process will allow me to add some interactive bits to it.

After it, I'm also considering building a tool to scratch an itch that I've had for quite some time. Collecting and processing personal financial information from bank accounts and investment platforms to make better and more informed decisions. As always, it'll be open source, and if it turns out to be helpful, I might host an instance and allow other people to use it too. But first, let's see if I can build it for myself.

Are you also learning Elixir or are familiar with it? What do you like about it?
