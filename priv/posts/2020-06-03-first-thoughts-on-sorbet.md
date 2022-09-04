---
title: First thoughts on Sorbet
categories: ['ruby', 'sorbet', 'types']
---

We started using [Sorbet](https://sorbet.org/) to add types to [Galaxy's codebase](https://twitter.com/appgalaxyio).
Types are great to catch type-related issues statically, and prevent them from blowing up on production.
This tiny blog-post contains my impressions using it for the first time:

- Sorbet has a great adoption process.
  It can load your codebase,
  analyze it,
  and add [sigil annotations](https://sorbet.org/docs/static) to the files.
- After adopting it, I was able to run `srb tc` successfully.
  Sorbet flags some of the files as ignored, and lets you gradually change the granularity of the type checks.
  That means you can adopt types at your own pace.
- The typecheck (`srb tc`) command runs incredibly fast and that makes it a good candidate to be part of your local development workflows.
- I don't like the syntax for adding type annotations, but I don't dislike it either.
  It feels a bit detached from the implementation code. For example, for annotating a method, I'd expect something along the lines of:

  ```rb
  def my_method(x: String): String
  end
  ```

- It can use runtime reflection to generate [Ruby Interface files](https://sorbet.org/docs/rbi) for third-party gems.

Overall, the impression has been quite possitive.
I don't many Ruby projects, but if I had to, I'd definitively set them up with Sorbet.
If you are a Ruby developer and you haven't checked it out yet, I'd recommend you to give it a try in one of your projects.
