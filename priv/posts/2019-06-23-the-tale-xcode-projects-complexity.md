---
title: The tale of Xcode projects' complexity
description: This is a short story of how Xcode projects can end up being very complex and hard to maintain.
tags: [xcode, projects, accidental complexity, swift]
---

The CEO of our company wants the product to have an iOS app. We embark on building it, so we start by creating the project: we open Xcode, select new project, and then Xcode dumps the following into a local directory:

![Project tale 1s](/images/posts/project-tale-1.jpg)

What a beautiful greenfield. We click run and the simulator opens almost instantly with our app running in it. We probably don't know about many of those files that were created and the content in them but _who cares?_ As long as we can compile it, it's all fine.

A few weeks later, the need of adding **dependencies** comes up. Someone in the team decides to introduce [CocoaPods](https://cocoapods.org). By then the project has got a bit more complex; there were a few build flags added to speed up compilation, and some build phases to customize the build process a bit. CocoaPods tries to do its best to integrate the dependencies into the project but it fails at it. We blame CocoaPods because we believe it's CocoaPods fault. We don't realize that Xcode exposes so much complexity that CocoaPods can't define a contract between the Pods project and ours. Our project became complex, it's normal, and it's not our fault. After Stackoverflowing a bit, we find out the hack that will make the CocoaPods integration work. _Awesome!_ Now we have external dependencies and we can add more if we need to.

Times goes by, the project continues to grow, and few months later, someone sees that **modularizing** the project helps with having clearly defined boundaries between features and better compilation times. The modularization requires creating a few frameworks, and therefore new targets with some files to configure them. It doesn't sound that hard. A few weeks later, the project is modularized. Some features have been moved into their own framework, others remain in the main app because their code is so tangled to the foundation of the project, that is impossible to extract them. Perhaps without realizing it, we end up with _similar projects and targets (build phases & settings)_ that barely reuse anything.

A year after we added the first line of code to the project, someone mentions the idea of replacing CocoaPods with **[Carthage](https://github.com/carthage)** because they heard its a better option. Someone said something about the source code being pre-compiled, and therefore faster builds. That sounds too good to be true, and it shouldn't be that much work according to the `README.md`. We add a few Carthage dependencies and our project doesn't compile; we added them as transitive dependencies of one of our frameworks and forgot to copy them into the app's bundle. Again, Stackoverflow has the solution to our problem: just a few tweaks and the project compiles. Since we want to be safe, we add the copy frameworks build phase that Carthage suggests to all the targets. Nothing can be wrong if I can compile the app and CI is green. Well... it is all fine until we try to release the app and Apple realizes that we are embedding frameworks that contain other frameworks. _What is this, inception?_

The time to migrate the version of **Swift** comes. We want to try the latest and re-invented APIs that Apple presented in the last WWDC. We don't want to be that old-school project or company that ues Swift 3. Oh nice! Xcode suggests doing the migration for us. They must know what they are doing... We are too naive. Xcode assumes that our project is simple but it's not. After clicking the magic button our project not only doesn't compile, but leaves us with over hundred errors that are caused by who knows which flag. _What do we do?_ Hopefully we use a version control system, so we revert the changes that Xcode introduced and do the migration manually. It turns out to be more painful than how Apple presented it during WWDC. Using the latest Swift version is worth the effort so we spend all the time that is necessary to do the migration. _Yay!_ After a week, we can consider the migration complete.

It's 2019, the flying bird knows how to drop packages in projects. It flies over our project, but it's confused. It doesn't know where to drop them. _How did we end up in this situation?_

![Project tale 2](/images/posts/project-tale-2.jpg)

## Takeaways

_Is there any part of the story that resonates with you?_ It's easy end up with a lot of accidental complexity if we are not aware of the implication of each of the changes that we are adding to our projects. Xcode projects are monoliths and barely allow reusing its pieces. Complexity makes the projects hard to maintain and migrate. We can see that when developers use Xcode's feature to migrate projects. _Hast it ever worked for you?_ Perhaps if it's a single-target application. We all know that one-target project is how we start but we eventually end up with many of them _(libraries, extensions, apps for other platforms)_.

_What can we do if we don't want to be there?_ The first option would be to wait for Apple to rethink the format of the projects like they do with hardware. I had some hope for this year but nothing was presented. Instead, they keep extending the project format, this time with the support for Swift packages. You probably didn't realize, but they leveraged the closeness of Xcode, to make a seamless integration of dependencies possible. They did what CocoaPods tried for a long time, but they couldn't because Apple didn't allow them to do so.

- **Default to simplicity but open to configuration:** Only expose details whose developers are interested in. Otherwise, default to default values.
- **Allow reusability of project elements:** Being able to define elements like build phases or schemes in one place, and use them from multiple projects and targets.

The second option would be using [Tuist](https://tuist.io), an open source tool that I'm maintainer of. It makes the definition of the projects more declarative and abstracts developers from all the intricacies that are often the source of the aforementioned issues. **Only if they need to**, developers can have fine-control over the low-level projects configuration.

Until Apple decides to invest in developers experience scaling their projects, you can give Tuist a try. I'd love to help you set it up if you are interested in using it.
