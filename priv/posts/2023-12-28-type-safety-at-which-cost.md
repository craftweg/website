---
title: "Type safety but at which cost?"
description: "Type safety, while important, can be overrated and lead to over-engineering. In this post, I share my thoughts on the topic."
tags: ["Types", "Type safety", "Compilers"]
---

I've come across developers recently who are obsessed with type safety and leveraging the compiler to its fullest extent to catch errors.
So much so that they are willing to sacrifice **readability, compilation time, and maintainability** for the sake of type safety.
There's no right or wrong here, but I've found myself on the opposite side of the spectrum.

When we decide to invest in type safety, 
we do so because **we trust the compiler more than we trust ourselves.**
For example,
if there's a function named `getUser(id: ID)`,
one might be concerned about someone calling the function with an `ID` that doesn't represent a user `ID` but a post `ID`.
Sure, we could model our types to have different types for user and post IDs (there must be a mathematical term for this),
but isn't the semantics of a function enough to convey its purpose and trust that developers will use it correctly?
I think so.
Sure, there's a chance that someone will call the function with the wrong type,
but there's also a chance that even getting the types right, your software won't do what it's supposed to do.

What this obsession with type safety often leads to is **over-engineering**–teams spending endless hours discussing what the best typing solution is for a particular problem according to theory X or Y. It also **worsens the onboarding experience** for new developers, who have to learn a new type system and its quirks before they can start contributing.
Imagine being an engineering manager seeing your team not delivering features because they are stuck in a discussion about types.
Sure,
one could justify that this is a long-term investment that will pay off in the future,
but in software,
where requirements change all the time,
all the time spent to come up with the perfect type system is time wasted because you'll have to change it anyway soon.

Note I'm not saying you should not care about type safety.
I'm saying we might sometimes get too obsessed with it without realizing the cost of it.
This obsession will lead to a tax on your team's productivity and happiness.
I've seen it happen.

