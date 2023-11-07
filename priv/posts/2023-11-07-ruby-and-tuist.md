---
title: "Making Tuist easier to work with by saying goodbye to Ruby"
description: "We're removing Ruby from Tuist, integrating everything into Xcode, replacing Fourier with bash scripts, and rewriting tests in Swift for ease."
categories: ['Tuist', 'Development Tools', 'Ruby', 'Automation']
---

At some point in the life of [Tuist](https://tuist.io), we decided to introduce [Ruby](https://www.ruby-lang.org/en/) into its codebase. The **CI pipelines were beginning to contain a considerable amount of business logic**, and it was somewhat inconvenient for developers to run the same workflows locally. Therefore, I developed a small Ruby-based CLI, which would be included in the repository as **Fourier**.

We also chose to implement the acceptance tests in Ruby. We believed that the [BDD approach](https://en.wikipedia.org/wiki/Behavior-driven_development), as proposed by [Cucumber](https://cucumber.io), would be most suitable due to its ability to produce very readable scenarios and prevent the tests from being aware of the Swift implementation details.

In hindsight, **it was a mistake**, and we are already taking steps to rectify that.

The main issue is that **it introduces friction to the experience of contributing to the repository for the first time**. In addition to Xcode, which we can safely assume developers have on their systems, they need to install the same version of Ruby that everyone else is using (to avoid inconsistencies), remember to run `bundle install` to pull dependencies such as Cucumber, and, not least, feel comfortable diving into Ruby code when things don't work as expected. Many developers may not have used Ruby before, and this task can seem very daunting, **resulting in them relying on us**—the maintainers—to resolve issues.

We also noticed considerable hesitance towards writing the tests. Beyond the fact that some steps' implementations needed to be done in Ruby—a task they could manage by referring to other steps—the Regex-based step definitions were also a bit intimidating. Once again, it was we—the maintainers—who would end up writing most of the tests.

*So, what are we doing about it?* We're removing Ruby from the codebase and integrating everything tightly into Xcode. We are **eliminating the Fourier CLI** and replacing it with universal bash scripts that require no additional tooling, some of which can be invoked through make. [ChatGPT](https://chat.openai.com) has been quite helpful here, as I'm not at all comfortable writing business logic in bash. We are also **rewriting our acceptance tests in Swift** so that they can run in parallel using Xcode and SPM. Developers will be able to execute these tests directly from Xcode and even add breakpoints to debug execution. This change will not only enhance the working experience with these tests but also create a faster feedback loop. This transition has been challenging because PRs took a long time to be ready for merging.

I am eagerly awaiting the implementation of these improvements. It's easy to make incorrect decisions like these, but it's crucial that we periodically reflect on them and adjust our course if necessary—and that's exactly what we are doing.
