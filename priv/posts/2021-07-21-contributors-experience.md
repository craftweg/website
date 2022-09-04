---
title: Contributors' first experience
categories: ['open-source', 'contributions']
---

When building open-source software,
getting external contributions is usually one of the most difficult things.
Most of the times developers are busy working on their projects,
and they are hesitant to devote time to another project.
That's understandable.
Why would you?
They usually do it when they have feedback or find an issue that they'd like to share with the maintainers of the project.

In rare scenarios,
developers go further and contribute with code themselves.
It's a huge effort because they need to get familiar with a new codebase _(architecture, guidelines, patterns, business logic, testing strategies...)_.
This is where many contributors drop in the **contribution funnel**.
They had an idea for something to contribute,
but they felt overwhelmed by the project.
Have you ever been in that situation?
It's even worse when the project doesn't have documentation for contributors.
The only thing they can do is to clone the repo and figure things out themselves.
Unfortunately,
this works when the project is small,
but as you can imagine,
it becomes indigestible in large projects.

Because **external contributions bring diversity of ideas and new energies to the project**,
providng the **best contribution experience** is an important aspect in [Tuist](https://tuist.io).
There's still room for improvement,
but I'm glad of what we've achieved so far.
First of all,
we have documentation for contributors.
They can learn how to [get started](https://docs.tuist.io/contributors/get-started/),
[test](https://docs.tuist.io/contributors/testing-strategy) their changes,
and [report bugs](https://docs.tuist.io/contributors/reporting-bugs).
Moreover,
the project's modular architecture minimizes the surface of the things they need to learn before being able to contribute.
For instance,
if you want to optimize the generation of Xcode projects,
you can focus on the `TuistGenerator` target and ignore the others.
When everything is under `MyProjectKit` and the different components are strongly coupled,
contributors have a hard time reasoning about the project's logic and forming mental models.
[Tuist's architecture](https://docs.tuist.io/contributors/architecture) is documented too.

Furthermore,
we include a Ruby CLI tool,
[Fourier](https://github.com/tuist/tuist/tree/main/projects/fourier),
to automate all common tasks.
It also ensures that everyone's interaction with the project is consistent.
That makes it easy to debug reproducibility issues when they arise.

Contributors also have access to a [Slack group](https://join.slack.com/t/tuistapp/shared_invite/zt-g38gajhj-D6LLakrPnVCy4sLm24KxaQ) and [community forum](https://github.com/tuist/tuist/discussions) where they can seek advice and talk with other contributors and maintainers.
We are luckyto have a very supportive group of contributors that are always open to give anyone a hand.

One of the things I'd like to improve **next** is the configuration of the environment to ensure everyone's environment is consistent.
For example, ensure everyone is using the same Ruby, NodeJS, and Swift versions.
We'll balance building for contributors and users.
Both make Tuist the best tool of its class,
and therefore both need the same level of attention and support.
