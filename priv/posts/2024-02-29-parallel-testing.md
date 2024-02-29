---
title: "If I could just parallelize my tests execution"
description: "Schemes in Xcode have an option to run tests in parallel, but if your code isn't designed for it, you are in for a world of pain."
tags: ["Testing", "Xcode"]
---

Did you notice that Xcode project schemes have an option to run tests in parallel? It makes sense, considering we have powerful multi-core CPUs and a programming language with concurrency built-in. But let me tell you something: *all of that is useless if your code isn't designed for it.*

[Swift](https://developer.apple.com/swift/) allows having global state, whether protected or not, to prevent data races. It all starts with a stateless singleton instance for memory optimization purposes and better ergonomics: `Client.shared`, `FileManager.shared`... Sooner or later, someone adds state, and you end up with code making assumptions on the value of that state. The breakage of these assumptions is often not covered by tests, but that’s a subject for another post. So, part of your codebase is directly or indirectly dependent on mutable state. *What could go wrong?* Nothing if you run your tests sequentially. Run them in parallel and wait for the first signs of flakiness to arise. But it doesn’t happen to me, Pedro, because I'm mostly writing unit tests where I mock all the subject dependencies. And you are right, but in some scenarios, [integration tests](https://en.wikipedia.org/wiki/Integration_testing) can bring a lot of value, and in those, your stateful components are very likely far from the subject under test.

To run the code in parallel, you need to be able to scope that state to the test being executed. How do you do that in Swift? Well... using [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection), which will lead to a lot of refactoring and some boilerplate in function signatures.

I started working on the above for [Tuist](https://tuist.io), but I find it very annoying, honestly. Elixir solves this very beautifully through the concept of processes and their unique ids. Because a test is a process, and a process has an id, you can leverage that to swap modules depending on the id of the process the module is accessed from. Mind-blowing. Swift, please, bring that.
