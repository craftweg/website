---
title: Adding bits of reactive programming to Tuist
description: In this blog post I talk about a recent decision that we made to start using reactive programming to model asynchronous tasks in Tuist.
tags: [tuist, open source, reactive programming]
---

Until now, most of the code in Tuist followed an imperative approach,
the logic executes as part of the process’s main thread.
There were some exceptions,
like the execution of other system tools that ran in their process,
blocking Tuist’s main process.

As we add more features,
doing everything in the main thread is no longer a good idea for performance reasons.
A piece of business logic that doesn’t make sense to run sequentially in a single thread is the upload of cached xcframeworks for Galaxy.
Let’s say our project has in total 20 frameworks that can be cached,
_why not upload them in parallel?_

It seems a straightforward task,
yet there’s a little detail that might go unnoticed if you are not familiar with writing CLIs:
we need to block the main thread until all the asynchronous tasks complete to continue the execution.
Otherwise,
the process will exit,
and the tasks get canceled.

Foundation provides APIs for synchronizing asynchronous work such as dispatch [semaphores](https://developer.apple.com/documentation/dispatch/dispatchsemaphore) and [groups](https://developer.apple.com/documentation/dispatch/dispatchgroup).
However,
it might not be evident from the resulting code to read how the execution of the asynchronous takes place.
Conversely,
reactive frameworks make that easy thanks to operators than can be chained,
and that describes how asynchronous units of work are combined.
Let me include some pseudocode to represent that:

```language-swift
let result = combineLatest([a, b, c]).wait()
```

Right for that particular reason,
we are starting to introduce some bits of reactive programming in Tuist using [RxSwift](https://github.com/ReactiveX/RxSwift).
It's not a binary decision,
or in other words,
it doesn’t mean that we go from an entirely imperative codebase to a fully reactive one.
Reactive programming makes sense in areas where asynchronous work is required, and where that asynchronous work might need to synchronize with other asynchronous work.

At this point,
you might wonder why not [Combine](https://developer.apple.com/documentation/combine)? Well, Combine is a macOS 10.15.x framework,
and we might have users in older versions of macOS.
A migration to Combine will definitively happen gradually as soon as we deprecate macOS 10.14.
Until then,
I think it’s fine starting with RxSwift.

This decision reminds me of SoundCloud,
where we took a binary approach,
and Reactive ended up all over the place.
I aim to do things differently here and have the usage of reactive programming scoped to only the areas where it makes sense.

I hope you all have a great week.
I just arrived in Ottawa,
and it’s cold over here.
On Wednesday,
I plan to experiment with porting Shopify’s native Xcode projects to Tuist.
Wish me luck!
