---
title: "From side project to sustainable tool"
description: "Tuist, now 6 years old, has become essential for organizations using Xcode. While initially a side project, its popularity surged. To ensure sustainability, we're introducing paid features alongside free ones, navigating challenges like unauthorized forks and finding the right business model."
categories: ['Tuist', 'Scalability', 'Xcode', 'Developer Tools']
---

It's hard to believe, but [Tuist](https://tuist.io) is now 6 years old and has become an **indispensable tool for medium and large organizations**. I began building it due to my profound understanding of the challenges associated with using Xcode at scale and the inaccessibility of alternative build systems for smaller organizations. Tuist was always a side project — something I built in my spare time.

While I was at [SoundCloud](https://soundcloud.com), the organization didn't adopt Tuist until after I had left. Later, at [Shopify](https://shopify.com), I attempted to introduce it to address challenges they faced with Xcode. However, there was strong advocacy for using only Apple's official tools, so adoption didn't happen. Interestingly, the company eventually transitioned to [React Native](https://reactnative.dev/). While at Shopify, I hired developers I met through Tuist. This **led many to assume that Shopify used Tuist and sponsored me to work on it full-time.** In reality, I could only dedicate my spare time to it, and as time progressed, it became increasingly challenging. Eventually, [Marek](https://github.com/fortmarek) and the core team took over some responsibilities because I needed a break.

Throughout this period, **word of mouth** was effective. Companies initially approached Tuist for project generation but stayed for the additional features. Today, numerous organizations prefer Tuist over [XcodeGen](https://github.com/yonaskolb/XcodeGen) as they recognize that Git conflicts aren't the sole challenge of scaling. Defining Tuist is challenging; while many see it simply as a generator, it's much more. We eventually realized that **we had laid the foundation for significant optimizations and an integrated development experience.**

The project's popularity surpassed our expectations. With the increase in users came a proportional increase in time and effort. **Continuing on our personal time risked burnout,** which I wanted to avoid both for myself and other dedicated contributors.

So, what next? I researched open source sustainability models to determine what would fit Tuist best.

One idea was to **limit Tuist's scope** to easily maintainable features given our team size. But this would disappoint many users by reducing the tool to just project generation. Although this feature is reliable, extendable, and only requires major updates with new Xcode releases, we decided against this route. Users love the unique extensions that enhance their productivity with Tuist.

While we were eager to have full-time contributors, **donations didn't suffice.** They covered some costs but weren't substantial enough for salaries. We're immensely thankful to our sponsors for their support.

One potential path was to join a large tech firm, similar to [Fastlane](https://fastlane.tools/). However, such partnerships often prioritize corporate interests over solving real problems. In Fastlane's case, data became the focus under [Google](https://google.com)'s ownership. I also contemplated offering **consulting services**, leveraging our expertise. But the reception was lukewarm as most companies had either already transitioned or found their answers online.

We then considered models from similar tools, like [Gradle](https://gradle.org/) and [Nx](https://nx.dev/). These tools offer **server-side paid features** for advanced requirements, which seemed fitting for Tuist. Thus, we began working towards this model, even initiating the process of setting up a legal entity in Germany, Tuist GmbH.

**Simply put, if you need project generation, Tuist aims to be the best at it. For optimizations, we'll introduce paid features, priced reasonably in comparison to the benefits they offer.**

However, challenges emerged. A prominent Mobile DevOps company, [Bitrise](https://bitrise.io/), launched a service for Tuist users, requiring a Tuist fork. This experience taught us **the complexities of business dynamics**. We had previously communicated our intentions to them, so we decided to develop certain client features privately. Our goal remains to return to open source, but first, we need to ensure the project's sustainability.

Another issue was that some organizations **bypassed payments for Tuist Cloud**. While we tried to stress the importance of financial support, some viewed it as optional. Consequently, we're implementing measures to counteract these workarounds.

There are more discussions ahead, but this new phase for Tuist is crucial. We want to ensure that Tuist remains faithful to its core values and principles, delivering consistent value sustainably. Sustainability is central to Tuist's success, and I'm committed to realizing that vision.
