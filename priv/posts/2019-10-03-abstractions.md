---
title: Abstractions
description: In this blog post I talk about abstractions in the Xcode projects domain and how Tuist leverages the concept to conceptually compress intricacies of Xcode projects that developers are often confronted with.
categories: [tuist, open source]
---

Most developers are familiar with the concept of abstractions. They are often used to turn a domain language into another language that suits the problem or set of problems better. Moreover, they can be leveraged to simplify things, or extend the abstracted element’s functionality. We have seen that over the years in open source libraries that aimed to simplify system frameworks such as UIKit, Foundation, or CoreData. Almofire, MagicalRecord, and SnapKit are good examples of abstractions that turned intricate APIs into a beautiful experience for developers. Those libraries **sparked joy**, which is a key element be engaged and motivated when we craft software. Let’s be honest, no one wants to spend their time understanding complex interfaces, figuring out how to use them safely, or working on repetitive tasks.

When abstractions are validated, they end up inspiring the evolution of the abstracted layers. We’ve seen Apple evolving their frameworks taking abstraction ideas from the community and other programming languages. UIKit will eventually be a vintage framework because developers already have a simpler, more beautiful, and declarative alternative, [SwiftUI](https://developer.apple.com/xcode/swiftui/).

Most of the abstractions that we see in the Apple ecosystem are code abstractions; there are plenty of libraries out there that you can use to improve the coding experience of the developers in your team. However, code is not the only element that requires abstraction. If you work on a large project, you probably know the domain that I’m talking about: Xcode projects.

Apps are no longer a single-target project in Xcode. Even apps that are not structured in modules (frameworks or libraries) have targets for dependencies, extensions, and apps for other platforms. Xcode projects evolved to support the unceasing growth of the Apple ecosystem, and that resulted in an interface to define your projects, Xcode projects, that exposes a lot of complexity. That complexity makes it a good candidate upon which build an abstraction. **Tuist** was conceived to provide that abstraction.

Tuist provides an abstraction that compresses Xcode complexities and allows developers to codify conventions. It does it by leveraging projects generation and Swift.

Working on Tuist, I came across many developers that compare Tuist to [XcodeGen](https://github.com/yonaskolb/xcodegen) and understandably end up concluding that Tuist is just another project generation tool. While it also generates projects, there are two subtle differences, that I think make Tuist a more suitable option for some projects.

**The first** of the differences has to do with conceptual compression. Despite how tempting it might be translating concepts and ideas one-to-one from Xcode projects to Tuist abstractions, we know that it results in leaking complexities and therefore we make an effort to compress concepts and provide a simple interface that Tuist defaults to. XcodeGen has good abstractions too, but it’s closer to the Xcode project’s domain.

When I was iOS developer at SoundCloud, I remember being certainly annoyed because breaking down the app required being familiar with many Xcode-specific concepts, and a fair amount of manual work. Only a few people in the team knew how to add more targets, and when issues arose, the rest of the team couldn’t make a guess on what the issue could be. The bus factor was high, and the complexity of the project grew significantly.

Creating a new project or target meant having answers for the following questions:

- How do I name it?
- Where do I place it?
- Where do I place it in the dependencies graph?
- What should be its configuration?
- How do I make sure it’s consistent with other targets?
- How do I make sure I’m not breaking anything?
- How should I set up CI?
- Should it be a framework or a library?
- Can it be a library but with access to resources?

What we did at SoundCloud, which I’ve seen in other teams, is having all of that documented. In practice that translates into teams having one or two people that know how to answer those questions right, and the rest of the team resorting to them. It might feel great if you are one of those people. I actually was. But as I mentioned earlier, that sets the bus factor high and adds dependencies that might slow down other people’s work.

For that reason, making things easier and opinions on the Xcode projects domain codifiable, was one of the motivations to build Tuist. For instance, one of the features that I put a lot of effort into simplifying was the definition of dependencies. With Tuist, defining a dependency is as simple as defining **what depends on what**. The build settings and phases that are required for that are an implementation detail. Moreover, and conversely to XcodeGen that uses YAML as a language to describe the projects, I decided to use Swift for a few simple reasons: it’d validate the syntax, users would get inline documentation while editing their projects, and most importantly, it’d make codifying opinions easy. For example, the targets that are part of a project can be defined by a function that acts as a factory of targets:

```language-swift
func target(name: String) -> Target {
  // Initialize and return the target
}
```

Doing that with YAML would require extending the specification to support it, which would end up leaking some complexity in the tool domain.

It might not be obvious from the code snippet above, but it’s a powerful idea that makes codifying opinions possible. Here are some ideas:

- All targets follow the same naming convention: `Prefix\(name)`
- They have the same files structure: Sources under `Sources/` and tests under `Tests/`.
- They run Swiftlint to lint the code.
- They depend on a set of foundation frameworks.

Being able to codify opinions makes being consistent easier, and as a result, scaling app your projects a pleasant experience.

**The second** difference with XcodeGen is that Tuist is not just a project generator. Project generation is the first step to be able to provide an easy and standard command line interface to interact with projects. This hasn’t been built yet because we are focusing on the project generation, but we’ll start working on it afterward.

Since comparisons often help understand concepts, you can think of it as [Fastlane](https://github.com/fastlane), but without having to write Fastfiles. The reason why Fastfiles exist is because the user needs to describe how their intents map to system commands. There are some important pitfalls of using that approach at scale:

- Not all lanes run on CI for every code change. As a consequence, lanes might break without no one noticing until they have to run the lane, for example when releasing the app. That’s very frustrated.
- Ensuring a good and clean structured mapper (Fastfile) in large projects with many developers contributing to it has been proven to be an arduous task. Developers see those files as a canvas where they can dump code, hacks, and any snippet they find on the Internet. As long as they can do `fastlane my_lane`, that’s all most developers care about. Not only that, but it’s easy to end up with inconsistencies in the name of the lanes. Is it `build_release` or `release_build`? Or maybe just `release`?

SoundCloud’s Fastfiles were large and complex, so are Shopify’s. It just happens, and it’s really hard to prevent it if we don’t have conventions and a way to enforce them. If we think about Rails, which has been a huge source of inspiration to design Tuist, any developer working with the framework knows that databases can be migrated with `rails db:migrate`, or that the server can be initialized with `rails server`. On Xcode projects, we don’t have such a user-oriented interface that reflects user intents. One might argue that there are tools like `xcodebuild`, or `simctl`, but they are closer to the system than to the user, they are not pleasant to use. Imagine we could just do `tuist keys setup` and we’d get the environment set up with the right certificates in the keychain to sign the app.

Tuist will provide an standard and user-friendly CLI with the most common tasks. It’s possible to do it reliably and with bare input from the user because they describe us the project and therefore, we know how to interact with it _(the contract)_. These are some commands that are good candidates to be implemented first:

- **Build:** Builds your app.
- **Test:** Runs tests
- **Run:** Builds and runs the app in the destination platform (e.g Simulator).
- **Release:** Archives, exports apps uploads apps. For frameworks, it’d build and export a distributable framework.

Graph is a command that has already been built in to export the dependencies graph representation. That’s something that surprisingly Xcode doesn’t provide, and that I believe is crucial to make informed decisions on the project structure.

---

This is where we are heading, and I’m very excited about the journey. Tuist gave me the opportunity to meet very talented developers who share the same vision and that are bringing a lot of illusion and ideas for the project. I applied one of Shopify’s main principles, trust, and that resulted in a very healthy and collaborative space which I’m very proud of. It’s a pleasure working with Kassem, Olliver, Marcin, Marek and so many other contributors and users that gave Tuist a try.

I had a few downs with the project, mainly because this is a long-term bet in a space where things move fast and Apple’s tooling have always more trust from the community. What makes me stay on track and motivated is having the opportunity to explore new ideas, being able to build them into Tuist, and help companies and projects to scale up.
