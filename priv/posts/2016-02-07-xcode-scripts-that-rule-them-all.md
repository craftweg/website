---
title: 'Xcode scripts to rule them all'
excerpt: 'Set of normalized scripts very useful for Xcode projects. Individual contributors will be familiar with them after they clone the project.'
categories: [setup, xcode, script]
---

![Scripts](/images/posts/scripts-rule-them-all.png)

I have been recently working on [SugarRecord 2.0](https://github.com/pepicrft/sugarrecord) and one of the things I tried to do for that version was making it easier for contributors to clone the project and start contributing with it. I realized a few months ago that [Carthage](https://github.com/carthage/carthage) and [ReactiveCocoa](https://github.com/reactivecocoa/reactive) had a folder called `script` with a set of normalized scripts. I cloned these projects, executed the script `bootstrap` there and I had the project ready to contribute with. Wow! that's awesome.

The idea was great, I copied these scripts cloning them from [this repository](https://github.com/jspahrsummers/objc-build-scripts) from [@jspahrsummers](https://twitter.com/jspahrsummers). He got implemented a set of very reusable scripts for any Xcode project. I've been using them since then. **Why?**:

- Developers don't need installing dependencies like Fastlane, Bundle Gems, ... Scripts are implemented using bash.
- Setup task turns into just one line of code in your console.
- You can build all your project shared schemes and use that build script for CI.

If you're working on Xcode projects, no matter if they're a company project, an open source library, whatever.. Add them in your project and leave a comment in the `README.md` explaining how to use them _(very straightforward)_.

### Where does the idea of normalized scripts come from?

This idea comes originally from [Github](https://github.com). It was a few weeks ago when googling, I found this [blog post](http://githubengineering.com/scripts-to-rule-them-all/) from the GitHub engineering team. They realized that thereis a set of repetitive tasks on any project that could be normalized in scripts. The decided to stanrdize these scripts and call it _Scripts to Rule Them All_. **What a brilliant idea**.

Thanks _GitHub_ for the idea and _@jspahrsummers_ for creating the equivalent version for Xcode projects.
