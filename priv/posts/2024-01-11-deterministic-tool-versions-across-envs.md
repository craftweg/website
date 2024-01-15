---
title: "Deterministic tool versions across environments with Mise"
description: "Non-deterministic tool versions across environments is a common source of headaches in development teams. In this post, I share how Mise can help you solve it."
tags: ["Mise", "DX"]
---

A common source of headaches in development teams are issues coming from **multiple versions of tools used across environments.** The *"it works for me"* is often followed by a *"Which version of X are you using?"*. It happens because it's the developers' responsibility to manage their shell and the tools that are active in it through the `$PATH` environment variable, and CI environments, like GitHub Actions, offer their building block to manage the tools. For example, [setup-ruby](https://github.com/ruby/setup-ruby) takes care of installing Ruby in the GitHub Actions environment. It uses the convention of using the `.ruby-version` file to indicate the Ruby version to use, but what if locally, the developers are using a version management tool that doesn't follow the convention? Or what if they decide to manage the installation globally through a tool like [Homebrew](https://brew.sh).

This developer experience is far from ideal.
Some organizations decide to ignore the problem, perhaps because they are not aware of it.
Others like [Shopify](https://shopify.com) have an entire team dedicated to solving it,
which comes at a huge cost for the business.
What if you could solve the problem with little to no effort and cost?
That's what [Mise](https://github.com/jdx/mise) is for.
We are making it the default installation method for [Tuist](https://tuist.io),
and also evangelizing it to the Swift community,
where project setups have multiple tooling requirements.
For example, Ruby to run [Fastlane](https://github.com/fastlane/fastlane),
[SwiftLint](https://github.com/realm/SwiftLint) to lint the Swift code,
or [Sourcery](https://github.com/krzysztofzablocki/Sourcery) to do meta-programming.
Imagine managing these tools without a unified method that's consistent throughout the local and CI environments...

How does it work? Easy. Once you've installed Mise and added the hook to your shell, you can create a `.mise.toml` file at the root of your project:

```language-toml
[tools]
tuist = "3.39.3"
swiftlint = "0.54.0"
sourcery = "2.1.3"
ruby = "3.3.0"
```

Then you run `mise install` and Mise will install and **activate** the right version of the tools.
Note the "activate" part.
Mise ensures the right version is activated when you are in that directory or any sub-directory.
That prevents globally-installed versions from taking precedence over the ones specified in the `.mise.toml` file.

And what about CI? You can also use Mise. If you are using a CI provider like GitHub Actions, the process is very simplified through a custom action, [mise-action](https://github.com/jdx/mise-action):

```language-yaml
on:
  pull_request:
    branches:
      - main
  push:
    branches:
      - main
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: jdx/mise-action@v2
```

Mise is by far one of the best tools I've used for configuring and activate my environment for a project.
It's one of those tools that you install and forget about it.
[@jdx](https://github.com/jdx), the creator of the tool,
and a developer very passionate about creating terminal tools,
has done a fantastic craftsmanship job with it.
I'd recommend to give it a try.
You won't regret it.
