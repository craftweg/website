---
title: Xcode updates are fun
description: On this blog post I talk about Xcode updates and how painful they can sometimes be.
tags: [xcode, swift, ios, macos]
---

Last week we pushed the latest Xcode version to all the CI hosts. It's an exciting thing because you see the company projects keeping up with the tools, but updates are painful. There hasn't been any Xcode update that required any work other than installing it. We cross our fingers every time hoping for the update to be straightforward but we know that's being too optimistic. That never happens.

With Xcode 10.2, teams migrated their apps pretty quickly and we did our job installing Xcode on the CI hosts. Things seemed to be running smoothly until yesterday, when one of the teams tried to release a new version of the app to the store and the build failed. It's been two days of debugging and guess what, we haven't been able to figure it out yet. The app gets archived, but when we try to export it, the xcodebuild command gets killed by some other process that is out of our control.

We have tried many things but more we try, the more confused we are:

- It works locally but not on CI.
- One project succeeds but the other fails.
- The archive from CI can be successfully exported locally.

At this point I wish I had access to xcodebuild to track down where issue is coming from but I know that won't be possible. xcodebuild is a black box whether we like it or not.

Right today, I attended a React conference in Amsterdam, and one of the things that I observed is how great it is that the Javascript industry have access to the source code of most of the tools that they use. The software that they use might be buggy, but at least they have the option to dive deep into the code and help solve the bugs.

We are not that lucky. Try and error is our best friend to understand the closed tooling that Apple provides. I remain optimistic though, and hope for a future where tools are open like Swift and that helps make our Xcode updates painless.

How has your Friday been?
