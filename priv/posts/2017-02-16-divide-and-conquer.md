---
title: Divide and conquer
excerpt: How modularizing your apps is helping us to scale our Xcode app.
categories: [swift, scalability, apps, xcode]
---

> **Divide and rule** _(or divide and conquer, from Latin dīvide et īmpera)_ in politics and [sociology](https://en.wikipedia.org/wiki/Sociology) is gaining and maintaining [power](<https://en.wikipedia.org/wiki/Power_(social_and_political)>) by breaking up larger concentrations of power into pieces that individually have less power than the one implementing the strategy. The concept refers to a strategy that breaks up existing power structures, and especially prevents smaller power groups from linking up, causing rivalries and fomenting discord among the people.

More and more we see companies that run away from Xcode to try the dynamism of languages like Javascript on their mobiles apps. Just mentioning some examples:

- [Retrospective: Swift at Arsty](http://artsy.github.io/blog/2017/02/05/Retrospective-Swift-at-Artsy/) written by [Orta](https://twitter.com/orta)
- [Swift vs. React Native Feels](https://ashfurrow.com/blog/swift-vs-react-native-feels/) by [Ash Furrow](https://ashfurrow.com/).
- [React Native at Instagram](https://engineering.instagram.com/react-native-at-instagram-dd828a9a90c7#.vph72j14f)
- [React Native at SoundCloud](https://developers.soundcloud.com/blog/react-native-at-soundcloud)

Amongst other reasons, teams decide to give an opportunity to React Native because they want their teams to **ship features faster**, eliminate the compile-install cycles or overcome scalability issues that they are facing because of the team and project's growth. It's a reality that the tools and the patterns that Apple gives us don't scale. While everything works when the app and the team are small, it quickly becomes a nightmare.

- Slow compilation times.
- Slow testing cycles, it makes TDD impossible.

If we counted the time we spend on these slow cycles, we'd notice the amount of time that developers spend unnecessarily. Moreove, motivation in the team goes down. It takes a lot of time for them to build something, and the product managers are putting pressure on them to deliver features fast. The company thinks that it's a matter of people in the team, and they hire more, but the productivity stays the same.

Other companies, like Spotify, have preferred to moved that dynamism to the server _(with their [Hub Framework](https://github.com/spotify/HubFramework))_ and have developers focused on building components that they decide how to render with some backend logic. **Companies are desperately looking for dynamism in their projects that is not given by Apple and their tools.**

I'm not against React Native, I like it, and the direction all these projects are taking makes total sense. But this whole movement that is becoming a standard makes me feel sort of sad. It's becoming standard to open Medium and read an article about a new company trying React Native. Developers and companies need to find their workaround to a problem that I'd expect Apple to fix it. It seems to me that they didn't stop to think about how their tools allow projects to scale. How could Facebook build their apps using Xcode or the command line tools? How can developers do TDD in large projects avoiding these slow build/run cycles?

At [SoundCloud](https://soundcloud.com) we were suffering similar pains, build and testing times were a nightmare, our Core Data model didn't scale anymore, and the engineers in the team were looking forward to starting doing pure Swift in the apps. Although React Native has always been around, we've been figuring out with the help of everyone in the team and other companies, how to tackle these issues with the tools our developers are familiar with, Swift, Objective-C and Xcode. It's been very challenging, and thanks to this awesome team's effort we're seeing some light and changes start having a huge impact on the app and teams' performance.

> We're making our Xcode project **great again**.

To add up to the lack of dynamism, our extensive use of Core Data didn't scale either. We shared a data model across the whole app. We were suffering performance issues, and our architecture was much Core Data dependent.

Surprisingly the solution started with something very simple:

**Dividing and conquer**

Our app was a monolith. One target with the source code, another one for the specs, and the rests from CocoaPods for the external dependencies. The bigger these targets are, the more they take to compile. Although Xcode doesn't recompile the targets that didn't change, sometimes it has to, for example:

- When it's a clean build.
- When Xcode messes it up _(something it's very likely to happen)_.
- After doing `pod install`.

Inspired by other companies, and our [micro services architecture](https://developers.soundcloud.com/blog/microservices-and-the-monolith), we built a similar approach. The fact that we splitted the monolith into smaller pieces made workflows faster; developers could modify a class, or a test, and build/run the tests in a matter of seconds. We started modularizing our iOS application.

![From monolith to frameworks](/images/posts/monolith_to_frameworks.png)

It was just the first step toward that project environment we were aiming for. Soon we noticed the fact that frameworks didn't have to talk to the existing Objective-C code base allowed teams to do pure Swift _(at least in private)_. They didn't have to deal with the bridging all the time as it was happening in the primary application target. The motivation went up; Swift was becoming real!

It was also a good opportunity to review **how** we were building the iOS app, the code architecture. [@garriguv](https://twitter.com/garriguv) iterated with the team over what would be the Swift architecture for the project. Defining things such as:

- How and where we would fetch the data from.
- How the architecture elements would fit in all the frameworks.
- How teams could be components that could be reused by other teams.
- How the interfaces should look like to ensure a compatibility with the existing code base.

Everything was moving at a good pace. We decided not to rely on external dependencies and build everything by ourselves because it'd be easier to maintain. We focused on building just the things that we needed, keeping them simple and open to extension. Although we initially brought Quick and Nimble as dependencies, we soon figured out that they were breaking the good integration that Xcode has with plain XCTestCases _(allowing you to run the tests directly from the IDE editor)_. We stepped back and reverted the few unit tests that we wrote to be plain XCTest.

We also came up with testing guidelines. We didn't have the Objective-C runtime, and libraries like `OCMock` or `OCMockito` on Swift and people followed different approaches for mocking and generating data. The fact that we're a very proactive team led Graeme, one of my colleagues, to come up with testing guidelines that the team could stick to. Furthermore, we added a `Testing` framework, where all our custom expectations and testing helpers would be. Whenever a developer came up with a testing component that could be shared with the rest, he/she could add the component to that framework.

As I mentioned earlier, Core Data was extensively used. We were hitting some performance issues and most of our features were very coupled to Core Data. Data that didn't need persistence ended up persisted, data that was very critical, got removed because migration issues in other models, our model concurrency was limited to prevent threading issues. We learned from companies like Facebook, Linkedin that moved away from shared models and embraced distributed stores with immutable models. If you haven't watched these talks, I recommend them to you:

- [Inside the Big Blue App](https://www.youtube.com/watch?v=-G8nZpif1rA)
- [Facebook's iOS Infrastructure](https://www.youtube.com/watch?v=XhXC4SKOGfQ)
- [Rocket Data: Faster Model Management for iOS](https://engineering.linkedin.com/blog/2016/07/rocket-data--faster-model-management-for-ios)
- [Engineering the architecture behind Uber's rider app](https://eng.uber.com/new-rider-app/)

Features data will be persisted _(if needed)_ in different stores, deciding about the invalidation policy, if migration is supported, and providing APIs in case other parts of the app need to access the data that they are storing. Developers don't have to worry anymore about Core Data, and the big shared model that we're currently maintaining. The immutable nature of the models will prevent a lot of threading issues.

We were inspired by the components driven movement. By building your UI in components you make these components more reusable. You can drag & drop them in different parts of your apps without caring much about what's inside the component.

> Let's say you work on all the engagement features, for example, likes. Instead of exposing the access to the data, you could expose a like button _(that can be customized)_. The like button responds to actions _(triggering data operations)_ and updates its state accordingly _(observing data changes)_

In our previous setup, adding a like in a cell, involved changes in the cell, the presenter, the data source. The only change that is needed with the components-based approach is the UI layer. That's it!

![Divide and conquer](/images/posts/divide-components.png)

---

I'm very excited about the direction of the project and all the challenges to come. Although we are not that close to the dynamic experience Javascript and React Native provides, we're getting better compare to the experience we have with the monolith approach. There are things that we'd like to try, like [Buck from Facebook](https://buckbuild.com/). The build tool that speeds up builds with a powerful distributed cache _(the support with Swift and dynamic frameworks is not that good yet)_.

Although it seems a very straightforward journey, it isn't. Migration can be a nightmare because all the dependencies that your components might have. _Where should I start from?_ _What if I build this abstraction layer here that gives me some flexibility?_ Delegation to the app will be your best friend during the migration.

And closing with one good tip: **control the excitement**. An empty framework is a white canvas for developers; they can start adding code without many constraints. The guidelines that you have for the app doesn't work anymore for the new architecture, and it's crucial that you come up with some. Otherwise, you'll easily find yourself with inconsistencies on APIs and patterns.

**Don't forget to document the architecture in your frameworks**

---

## If you want to join us in this exciting journey and help connecting people through music, SoundCloud is looking for [iOS engineers](https://soundcloud.com/jobs/2017-01-23-ios-engineer-berlin).
