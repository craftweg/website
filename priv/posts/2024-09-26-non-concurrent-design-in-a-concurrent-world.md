---
title: "A non-concurrent design in a conrurrent world"
description: "I reflect on the complexity of Swift's concurrency model and how it could have been avoided."
tags: ["Swift"]
---

As you might know,
concurrency is a hot topic in the Swift ecosystem.
Everyone is trying to make their code "data-race safe".
Thanks to [Mike's](https://github.com/waltflanagan) exceptional work enabling strict concurrency Tuist's main repositories,
I haven't had the chance to tinker much with it as to form an opinion on it.
Yet,
when I see the discussions on Mastodon,
the feeling that I get is that it's a complex topic that everyone is trying to figure out.

When I something complex,
I like to go deep into understanding where the complexity comes from.
Because only then I'll be able to make an informed decision on how to approach it.
Through Erlang,
I realized that a problem space with the right modelling can make layers of complexity disappear.
Erlang does it through their concept of [processes](https://www.erlang.org/doc/system/ref_man_processes.html).
So my wonder with Swift and data-race safety was: *"Is its complexity avoidable?"*

Swift is in a bit of an unfair position to make that avoidable.
First, it had to reconcile Objective-C's OOP paradigm, which is known for embracing mutability,
which is the culprit of data-races.
Wouldn't it have been awesome if they didn't have to support compatibility with Objective-C?
Definitively! But Apple and many developers couldn't have afforded that.

Moreover, Swift was pushed beyond the Apple ecosystem,
more specifically to the server-side.
Server-side applications are known to be highly-concurrent,
which means, data-race issues become more apparent.
This explains Apple's recent push for the actor model and structured concurrency,
which you need to propagate the cancellation of work, when for example a request is cancelled.
All this push makes sense when looked from the angle of Swift in the server-side,
but from the perspective of an app developer,
or in our case a CLI developer,
it feels somewhat unnecessary.

Because Swift's origins had a strong focus on Apple platforms,
not as highly concurrent as servers,
some language design patterns were not optimized for concurrency.
Erlang started with processes,
and everything built from there.
Imagine if Swift had started with a similar concept,
and built all the frameworks on it.
The story would have likely been different.

So Apple has done a great job navigating how the language has been evolving and reaching new environments.
However, the debt is accumulating and taking shape in the form of language complexity.
Or at least that's my perception. Perhaps in a few years, we'll all become that familiar with it, that it won't conceive it as complex anymore.
This poses a very interesting question, somewhat philosophical about the future of Swift:
*Is trying Swift to do too much?*

I understand why Apple is trying to take Swift to many places.
And it's quite impressive to see what the community is achieving with it.
For example the [PointFree](https://www.pointfree.co/) folks coming up with patterns for cross-platform UIs,
compiling [Swift to Wasm](https://swiftwasm.org/), and potentially leveraging that soon for expanding Swift Macros,
or running Swift on the server with projects like [Vapor](https://vapor.codes/) or [Hummingbird](https://github.com/hummingbird-project/hummingbird).
It's truly inspiring.
Yet, I can't help but have a feeling that Apple is just partially supporting the idea that Swift can be a language for everything.
I sense a bit of fear in involving the community more in the governance of the language and finding incentives to make it more community-driven.
Some frameworks remain closed-source, and the language evolution is still very much driven by Apple's needs.

The question is, is Apple going to change that and throw themselves full into taking Swift everywhere?
Or will we forever be in this let's try Swift here and there adding language features and needed without a big picture of how the language should evolve?
