---
title: 'All you need is tools 🛠'
description: In this post I talk about why investing in good tooling is crucial for projects to move steadily.
tags: [swift, ruby, fastlane, ios, android, shopify, engineering, tooling]
---

Almost a year ago, I joined the team _Mobile Tooling_ at Shopify. It’s a team that focuses on developing tools and infrastructure that mobile developers can leverage to build and release high-quality apps. It was the first time I had the opportunity to work full time on tooling, something that I’d had the opportunity to experiment with in some open source space.

> You can read [Mobile Tophatting at Shopify](https://engineering.shopify.com/blogs/engineering/mobile-tophatting-at-shopify-1) and [Scaling iOS CI with Anka](https://engineering.shopify.com/blogs/engineering/scaling-ios-ci-with-anka) to have an idea of the things that my team is building at Shopify.

Tooling is an area that is often disregarded. Since it doesn’t contribute directly to the product, most companies would rather have developers building the app, instead of building the tools that are necessary for that. What many companies don’t know is that having great tooling and infrastructure is vital for the projects to move forward steadily. It has a **significant impact on developers productivity, motivation, and the quality of the product** that is delivered to the end user.

In this post, I’d like to talk about why I think investing in tooling is crucial, some recommendations based on my experience, and bad practices that you should avoid in your tools.

## Why do we need tools?

### 🚗 More automation

When you work on a project, it’s common to end up doing a lot of manual and repetitive tasks. The first time you have to do something again, you don’t realize it’s the second time, but when you do it one more time, you notice there are a pattern and an opportunity for automation. **Manual and repetitive work should be avoided because it is error-prone and computers are better than us at it.** When those tasks are automated, not only they are more robust but save us a much time.

For instance, at Shopify developers used to spend a much time checking out PR branches and compiling the app to try out other developers changes. We spotted that and provided them with a command that they could use to download the app and launch it in a local emulator/simulator in a matter of seconds.

Like we do by abstracting code when it’s duplicated in several places, we should automate manual tasks that repeat over time. **Developers’ time is a valuable asset that you do not want to waste in repetitive work.**

At Shopify, we use Ruby for most of that work, but one can choose the language they feel most comfortable with. [Swift](https://developer.apple.com/swift/), [Go](https://golang.org/), [Rust](https://www.rust-lang.org/en-US/), or [Kotlin](https://kotlinlang.org/) are examples of languages that you could use as well. Shopify is a company that bet for Ruby and we have a lot of libraries and knowledge that we can leverage in our tools. Not to mention all the open source projects in Ruby, like [Fastlane](https://fastlane.tools/).

### ✨Reliability

Murphy [once said](https://en.wikiquote.org/wiki/Murphy%27s_law) that _if something can go wrong, will go wrong_. Things can fail at any time. Perhaps as a result of some flaws in the code or the environment where your app is running. When it happens, developers retry because most of the times it fixes the issue. _What if we could detect flaws or infrastructure failures and provide those retries automatically?_ Luckily, that’s something one can do with tools. Commands in the system, and we can know at any time how the execution is going and the result when it completes. With that information, we can provide a mechanism that retries the failures automatically.

We recently implemented automatic tests retries for Android and iOS. We leveraged `gradle` and `xcodebuild` respectively, analyzed the output of those commands, and retried the tests that could potentially be flaky. As a consequence, the stability of the pipelines improved and we could surface flakiness issues for developers to tackle them.

> We discourage bad test practices that make tests flaky but admit that some testing scenarios bring a lot of value and come with some inherent flakiness.

### 📲 Better insights

Tools are an excellent opportunity to surface insights about the project and the code. For example, if our tool abstracts the compilation of an iOS app and we have detected some warnings that can potentially become issues in the future, we can expose them on GitHub, and hint the developer how to fix them.

By having control on the tooling, we can also raise awareness when teams don’t follow good practices and conventions that are standard across the organization. We can raise an error if we come across an unacceptable practice, or output a warning if it’s not that critical. We can guide developers to improve the quality of their code and projects.

If your project is on GitHub, its [Checks API](https://developer.github.com/v3/checks/) is fantastic for this. You can report insights directly to GitHub, and they will show up on the developers PRs. You can add inline annotations and even send a markdown file as a report. We recently added integration with that API to our CI infrastructure. Now, all the projects at Shopify can leverage that integration to generate insights when the pipelines are run.

## Recommendations

### 🔋 Build trust with the users of your tools

If you want the developers to use your tools, you need to build some trust. Here are some ideas worth practicing:

- Be supportive, especially in the early stages of the adoptions of your tools.
- Collect as much feedback as possible.
- Be responsive when things are not working.
- Be honest when setting expectations.

One thing that you might struggle with at the beginning is the fact that only a few developers thank you when things are working, yet a lot approach you when they can’t do their work because of your buggy tool. What has worked for me is being empathetic by telling them how sorry I am about the tool not working as expected, and do my best to provide them with a solution as soon as possible. If the solution takes me some time, I think of a workaround that allows them to continue with their work.

### 👀 Observe

Although ideas sometimes come from developers, you can also spot areas to improve and propose tools yourself. Developers are so focused on building product, that they barely step back to see how they can improve their workflows with tooling. You are in the position to do it so don’t miss the opportunity. You can see what developers complain about on Slack, tasks that take way too much time, or common patterns that could be abstracted.

When you come up with a tool for an idea, make a proposal, present it to your team, and prioritize it in your team’s backlog. You might feel tempted to jump right into coding, but don’t let the excitement shift your focus.

### 📈 Incremental interface

As soon as the developers start using your tools, they’ll depend on their interfaces. Be mindful when you evolve the interface, embrace semantic versioning, and avoid introducing many breaking changes. Before introducing a breaking change, think if it’s possible to introduce a non-breaking change that helps developers transition towards the new interface. If you release a many breaking changes and force developers to change their code with every new version, you’ll frustrate and disappoint them, and that’s the last thing that we want.

If you are not sure about the interface that you designed, **validate it first**. You can find a project and work with the team behind it to validate your assumptions and introduce the necessary changes to make the interface convenient and flexible for other teams to start using it.

### ✅ Metrics

Measure your tools. Understand how developers are using them and how efficient they are. Measure whether they behave as expected, or they have some bugs that need to be tackled. Get metrics that are handy for developers to improve their workflows. For example, if your tool helps to compile a project, measure how often the project gets compiled, the average compilation time, how many times it fails, which tests are the ones that fail the most.

Measurement not only helps you improve your tools but the teams to improve their workflows. It’s an everyone wins effort.

### 🚀 Sell the tool

You don’t want to implement a tool that no one wants to use, do you? Once the tool is built, market it internally and do some work on getting the teams to use it. Don’t publish it on a GitHub repository and expect the users to grow as if by magic. You can talk to entrepreneurs about this, and I’m sure they’ll give you many tips of things that they do to get more users into their products.

As a good product, make sure it’s documented, has a rememberable name, and provides easy instructions to get onboard. Don’t be a developer and think the only important thing in the tool is the code. If it doesn’t appeal to them from the outside, they won’t use it.

[Fastlane](https://fastlane.tools) is an excellent example of a well-marketed tool. You can use it as a reference to market yours.

### ❇️ Integration tests

Tools often have a contract with other tools and services. For example, when you wrap the compilation process of an iOS app, the tool needs to meet the contract with `xcodebuild`. The most reliable way to know if the contract is properly met is by running a test that tests the integration. Same goes when your tool interacts with HTTP APIs. Although you can use the documentation to implement the request generation and the response parsing, you’d better test it with real data coming from the API.
As opposed to apps, where the contract with internal backend APIs is more predictable, and changes are communicated beforehand, the environment and the services the tools depend on are not that predictable.

As an example, at Shopify, we run our actions which wrap `xcodebuild` and `gradle` with real builds of fixture projects. If they interact with any REST API, we record real responses using [VCR](https://github.com/vcr/vcr) and use those responses for the tests.

## 👎 Bad practices

### 💔 Carelessness

For some reason we, developers, don’t treat tooling with the same level of care as we do with the main code of the project. I thought it was because usually the tools are written in a language other than the project’s but a colleague of mine proved me wrong. In my experience in different projects, the tools are usually not that well structured, don’t include tests, and the code is a bit unmanageable. If you need an example, you can think about `Fastfiles` or the bash scripts someone added to the project a while ago. That code that has grown and been tweaked several times until it became the fragile piece of code that your team depends on.

I think tools should be treated with the same care as the project’s code. It should be structured and tested regardless of the language it’s written in. **If you don’t put love on that code, no one in your team does**, and all of you end up depending on a piece of code that can break at any time. _Do you need an example? Have you ever experienced painful releases because the script that is responsible for pushing the app to the store broke without no one in the team noticing it?_

### 🐞 Deficient error handling

How often have you seen a tool blowing up an error which outputs the whole stacktrace. _Is it valuable for the developer using the tool?_ No, that’s handy for the developer that writes the tool. The users of the tools need to know what happened, and why they couldn’t achieve what they were trying to achieve. **What caused the problem is an implementation detail that shouldn’t be exposed to the user.** If you are writing the tool, it takes more work to handle all possible scenarios, but by doing that you’ll offer the users a better experience, and they’ll be thankful for that. What's more, if you output a stack trace, they’ll think the source of the problem is in the tool itself.

### 💥 Noisy output

In comparison to non-CLI software, like web or mobile apps, the interaction with the tools happens through the standard input and the standard output, what they type and what they see in the terminal. **There’s only one channel to communicate things to the user, so we have to use it well.** We might feel tempted to dump anything, but that results in a bad experience because we may present information that is irrelevant to the user. Not showing enough information is as bad as showing too much. If we show nothing, the developer might think that the process got stuck and that they should interrupt it. Too much information might make the developer feel overwhelmed. Whenever you plan to add an output, answer this question: _“Is this useful for the user?”_. If it’s not, don’t output it. See the terminal as a constrained canvas where strokes are expensive.

## 🤲 Open source and third-party tools

Also, last but not least, I’d like to touch the usage of open source and third-party tools briefly.. When you build tools, you don’t need to build everything yourself. _Does your tool need to have error reporting?_ You’d better consider third-party error tracking services that offer SDK in multiple programming languages. _Do you need to process some snapshot tests images?_ You can find a lot of libraries out there that help you with the image processing.

Don’t spend your time building something that someone has already built. If it’s reliable and helps you solve your particular problem, it’s worth a try. It might happen that the dependency doesn’t fit your needs exactly as you planned. In that case, you can either make a contribution upstream to the project or fork it out and modify according to your needs.

For instance, at Shopify, most of the automation was done with Fastlane. It saved us much time and allowed teams to build their tools easily by combining the lanes that Fastlane provides. However, we’ve reached a point where we need more standardization and reliability which is unfeasible to achieve with Fastlane. We are replacing some of its features with a solution more tailored to our needs. Some of the tools that we build use Fastlane internally, but **it’s on us how the framework is used, not on the users of our tools.**

—

As you have seen, working on tooling is **exciting and challenging**. The process of bringing tools into developers’ workflows goes from the conception of the idea, until the marketing step, including the design, proposal, and development of the tools. Not only you grow as a developer but **learn how to collaborate with other teams in your company, how to listen to them, and how to leverage your experience** to provide the best solution for their problems and needs.

If you found it exciting and you’d like to speak further, don’t hesitate to leave a comment or write me an email. We, mobile toolers _(if that’s an accepted word)_, go through similar struggles so the more we share, the more we can learn from each other.

Have a nice week!
