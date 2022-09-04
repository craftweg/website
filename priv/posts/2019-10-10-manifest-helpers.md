---
title: Project description helpers
excerpt: In this blog post I talk about a beautiful abstraction which Alex and I came up with to push Tuist's awesomeness even further.
categories: [tuist, open source]
---

Yesterday I had a pairing session with a good friend of mine who started introducing Tuist to his company's project. He brought up an interesting need that had been in the backlog for quite some time but that no one embarked on building it: reusing code across manifests.

I was so eager to build that feature into Tuist that I immediately proposed him to pair on it. It was a very fruitful exercise that we couldn't finish but got a fully functional prototype. If was excited before building it, my excitement skyrocketed when I saw it working.

In a nutshell, the solution that we adopted was compiling all the files under the `Tuist/ProjectDescriptionHelpers` in a module, and then linking the manifest against it. I think it's a simple solution, yet powerful.

With this feature developers can not only reuse code across manifests, but leverage any language abstractions to codify their projects: struct, classes, functions, enums, generics...

Here are some things that the new feature enables:

- Have a factory of projects or targets that given the name and some basic attributes, it returns a standard project.
- Define how build settings are generated and combined. If you never liked how xcconfigs or build settings are flattened, you can define your own merge logic.
- Projects can be defined in one line of code. I can't stress enough how great this is to ease the maintenance and creation of new projects.

Can't wait to finish it up and bring it to the users in the next version of Tuists. Until then, there are sone tests to add and documentation to write.

Happy coding!
