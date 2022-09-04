---
title: Keeping up with dependencies updates
excerpt: A brief reflection on Dependabot, a tool that was recently acquired by GitHub and that helps automate the process of updating dependencies on your GitHub repositories.
categories: [open source, github, repository, dependencies]
---

Keeping dependencies up to date is and important task that we shouldn't disregard because updates sometimes bring **security patches and improvements** that we might want to benefit from in our projects. Unfortunately,
most teams don't pay enough attention to this, and just focus on developing the product on top of a specific version of frameworks and libraries.

The good thing is that keeping up with the upstream changes has never been so easy.
In my projects,
I configure [Dependabot](https://dependabot.com/),
a tool that GitHub acquired recently and whose role is automating the process of updating dependencies and letting you make the final decision of testing & merging the PR.

I set up Dependabot in all my open and private source repositories.
It requires no configuration to start working, which is great, and allows you to customize things like the frequency at which dependencies are updated.

One feature that I requested on Twitter and that they mentioned they are working on is support for updating Swift Package dependencies. The Swift community will be so grateful of seeing Swift Packages been supported. I can't wait to use it to update [Tuist](https://tuist.io)'s dependencies.
