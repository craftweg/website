---
title: "Global state, CLIs, and test scalability"
description: "In this post, I talk about how global state in CLIs can make your test suite flaky and how to solve it to scale your test suite."
tags: ["Test scalability", "CLIs", "Mutable global state"]
---

When you hear people talking about the goodness of functional programming, one of the things they mention is the lack of global state.
States are introduced into the system and passed around mutating them as they go through the different functions.
Side effects are also avoided, and when they are necessary, they are isolated and explicit.
The most obvious benefit of this approach is that it makes things more predictable and easier to reason about.
Another not-so-obvious benefit is that it **eases scaling your test suite**,
and that's the topic I want to talk about in this post.

When your program has global mutable state that's shared across different parts of the system,
the result of your tests might depend on the order in which they are executed.
This might go unnoticed if the test runner has a deterministic order,
but if it does not,
you might end up with flakiness that's hard to debug and fix.
The matter gets worse when you try to run the tests concurrently or in parallel ([Difference between Concurrency and Parallelism](https://www.geeksforgeeks.org/difference-between-concurrency-and-parallelism/)).
And this is something that happens sooner or later in the lifecycle of a project.
You first run the tests sequentially in every commit.
Then, as the test suite grows, you introduce concurrency or parallelism if the runtime allows it.
But that comes with flakiness that's not fun to deal with. 
You could not anticipate it because you chose a programming language that allows global mutable state (e.g. Ruby).
Eventually, you might consider selective test execution,
but for that, you need compiler-lever knowledge that either the compiler doesn't provide, or your programming language is compiler-free.

At [Tuist](https://tuist.io) we are at the point where we'd like to enable more parallelization,
but we have some global mutable state that's preventing us from doing so.
At some point in the past,
we decided to lean on the side of developer ergonomics over test scalability,
and now we are paying that debt.
For example, every module has a `logger` instance that they use to output information to the console.
For most projects,
having a global instance might be fine.
But for CLI tools like Tuist, it does not.
It does not because what we output and how we output it is connected to the experience of Tuist, and therefore we test it.
And what happens if multiple tests are interacting in parallel with a global logger that's storing the logs to run assertions on them?
We'll run assertions against logs coming from multiple tests interleaved.
Voilà, flakiness.
As I talked about in the past,
it'd be great if each test run had a unique ID that we could tie global state to, 
[like it's possible in Elixir](http://localhost:4000/blog/2023/12/20/elixir-processes-testing),
but unfortunately, we don't have that luxury in Swift.
What's the solution then?
Passing a logger instance down from the command, to the deepest function that needs it.
The challenge is to do so without adding too much noise to the codebase.

Another example of a global mutable state is any system cache that the CLI might need.
For example,
Tuist uses a global cache to serialize the compilation of manifests and speed up future command executions.
Back when we implemented this feature,
we added an API to customize the cache directory via an environment variable.
We could use that API from our Cucumber-powered Ruby acceptance test suite to have a cache directory per test.
However,
since we moved the tests to Swift,
using environment variables is not a viable option anymore because all the tests run in the same process with the same environment variables.
Once again,
we need to pass that information down to the deepest function that needs it.

Since this is something that we'll have to do with multiple global states, I'm starting to think it might make sense to have a `Context` struct that we can pass around and that'd represent an interface with a global state. I'll play with it and see how it goes.
Ideally, this is not necessary,
and Apple's [new testing framework](https://github.com/apple/swift-testing) in combination with actors,
solves this by assigning unique IDs to each test run, but I'm being too optimistic here.
That uniqueness is what makes Erlang and Elixir special,
and everything builds upon it.
I doubt they'd introduce it just for the sake of solving this one isolated problem.
