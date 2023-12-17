---
title: Evolving Tuist's architecture
tags: [tuist, open source, swift, xcode, project generation]
---

I'm flying back from Tokyo and took the opportunity to code a bit on Tuist.
Since I don't have Internet connection to get distracted with,
I decided to work on something that doesn't require Internet connection:
**improving the project architecture**.

I'm quite happy with how the project has evolved so far with the help of everyone involved in the project.
The slow yet steady pace of adoption in the community made it easy to keep en eye on the project's architecture while introducing new features.
Doing so is crucial to have a **healthy codebase that has little technical debt and allows adding new features easily.**

Over the project's lifetime,
we moved from a single-target project to a modularized one.
Perhaps because I was heavily influenced by my work at [SoundCloud](https://soundcloud.com),
where I introduced the idea of [Microfeatures](https://github.com/tuist/microfeatures-guidelines).
Although the main goal of modularizing the codebase was to improve developers' productivity,
it allowed identifying and defining different areas of responsibility that were represented as frameworks.
Teams worked independently but highly aligned thanks to shared utilities that were core to SoundCloud business domain.

I believe the benefits of having a modularized architecture for Tuist are the following:

- **Have owners and experts in different domains** of the code base.
  For instance,
  there can be an owner of the generation of Xcode projects.
  They'll make sure that manifests are properly translated into Xcode projects,
  and that the generation of Xcode projects is fast.
- **Ease first-time contributions** because new contributors don't have to get familiar with the whole codebase,
  just the domain that they are interested in contributing to.
- **Better design** because adding a new feature is not just adding a internal class that I can depend on from other classes.
  It requires defining where the feature should be implemented _(i.e. target)_,
  how the feature interacts with others,
  and what will be its public interface.
  At least to me,
  doing this type of engineering work is beautiful.

So far the areas of responsibilities, and therefore frameworks, that we have identified in the project are the following:

- **Support:** Contains Tuist-agnostic utilities.
  For example,
  there's a utility for interacting with the file system,
  `FileHandler`,
  or another one to output information to the user,
  `Printer`.
- **Support testing:** Contains Tuist-agnostic utilities for testing purposes.
  It also includes XCTest extensions for tests to use.
- **Core:** It contains utilities and models that are core to the business logic of Tuist.
  For example,
  the `Project` model is ubiqutuous to all the features of the project and therefore needs to be defined here.
- **Loader:** Contains the logic responsible for reading the manifest files and generating an in-memory dependency graph that is used latere on to generate the Xcode projects.
- **Generator:** Contains the logic that translates the in-memory graph into valid Xcode projects that developers can use to work on their features.

All targets have an associated `-Testing` targets,
which provide **test data** and **mocks** to the targets that depend on them.
This is another idea that I _"stole"_ from my time at SoundCloud and that I really like because you are facilitating future testing work.
Writing a test and realizing there are mocks for our test subject dependencies already defined is priceless.
Some people prefer to use tools like Sourcery for this type of work,
but I'm a bit old-school here.

There'll soon be another domain with its own target,
**Linting**,
whose logic is currently implemented as part of Loader.
Linters make sure that the project is in a valid state.
Otherwise,
they output errors and warnings to the users,
and depending of the severity,
they fail the project generation.
The goal here is to save developers some time debugging issues in their projects.

In a **nutshell**,
we can summarize Tuist's project generation as a sequence of **4 steps:**

1. Loading
2. Linting
3. Transformation
4. Generation

If we translate that to code,
we might be

```language-swift
func generarte(load: (AbsolutePath) throws -> Graph,
               lint: (Graph) throws -> [LintingIssue],
               transform: [(Graph) throws -> Graph] = [],
               generate: (Graph) throws -> Void)
```

Beautiful, isn't it?
We are not there yet but that's the idea.
Once we get there,
I'd love to explore the idea of allowing developers to define their own transformations,
either locally,
or imported from third-party packages defined as Swift packages.

There could be a transformation that adds a [Swiftlint](https://github.com/realm/SwiftLint) to all the targets:

```language-swift
final class SwiftLintTransformer: TuistTransformer {
  func transform(graph: Graph) throws -> Graph {
    // Traverse projects' targets and add the build phase
  }
}
```

Architecting code and projects is a pleasing exercise, and I love it!
