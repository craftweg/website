---
title: Module caching with Galaxy
description: Tuist has been of a great value for developers that found it difficult to extend their Xcode projects because Xcode exposed a lot of complexity to them. Having conceptually compressed those difficulties by leveraging project generation, it's time for Tuist to tackle a new challenge, reduce compilation times.
categories: [tuist, open source, github, xcodeproj, xcode, swift]
---

As I have mentioned in other blog posts,
the idea of building Tuist came from the motivation of making extending projects and easy tasks.
I was a bit fed up of having to manually create projects,
or being one of the few people in the team that was able to add projects without breaking anything in the graph.
Back then,
I made 2 conscious decisions that in hindsight were great ideas: _using Swift as the manifest language, and making dependencies between projects a first-class citizen_.
While first gave us validation of the manifest syntax and allowed reusing pieces of manifest content easily,
the latter made it easy to structure your project in multiple directories and let Tuist figure out the generation of targets, projects, workspaces, and all the settings that are necessary to get the linking right.

With **project generation** doing its job right,
and even though we don't support all types of products,
I feel it's time for me to take Tuist to a whole new level and tackle another challenge that I was also fed up with back during my time at SoundCloud: _Why do I have to compile everything every time my local cache is invalidated?_
Most of the times you are working on a module of your dependencies graph,
and you don't plan to change the others.
In that scenario,
it'd be great if I only had to compile the module that I'm working on,
and get a pre-compiled version of the transitive and non-transitive dependencies.
_Wouldn't that be nice?_

If you know about the [Buck](https://github.com/facebook/buck) and [Bazel](https://bazel.build/) build systems,
what I told you is a rought idea of what they do.
The idea of using any of those came up back when I was at SoundCloud.
We also pondered it at Shopify,
but we never embarked on implementing it because based on what we heard from other companies,
it'd require a lot of effort not only to make it work,
but to get developers to use it.
They are generic build systems so their focus is to get the build process right,
and not to ensure that they integrate well into the tools that developers like to use,
which in case of iOS I'm referring to **Xcode**.
Some companies that could invest time into implementing them ended up building tools to generate user-friendly Xcode projects.
For instance,
[Pinterest](https://github.com/pinterest) implemented and open source 2 tools: [XCHammer](https://github.com/pinterest/xchammer) and [PodToBuild](https://github.com/pinterest/PodToBUILD).
The first one generates Xcode projects from your Bazel files and the last one generates Bazel files from your CocoaPods specs.

The spectrum between not having caching and having caching beyond local incremental builds is very wide.
If you are not a Google,
a Facebook,
a Pinterest,
or an Airbnb,
you will never consider adding Buck or Bazel to your projects.
If you use [Carthage](https://github.com/carthage),
[Rome](https://github.com/tmspzz/Rome) might be an option for external dependencies,
but what if _most of the code lives in projects within the same repository?_
_Would you move them to different repositories to benefit from Rome?_
Maybe you would,
but I personally wouldn't.
Having multiple repositories and dealing with versioning and dependencies is not something that I want to be doing in my day-to-day job.
Development cycles need to be fast,
and for that reason I don't think Rome is suitable for local frameworks.

With this sceneario in mind,
and having a very solid foundation in Tuist that we can leverage,
I'd like Tuist to help all its users by providing **caching.**
_How would that work?_ Roughly:

- A pipeline on CI would compile all the modules on CI that are cacheable. In case of modules that can target multiple architectures _(simulator or device)_, we'd compile them as xcframeworks.
- The compiled modules would be uploaded to a cache with a hash that uniquely identifies them based on their settings, files, and the hash of its dependencies.
- Users generating the project would get pre-compiled modules for the dependencies of the project in the directory in which they are positioned.

It's the same idea as Bazel and Buck, but leveraging Xcode's projects and build system instead of using a different build system that can't be well integrated into Xcode.
I already started working on it and I can't wait to share a first iteration of this feature.
By the way, the name of it will be **Galaxy**.
Any Tuist's user will be able to opt-in and take their productivity to a whole new level.

If you would like to test it out in your own projects as soon as it's available, [join our Slack channel](https://slack.tuist.io), and let us know. Your feedback will be very appreciated.
