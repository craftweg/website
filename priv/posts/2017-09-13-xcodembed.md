---
title: Conditionally embed your dynamic frameworks
description: A command line tool written in Swift for copying the frameworks from your project to the output frameworks directory.
tags: [xcodeproj, swift, xcode, xcodembed]
---

As part of dynamic linking frameworks in your Xcode apps frameworks need to be copied into your app `Frameworks` folder. There are multiples ways to do so:

1. Add a new **Copy Files Build Phase**, selecting `Frameworks` as the directory where you want the frameworks to be copied.
2. Running a script that automates the copy step for you.

The most popular dependency management tools in the community use the second one. [CocoaPods](https://cocoapods.org) for example creates a new build phase called `[CP] Embed Pods Frameworks` containing all the frameworks that need to be copied. If you dive into the script you'll see that CocoaPods doesn't use those inputs and outputs _(although they Xcode exposes them as environment variables)_. Having your frameworks as input and outputs allows Xcode determine if the copy script has to be executed based on the changes in these files. Similarly, Carthage asks you to add an extra build phase that executes their script for copying the frameworks that they build under `Carthage/Build`.

**What if you want to embed a framework only when a given condition is satisfied?** For example when you compile the project for "Debug". You might want to link your app against a framework that is only used for debugging purposes. CocoaPods handles this but if you are not using CocoaPods, it's not possible without a bit of scripting.

I found myself in that situation and I was between modifying in the CocoaPods bash script, or coming up with something in Swift that other developers could easily install and use in their projects. I decided opted for the latter, and I added a new command to [**xcode**](https://github.com/swift-xcode/xcode).

You can easily install the tool using [Homebrew](https://brew.sh/) with the following command:

```language-bash
brew tap swift-xcode/xcodembed git@github.com:swift-xcode/xcode.git
brew install xcode
```

## A side note on xcode

`xcode` is a command line tool built in Swift that offers tasks that facilitate working with your Xcode projects. The first task supported by the tool is embedding frameworks, but there are more that are about to come, like cleaning build settings or linting your Xcode projects.

## Embedding your frameworks

If you have used Carthage before in your projects you might already be familiar with the process. You'll need an Xcode build phase in your project that runs the command passing the frameworks that will be copied. The example below shows your build phase should look like:

<br />

![An example of the Xcode build phase that uses the command to embed the frameworks](/images/posts/Frameworks-Embed.png)

1. We run the command `xcode frameworks embed` using bash.
2. We specified as input files all the frameworks that will be copied. The path can be absolute or relative to the project directory. Remember that you can use any of the available Xcode build variables, like `$(SRCROOT)`.
3. Similarly we specify where those files will be copied. The path should be `$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/MyFramework.framework` where `MyFramework.framework` is the name of the framework.

> Note: Input and output files must be paired. In other words, the output file x path is used to determined where the input file x will be copied.

**Besides copying the frameworks, the tool also copies the symbols and the `bcsymbolmap` files of your framework, stripping the architectures that are not necessary**. By default, the command embeds the frameworks for all the configurations. If you would like to do it only for some configurations, you can do it by just passing a parameter to the command above:

```language-bash
xcode frameworks embed -config Debug,Release
xcode frameworks embed --config Debug
```

> Out of curiosity, Xcode uses the input and output files to determine if the script needs to be executed. For example, if an output file is missing, or any of the input files changed, Xcode will run the script the next time your build your project.

## Big thanks

To [CocoaPods](https://cocoapods.org) & [Carthage](https://github.com/carthage) for diving into this issue in the past and coming up with their own solution to this problem. Both of them were a good reference for me to build up this command for `xcode`.

## References

- [Carthage copy frameworks](https://github.com/Carthage/Carthage/blob/master/Source/carthage/CopyFrameworks.swift)
- [CocoaPods embed frameworks](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/generator/embed_frameworks_script.rb)
- [Commander](https://github.com/kylef/Commander)

I hope you find the tool useful. Don't hesitate to open any issue or PR with fixes, ideas, comments!
