---
title: "Implicitness in Xcode and SPM. Why Apple?"
description: "Apple embraced implicitness in some areas of the build system, and it's causing headaches to developers. In this post, I share my thoughts on the topic and how we are planning to address it in Tuist."
tags: ['Xcode', 'Swift', 'Tuist']
---

Since the beginning of Tuist,
one of the principles that we embraced is that **the dependency graph should be explicit.**
This is something that we encouraged through the Swift DSL,
but that we couldn't enforce because Xcode and its build system allow it.

Why explicitness you might wonder?
When the graph is explicit and known upfront,
you can **validate**, **reason about**, and **optimize** it.
When it's not,
you can't do those things.
Or you rely on a closed-source build system that you don't control to do it for you.
And if things go wrong, you need to file a radar and wait for Apple to fix it.

The worst part is that **Apple is not reversing this trend.**
Instead, they are building on it and the Swift Package Manager is inheriting the same problems.
For example, they realized that package products defining the `static` or `dynamic` nature of the library were a mistake that could lead to duplicated symbols.
What did they do to solve it?
They solved it with a new linking option, `automatic`, that's resolved at build-time.
Why would you want a build system to make these important decisions for you?
Your graph is yours.
Tuist gives you agency over the graph while hiding the complexities that are not relevant to you,
like the fact that some dynamic frameworks might need to get copied into the app bundle.

One of the issues that is particularly annoying,
and that we are coming across often in Tuist's codebase is **being able to import dependencies that are not explicitly declared.**
The issue is more apparent now because we optimize our workflows with [binary caching](https://docs.next.tuist.io/documentation/tuist/binary-caching).
The reason why it happens is that the directory in which Xcode outputs all the project target products, `DerivedData/{project}-{hash}/Build/Products/{config}`, is visible to the other targets in the project.
In other words, they can import them without having them declared as dependencies.

For example, let's say that you have a simple dependency graph `A -> B -> C` where A (App) depends on B (Framework), and B depends on C (Framework). If we do `import C` from `A` it'll work if we build the project through a scheme with the *"Find implicit dependencies"* enabled or if `C` has been previously compiled. For example via another scheme.
What's particularly annoying about this is that the issues might arise on CI, or weeks later after weeks of CI workflows accidentally working. 

**This is an itch I'd like to scratch for Tuist and every Tuist user.**
I doubt Apple does anything, but I might be wrong.
They are in a tricky spot because any step to remove implicitness would very likely break existing projects.
It's the same for Tuist,
but we can work closely with our users to define a migration path that allows them to transition to an explicit dependency graph.
I believe once we do it,
things will get more deterministic and stable for everyone.
They won't most likely notice it,
because teams don't have a metric to measure "how often implicitness caused headaches",
but I bet it's more often than we think.

We hope to ship it as part of Tuist 4.0. Stay tuned!

