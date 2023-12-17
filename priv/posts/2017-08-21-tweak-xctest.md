---
title: Little tweak to be more productive writing XCTest tests
description: Because readability might compromise productivity.
tags: [xcodeproj, swift, xcode]
---

**Are you using [Quick](https://github.com/quick/quick) or [Specta](https://github.com/specta/specta) for your XCTest unit tests?** They provide you with a nice DSL to define your tests in a more descriptive way using the keywords: _“describe”, “context”, “it”_. Although it makes your tests more readable, it breaks the integration of XCTest with Xcode. The example below shows a test written with Specta:

![An example of a test using Specta](/images/posts/xctest-specta.png)

At [SoundCloud](https://soundcloud.com), we found the process of executing a single unit test with Xcode a bit cumbersome when using one of those DSLs, especially if your tests target contains a lot of tests. By using plain XCTest, Xcode automatically shows you a play button next to your tests that you can click if you want to execute that particular test. With a DSL there’s no play button next to your tests. The only way to manually execute one is either using the exclusive keywords from the DSL or executing the tests once to see all the available tests in the “Tests Navigator”.

The example below shows a plain XCTest and the button to run that individual test:

![An example of a test using plain XCTest](/images/posts/xctest-plain.png)

Putting on a balance readability and productivity we decided to go for productivity, coming up with some guidelines to make plain XCTest tests very readable, and leveraging the IDE to be more productive writing and executing unit tests.

Since then running and debugging our tests is much quicker and pleasant.
And you? Do you use any DSL for your tests?

**Happy testing!** :tada:
