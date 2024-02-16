---
title: "Global state is future debt"
description: "In this post, I share my thoughts on global state and how it's future debt."
tags: ["Programming", "Functional programming"]
---

I've been thinking a lot about global state lately.
When writing software,
state is everywhere,
in memory, in the file system, and in storage solutions.
It's the object that the business logic works with.
State has a lifecycle.
We often read about **local state** and **global state**
to refer to state whose lifecycle is short and bound to a specific context,
and state whose lifecycle is long and shared across different contexts.
We've learned from [functional programming](https://en.wikipedia.org/wiki/Functional_programming) that **local state** is easier to reason,
and that global state is a source of complexity and bugs,
but the latter is impossible to avoid because it escapes the program's boundaries.
For instance,
in a purely functional program,
you can have global state in a database that's shared across different contexts.

I'm not a fan of pure functional programming languages because their syntax and semantics don't click with me.
However,
and having learned that the hard way,
it became clear to me that global state is future debt that sooner or later you'll have to pay.
If this sounds too abstract, let me guide you through what I mean by that.

When writing software,
it's easy to add global state for the sake of convenience,
for example via the [singleton pattern](https://en.wikipedia.org/wiki/Singleton_pattern).
A singleton is not necessarily a bad thing,
because you can use it as a tool to use memory efficiently,
but by introducing it you are laying the ground for global state to grow.
Developers will plant the seeds,
and you won't notice it in your PR reviews.
CI pass, developers will continue shipping features,
and everything will seemingly work fine.
It will until it doesn't.
You notice it when you have concurrent access to the global state,
and the behaviour of your software becomes unpredictable due to [race conditions](https://www.google.com/search?q=race+conditions&sourceid=chrome&ie=UTF-8).
In some cases, you'll notice it because users will report bugs that are hard to reproduce.
In other cases you'll notice it because parallelizing the execution of tests results in an increase in flakiness.
In any case,
it's painful for your organiation because you'll definitively have to throw resources at preventing and mitigating it.
And the larger the software becomes,
the more unmanageable it becomes.

There are some programming languages and runtimes where global state can happen so easily that it's hard to avoid it.
For instance, with the JavaScript ES module system,
where variables can be defined at the root of the module and modules are singletons,
it's very tempting to use global state.
In the ecosystem, they tooling refer to them as "side effects".
And not only it makes the software harder to reason about and unpredictable,
not just for the developers but for the tooling that's unable to understand the software well enough to optimize it.
Hence why Webpack decided to [introduced](https://webpack.js.org/guides/tree-shaking/) a convention at the package level to mark the side effects of a package.
Other technology stacks like Ruby and Rails,
where global state is common in databases,
provides testing tools to scope databases to a particular test so that it's not shared across different tests.
Did you notice?
Still, nothing prevents a Ruby class from using global state.
And once again, a developer is not thinking about that while writing the code.
It's a natural inclination towards convenience without thinking deeply about the implications of the decision.
That's why when I hear that about Ruby or JavaScript scales,
I can avoid it but to think about how many resources are required for that,
and how much of the organization's time is going into making that scale.
But because that's hard to measure,
the framing is often about the number of requests per second.

The nature of the program makes the problem less or more common.
For example,
in web applications, that follow a request-response model,
things are naturally modeled more functionally.
A request comes,
a set of functions pass that state around,
and eventually generate a response that's returned to the client.
CLI's are a bit like that too,
where a command is executed passing a set of flags and arguments, which resembles a request in an HTTP server,
and is passed through a set of functions that transform the state until it's returned to the user.
Still, global state can happen and will happen.
It happened in [Tuist](https://tuist.io),
and now it's limiting the test parallelization that we can achieve in some areas.
It's still manageable,
and we are working on it,
but I find it crazy that we reached this point without noticing it earlier.

So what can we do about that?
For example,
in the context of Tuist, which is a CLI implemented in [Swift](https://www.swift.com/homepage),
we'll have to resort to dependency injection to escape global state,
and use it to isolate the execution of tests.
Similar to what Rails and many other web frameworks do with databases.
It's feasible,
but it comes at the cost of making the code more verbose.
Suddenly all your functions take similar arguments,
and developers wonder why they have to pass the same arguments over and over again.
One could suggest to use a [service locator](https://en.wikipedia.org/wiki/Service_locator_pattern),
or a dependency injection framework,
but that comes at a high cost too.
It's a new piece of technology that developers have to learn,
and that you need to maintain.
For example,
Uber has an open-source tool,
[Needle](https://github.com/uber/needle),
which requires an additional code-generation tool installed in the environment.
Having required that in the past for Tuist contributors,
and learning that it was a source of friction,
we are not going to do that again.
Sorry.
It's dependency injection at the cost of boilerplate the solution?
Most likely yes in the context of Tuist,
but we'll try to model it to reduce the boilerplate as much as possible.

Someone familiar with functional programming languages like [Clojure](https://clojure.org/) might read this and think: "I told you so".
But as I said earlier,
the syntax and semantics of those languages don't click with me,
and the purism that naturally comes with them doesn't either.
Isn't there a solution that's more pragmatic?

Once again,
[Erlang](https://www.erlang.org/) and [Elixir](https://elixir-lang.org/) shine.
Elixir feels like Ruby with a more functional touch.
It really clicks with me.
And they have one of the most powerful concepts I've seen since I started my career: [processes](https://www.erlang.org/doc/reference_manual/processes).
First,
the language is functional.
Not as pure as Haskell,
but it embraces the functional paradigm, so global state is less likely to happen.
Do you remember that trick that I mentioned earlier to scope databases to a particular test?
**Imagine being able to do that with any piece of state**.
In Erlang or Elixir,
processes are like classes in OOP.
They are cheap, can form a hierarchy, can communicate with each other by sending messages, can hold state, can be supervised,
and most importantly, they have a unique identifier–a process ID.
Tests are processes,
and they have their unique ID (and state).
Elixir leverages that to allow swapping a module's implementation at runtime,
for a particular test.
So you can mock a module's implementation for a particular test without having to pass the mock all the way down through the call stack.
And this is truly powerful.
I wish many other programming languages had that.

Anyways,
because I can't write everything in Elixir,
I changed my approach to writing software to avoid either creating state myself or laying the ground for global state to grow.
In [Tuist](https://tuist.io) we'll have to refactor the code to escape global state,
and in future projects,
I'll embrace the everything is a function paradigm,
and figure out the right balance there with the readability and maintainability of the code.

Avoid global state.

