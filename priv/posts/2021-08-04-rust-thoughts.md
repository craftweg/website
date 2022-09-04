---
title: Some Rust thoughts
categories: ['open-source', 'rust', 'learning', 'education']
---

A while ago,
I started reading about the Rust programming language out of curiosity.
Many things fascinated me about the language.
It has a powerful dependency manager similar to the Swift Package Manager but more thoroughly designed.
Unlike Swift,
the compiled programming language I'm the most comfortable with,
you can code Rust with your editor of choice and easily target several platforms because projects can be cross-compiled,
and the standard library is available on all those platforms.
This is not the case for Swift where leaving Xcode ruins your developer experience,
and many utilities and primitives still live in macOS's `Foundation` framework.

Because I did not end up using it,
I forgot most of the things that I learned.
Therefore, I decided to get back to it, getting my hands dirty and applying the things I read about.
This blog post is a braindump of some thoughts that I've got so far.
Expect more of these to come in the future.

I like **its module system**.
It reminds me of Ruby's but is more opinionated about the file structure.
It encourages organizing the code in a modular fashion and ensures the file structure represents that structure.
In Swift,
for instance,
namespaces can be created leveraging language's constructions,
but the build system doesn't have any opinion on the file structure.
As a result,
it's common to see file structures not matching the code's.

The one thing that I haven't had the chance to work with yet is the **ownership-based** approach to memory management.
I think I've got the idea,
but it'll take some coding for the idea to click in my head and think in terms of _who owns what and for what_.
It's exciting to read that it's one of the features that makes Rust so unique because it leverages the build system to catch what otherwise would be runtime issues.

The **standard library** looks pretty complete.
Besides the basic types someone expects from a standard library,
there are also handy utilities like `Path` that are handy when building apps that interact a lot with the file system.
For instance, in [Tuist](https://tuist.io) we had to resort to a Swift Package to have such a model because `Foundation` does not provide it.

The collection of **community Crates** is enormous.
It's not at the level of NPM or RubyGems,
but I've found Crates for everything I needed so far.
I find this crucial when choosing a programming language.
You don't want to end up building something that someone else might have built before.

---

And that's it for this this post.
I'll continue playing with it and dumping my thoughts on this blog as I continue forming more mental models around the programming language and its tooling.
