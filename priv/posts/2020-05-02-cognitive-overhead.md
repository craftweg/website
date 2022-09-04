---
title: Cognitive overhead
categories: ['ios', 'development', 'xcode']
---

Bootstrapping and publishing an app to the App Store is not a straightforward process. I tried to do it myself yesterday and a lazy me got stuck when I had to create signing artifacts, write automation scripts, and set up things on the App Store Connect side.

It made me think that Apple is imposing, perhaps without being aware, a barrier for newcomers to iOS development. As a newcomer, you want to code a few views, and get the app on Testflight so that you and others can try it out. This is what they need to do beforehand:

- Understand how signing works and what are certificates and provisioning profiles.
- Know how to set up the app’s build settings to sign the app successfully.
- Figure out the difference between build, archive, and export an app.

Many iOS developers nowadays don’t have a good grasp of how those things work because they are typically hidden behind an abstraction automation layer. Or in other words, some Fastlane files.

In the aim of streamlining this process making it possible to sign and upload the app without the cognitive overhead that the current process requires, I’ll try to leverage Tuist’s foundation to provide a very easy workflow:

- tuist init
- tuist connect setup
- tuist release

That’s how I imagine the process to be for the users, so I’ll start designing everything from there.
If you are into tools and frameworks development, I’d recommend start designing them from the experience that you’d like to provide to your developers. Otherwise, you might end up with something that is not user-friendly.

I’ll keep you posted on the progress that I’m making towards this.
