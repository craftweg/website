---
title: 'A journey into Frameworks - Le Testing Framework'
description: 'One of posts that tells about the migration from a monolithic architecture based in single target to have multiple reusable Frameworks.'
categories: [xcode, ios swift, objective-c]
---

I’ve been lately focused on architecting the apps in multiple frameworks that are platform independent. I’ve also given [some talks] about it and applied these principles to a personal project, [GitDo]. However, who could benefit most from that architecture that would be SoundCloud. I proposed it internally and started taking the first steps on one direction. Being a so consolidated project used by many users around the world makes things more complicated compared to GitDo, but… let’s accept the challenge, shouldn’t we?

The application was organised in one single application target whose external dependencies were brought with CocoaPods as static libraries. We hadn’t moved yet into Swift so we kept the libraries as static so that we didn’t affect the application launch time. Once we had an idea of how the frameworks stack would look like we designed how the iterations would be. We’d create these frameworks progressively, starting for those at the bottom (foundation frameworks) and going up in the stack. The two big frameworks in the bottom would be **Core** and **Testing**. **Core** would be the framework that includes the Foundation components such as _ReactiveCocoa_, _CocoaLumberjack_, _Crashlytics_, … These are frameworks that are needed from all the layers since we log from all of them, or report errors whenever any is thrown. The brother of this one would be **Testing**. In the same manner, this one would include foundation testing components such as testing libraries like _Specta_, _Expecta_, or mocking ones, _OCMock_, _OCMockito_. This one would also include any helper class that we created to automate testing tasks that we repeated over an over.

Between these two **Testing** was the first one. I had to redo the setup of this one multiple times until I found the setup that match our needs. We want the Frameworks not to affect the launch time _(since a lot of them does)_, avoid conflicts when changing between branches and commits, and have a very robust setup that didn’t break with language or IDE updates. These are the setup configurations that we tried and why we decided to move away from them:

- **External dependencies manually fetched into the project and separated in Frameworks**: We fetched the external dependencies manually, put them into its own folder, and created a framework per dependency _(plus the Testing one)_. We ended up with around 8 Frameworks just only for testing. That setup wouldn’t affect the user launch time since only the Testing targets would be linked against them, but that setup for other Frameworks would make the launch time slower. Moreover the manual fetching caused one of the developers, to be the contributor in the project of these external dependencies code _(which is not true)_.
- **External dependencies manually fetched into the project and one Framework**: Dependencies would still be fetched manually but instead of adding them in separated Frameworks that Testing would link against to, all of them were part of the same Testing framework. We did setup the Testing framework to work with all these dependencies in the same place and it worked pretty well. However, we still fetched the source code of these external dependencies manually. These dependencies would be part of our source code, and we didn’t want that.
- **External dependencies with git submodules and one Framework**: This setup is similar to the previous one but instead of adding the external dependencies as part of the project we just fetched them with git submodules.

> For those who might wonder we not CocoaPods for all the setup there’s a couple of reason. The first reason is that we’re not going to be versioning for the first iterations of this setup. That makes hard to work with that setup in teams since CocoaPods would be caching versions of the frameworks and wouldn’t take the changes. The second reason is that if we use the `use_frameworks` flag, it converts all the dependencies into Framework. That would turn into more than 20 Frameworks for the project _(And [according to Apple] it shouldn’t be more than 6 Framework if you don’t want to get your app startup time affected)_

## Steps

It’s not that hard as it seems, but we are so used to let CocoaPods that we forget about the _”what’s behind_.

1. Create a Framework. In our case we called it **Testing**.
2. Setup the project to use a [multi-platform configuration file] for that Framework. You should be able to compile the Framework for more than one platform.
3. Fetch the external dependencies that you need using Git submodules. Each dependency should be in a different directory. Add the source code of these dependencies as source files of your Framework.
4. Check the `.podspec` of these dependencies. Some might need some especial flags or be linked agains a system Framework. In that case, make sure you link your Framework agains these frameworks and add these flags.
5. You might need some macros or custom setup if these external dependencies code is not valid for all the platforms. In that case, fork the dependency and modify these things that prevent you from compiling the Framework for other platforms.

> Note: You might find some external dependencies as already compiled Frameworks _(e.g. Crashlytics)_. In that case, add the Framework as part of the project and link your Framework against these Frameworks. They’ll probably offer a binary per platform. In order to keep your Framework multi-platform you should play with the _Frameworks Search Path_. You should point that attribute to a different folder depending on the platform:

`gist:pepibumur/79ce98a26949e20d526acb201359433b`

## Next steps

Once the **Testing** framework is defined these testing dependencies can be removed from the `Podfile` and use the Framework instead. It can be easily linking from the application target _Build phases_. You’ll probably have to refactor some imports because they were importing the external dependencies directly. It becomes simpler thanks to the Framework.

```objective-c
@import Testing;
```

The next one in the list: **Core**

### Enjoy frameworks!
