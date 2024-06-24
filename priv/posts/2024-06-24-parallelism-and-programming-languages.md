---
title: "Parallelism and programming languages"
description: "In this blog post I touch on the subject of parallelism in programming languages and how to achieve it without compromising the ergonomy of the language and the complexity of the programs."
tags: ["Programming languages", "Parallelism"]
---

Over the weekend I spent some time watching the updates on the Swift [complete concurrency model](https://www.swift.org/documentation/concurrency/), and I couldn't avoid but think: the language ergonomy is suffering.
It reminded me a bit of the transition from Objective-C to Swift, where framework APIs were not designed with Swift in mind.
But look at today, things have changed a lot, so I remain optimistic that Apple can lean back on the language ergonomy and make it more pleasant to work with concurrency in Swift.

Still, Swift and its approach to concurrency was not meant to be the subject of this post.
I wanted to talk about concurrency in parallelism in programming languages, and how to achieve those without compromising the ergonomy of the language and the complexity of the programs.

There are **interpreted programming languages** like [Ruby](https://www.ruby-lang.org/en/) or [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) that can run IO-bound operations concurrently but require introducing complexity to do things in parallel. That's why they are very suitable languages to validate business ideas, but are costly to scale after validation. Costly not only in terms of complexity but also in engineering time and production infrastructure. Programs also get harder to reason about and maintain, because parallelism is often achieved through the persistence of a state and pool of processes that subscribe to state changes and run tasks in parallel.
If that's a model you are happy with, then you are good to go.
However, it's not mine.

Then there are programming languages that have **built-in primitives to run tasks in parallel**.
Programming languages like Swift, [Java](https://en.wikipedia.org/wiki/Java_(programming_language)), or [Zig](https://ziglang.org/).
But they all share one thing in common.
They put the burden on developers to prevent [data race](https://en.wiktionary.org/wiki/data_race) issues.
As a developer, that's not something I'd like to think about.
Apple is well aware of this and is trying to move to a model where the compiler can help developers prevent that.
But sadly, and as mentioned earlier, it does so by compromising the ergonomy of the language to hint the compiler about the intention of the developer.

An interesting programming language in the above group is [Rust](https://www.rust-lang.org/),
which prevents data races with a new approach to memory management.
However, there's a bit of a learning curve associated with it and is a cost that many want to avoid, especially if they are just getting started and want to validate the business idea.
An approach that one could take is starting with something like Ruby and JavaScript and doing a rewrite later on if the business proves to be successful.
But who wants to go through that pain?
Another question that I ask myself often is,
why would you adopt a programming language that,
even providing parallelism,
can't catch data races potentially causing production servers to blow up?

[Functional programming languages](https://en.wikipedia.org/wiki/Functional_programming#:~:text=Functional%20programming%20has%20historically%20been,OCaml%2C%20Haskell%2C%20and%20F%23.) can solve the above issue by not sharing mutable states.
But like Rust,
many functional programming languages, especially the ones that are pure,
have a learning curve that many want to avoid.
I've seen the DX of [Clojure](https://clojure.org/),
and it's mind-blowing to experience,
but it's a whole different approach to building, debugging, and testing software.
Is it worth it?
What's clear though is that there's something unique in the functional programming paradigm that we can't ignore.
When the state is mutated as it's passed around,
data race problems and gone and you can take full advantage of the hardware where the software is running.
Your production servers and development scales by throwing more CPU cores and memory.
Does your test suite take a long time to execute? Increase its parallelism.
And the best part? You can do that without being worried about flakiness levels increasing.
It's beautiful.

The best of all is that there's a programming language that blends
the best of both worlds: [Elixir](https://elixir-lang.org/).
From Ruby and JavaScript, it draws the high-level abstractions and the ease of use.
It's also hot-reloadable, which at the end of the day is a productivity booster (this is achieved through the Erlang VM).
From Rust, Java, and Swift, it draws the ability to run tasks in parallel without worrying about data races.
It just doesn't happen because there's no shared mutable state.
Logic is encapsulated in processes that communicate passing copies of the state.
It's amazing.
It's the most productive and amazing stack I've ever worked with.
Zero complexity.
Full parallelism.
So yeah, if you are looking for a programming language that can scale with your business idea,
I'd recommend Elixir.

This is a non-sponsored post.
It's a love letter to Elixir.
