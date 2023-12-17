---
title: Open Source
description: In this blog post I talk about why I work on open source projects and what are the most important elements for me when starting an open source community.
tags: [open source, xcbuddy, swift, xcode]
---

I've been wondering how many things that I do, I do them because everyone does them. With everyone sharing how they do things, and pitching us their library, their work-style, or even their tools I think software engineers are strongly biased by external opinions, including me. Are you using VIPER because it's a good fit for your project's needs or because you saw a few companies using it? Are you using that library because it's saving you time, or because you saw an example of how to use it and you thought you could go with replicating the example?

Answering those questions has been eye-opening, and made me realize that some of my opinions and decisions were not made by myself If you have never done this exercise I encourage you to include an extra question when you have to make decisions:

> Am I doing this because everyone's doing it?

I don't like doing something when I don't feel passionate about it. It's easy to follow a trend and end up doing what everyone else is doing, but I prefer not to. Following trends and already formed opinions do not help with building yours; you repeat what others are saying. Sometimes it might happen that the conclusion that you have, is the same as others', and that's fine, but I think there's a considerable value in spending some time to form it.

**I asked myself the same question for open source**. I realized that I prefer doing open source software over private's. Open source has become an important thing in the software industry, and companies that traditionally didn't do any open source started doing it. **Am I doing this because of the trend?** **Why am I doing it in the first place?**.

This question led me to an answer which I think describes well what open source means to me and why I devote part of my time to it, **interaction with people**. I like working with people more than computers. Unfortunately, that's something you don't have a lot if you work in tech, where your best friend is your computer. That changes if you do open source because all of a sudden you are connected with people from all over the world working together towards the same goals.

For me, the beauty of open source is **creating community**. When I envision a new open source project, I like spending some time thinking about how I'd love the community to be. One of the first things that I do is **creating an organization** which they can feel part of. I could create the repositories on my GitHub profile, but it wouldn't be fair, in a sense that, they'd be contributing to a repository that belongs to me. I want them to feel they are contributing to something that also belongs to them. I use the [Aeryn](https://github.com/moya/aeryn) tool from the Moya community to invite contributors after they merge their first PR. That makes them feel part of the family and encourages them to continue contributing to the project.

Interacting with people is harder than doing it with computers and software. Different profiles of developers will land on your project:

- A developer who interested in contributing altruisticly because they like the idea behind it.
- A developer who contributes towards their interests.
- A developer who extensively uses it and reports a lot of bugs and great ideas.
- A developer who will make you feel like you are serving them and you should do whatever the asked you to do.

Working in open source has helped me improve my communication and interaction skills. Dealing with all different profiles and choosing the right language for every interaction is not easy. It's a challenge, but one of those challenges I enjoy going through. I still have a lot to learn, but I'm enjoying the process.

As an example, I recently started working on a new open source project, [xcbuddy](https://github.com/xcbuddy). It's been a few years working as iOS Engineer and suffered the pain of using Xcode at scale. Instead of keeping complaining I just decided to build a tool that helps teams overcome the most common challenges when scaling their projects. The first version of the tool is not ready yet _(and there will be a more extense blog post talking about it)_ , but I already established the foundation of the community around it. This is what I did:

- **Tweeter 🐦:** I built a simple service that publishes tweets with the most recent updates of the project. What's more important, it publishes when **there's a new contributor** that has joined the organization. It makes the community more inclusive, making them feel part of the community. I think inclusion is not only about having a markdown in the repository that says that your project/organization is inclusive. It's all about little actions, like this one, that makes everyone feel welcome and part of the project.
- **Slack-free 🔇:** Slack is great for real-time communications but in my opinion, not a good fit for open source projects where communications happen mostly asynchronously. Moreover, it's easy to lose track of discussions when there's a lot going on.
- **Spectrum 👥:** [Spectrum](https://spectrum.chat) is a tool for communities which I recently came across. I'm still evaluating whether it's worth using it or we should keep things simple and use GitHub for everything. I decided to create a community in Spectrum because there are things like introductions, ideas, or off-topic threads that are not suitable for GitHub issues.
- **Website 🌎:** I'm designing and developing a website, not only to explain to developers what the tool is about, but to praise, and thanks to contributors for the work they are doing. I think everyone deserves recognition for its work because, without them, most of the open source projects that we use nowadays wouldn't exist.

When it comes to building open source projects, the essential element for me is the **people that will make it possible**. Although I might be the primary driver when the project takes the first steps, most of the projects keep moving thanks to the energy and the passion which external contributors bring. Sometimes you feel down, or a bit burnout after a lot of work on the project and it's energizing to see that the project grows thanks to the work of people that you welcomed to the project back in time. I still have a lot to learn, and things to improve, like how to **be more transparent**, or **manage my time better**, but this ride is fascinating and I'll continue doing more work in the open.

I'd like to thank people like [@orta](https://twitter.com/orta) because they are an excellent source of inspiration for me when it comes to creating communities and doing open source by default.
