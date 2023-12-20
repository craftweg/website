---
title: "What if XCTest a concept akin to Elixir's processes?"
description: "Erlang processes are a powerful concept that allows you to mock dependencies without introducing dependency injection. In this post, I share my thoughts on how XCTest could adopt a similar concept."
tags: ['Elixir', 'Swift', 'XCTest']
---

If you've been reading this blog for a while,
you might know that I've been diving into [Elixir](https://elixir-lang.org/) lately.
I like learning about other languages and technologies because I can cross-pollinate ideas and apply them to my day-to-day work on [Tuist](https://tuist.io).

What I find fascinating about Elixir and Erlang,
which Elixir is built on top of,
is that their modeling of the world makes a whole set of problems disappear.
Problems for which ecosystems like [JavaScript](https://en.wikipedia.org/wiki/JavaScript), [Swift](https://developer.apple.com/swift/), or [Ruby](https://www.ruby-lang.org/en/) have created a whole set of tools to solve them.
There's no quote that better summarizes this than the one from [Robert Virding](https://twitter.com/rvirding), the co-creator of Erlang:

> "Any sufficiently complicated concurrent program in another language contains
an ad hoc informally-specified bug-ridden slow implementation of half of
Erlang."

But how does it achieve that?
I think the reason is rooted in their concept of [processes](https://elixir-lang.org/getting-started/processes.html).
Everything is either a process or builds on the concept of processes.

There are many effects of processes in how you model your programs,
but one that got my attention was **how contracts can be mocked that easily without worsening the design of the code.**
In Swift,
mocking very likely means that you need to introduce a protocol and use dependency injection to inject the mock.
This is fine, and the ergonomics improved recently with the introduction of [Swift Macros](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/macros/).
Still, if you are writing integration tests,
which in the case of [Tuist](https://tuist.io) deliver more value than unit tests,
you'll have to pass the mock down to the deep-most layer of your code.
And that makes all the interfaces unnecessarily verbose.

Let's look at a concrete example.
We use [swift-log](https://github.com/apple/swift-log) for logging in Tuist.
Seeing this piece of code makes me skeptical:

```language-swift
LoggingSystem.bootstrap(MyLogHandler.init)
```

The library is using a global internal state to configure the logging system.
This is fine as long as it's thread-safe (which I assume it is) and you don't want to run test assertions against the logs and run the tests in parallel (which we do).
There's an alternative to that.
You can create an instance and pass it down to the layers that need it.
But again, it hurts the ergonomics of the code.

```language-swift
let logger = Logger(label: "me.pepicrft.Logger")
doSomething(logger: logger)
```

**Can't we have the best of both worlds?**
And that's something that Elixir solves beautifully with processes and that I wish [XCTest](https://developer.apple.com/documentation/xctest) would eventually adopt.

Every test in Elixir is a [process](https://www.erlang.org/doc/reference_manual/processes).
And processes have a **unique ID**.
That process is known by the test logic and also by the code that's being tested,
regardless of how deep it is in the call stack.
What that allows is **associating a mock with a particular test process**.
Let's look at an example using the [Mimic](https://github.com/edgurgel/mimic) mocking library:

```language-elixir
# test_helpers.exs
Mimic.copy(Calculator)

use ExUnit.Case, async: true
use Mimic

# calculator_test.exs
test "invokes mult once and add twice" do
  Calculator
  |> stub(:add, fn x, y -> :stub end)
  |> expect(:add, fn x, y -> x + y end)
  |> expect(:mult, 2, fn x, y -> x * y end)

  assert Calculator.add(2, 3) == 5
  assert Calculator.mult(2, 3) == 6

  assert Calculator.add(2, 3) == :stub
end
```

Note how no dependency injection is needed. `Calculator.stub` and `Calculator.expect` only affect the logic in that particular test process. And you can **safely** run all the tests in parallel without worrying about the state of the mocks leaking between them and causing flakiness.

**Will this ever happen in XCTest?**
I don't think so.
XCTest would need to assign a unique ID to every test and expose it to the code that's being tested.
Perhaps through some compile-time magic that's only available when running tests.

Note that the ergonomics might be improvable through dependency injection solutions,
but I'm not a big fan of adding something that improves the ergonomics at the expense of making things obscure and introducing a dependency with a third-party library.
The trade-off is not worth it.

Erlang, you are so cool.
