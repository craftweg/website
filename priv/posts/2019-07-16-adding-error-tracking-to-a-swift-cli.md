---
title: Adding error tracking to a CLI written in Swift
description: Trying to add error tracking to Tuist, I realized how the process is not very straightforward. This blog post describes the process that I followed to help other Swift developers add error tracking to their CLI tools.
categories: [tuist, swift, swiftpm, xcode]
---

Software is written by imperfect creatures,
humans,
and as a consequence the imperfection manifests in the software in the shape of bugs.
Languages like Swift can help us write free-of-bugs software,
but they'll never be able to help us get rid of them entirely.

When bugs happen,
it's crucial to be notified automatically with the right information that helps us debug and fix the bug quickly.
That's why platforms like [Crashlytics](https://try.crashlytics.com/) or [Sentry](https://sentry.io) exist.
They provide an SDK to add to your projects that collect handled and unhandled errors and report them to a web service.
If you are an iOS developer,
you are most likely familiar with them.

[Tuist](https://tuist.io) didn't have error reporting,
making it hard to know when errors happened and why.
Moreover,
we were relying on users to know about bugs.
If they didn't create GitHub issues,
we had no way to know that they were facing bugs while using the tool.

I recently worked on adding error reporting to Tuist,
which turned out not to be an straightforward task.
This blog post is a summary of all the steps that I followed.
Developers building command line tools using the [Swift Package Manager](https://swift.org/package-manager/) might find this blog post useful.

## Download the dynamic framework

The first thing that we need to do is pull the dynamic framework of your error tracking platform.
Most services provide a dynamic framework,
if not,
you can ask them for it.
[Here's](https://github.com/getsentry/sentry-cocoa/releases) for instance the list of Sentry releases,
which contain the dynamic framework attached to it.

> Setting up error tracking with a static framework it's also possible, but in this post I'll focus on the dynamic approach.

Place the framework under `./Frameworks/` _(e.g. `./Frameworks/Sentry.framework`)_.

## Generate an Xcode project that links against the framework

Once we have the framework,
we need to tell the Swift Package Manager to set up the generated Xcode project to use it.
Although there isn't a public API that we can use from our project's `Package.swift` file,
there's an undocumented API that we can leverage.
Create a file, `MyTool.xcconfig`,
where `MyTool` is the name of your tool,
and add the following content:

```xcconfig
LD_RUNPATH_SEARCH_PATHS = $(inherited) $(SRCROOT)/Frameworks
FRAMEWORK_SEARCH_PATHS=$(inherited) $(SRCROOT)/Frameworks
OTHER_LDFLAGS = $(inherited) -framework "Sentry"
```

- **LD_RUNPATH_SEARCH_PATHS**: Defines a list of directories where the dynamic linker can look up the linked frameworks. We are adding `$(SRCROOT)/Frameworks`, which is the `Frameworks` directory relative to the path where the generated Xcode project is.
- **FRAMEWORK_SEARCH_PATHS**: Defines the directories that contain the frameworks to be linked during the compilation process.
- **OTHER_LDFLAGS:** With this setting we include the linker flag `-framework Sentry` to link against the Sentry framework. You'll need to replace Sentry with the name of your framework.

With the file `MyTool.xcconfig` in the project directory, we can run the following command:

```
swift package generate-xcodeproj --xcconfig-overrides MyTool.xcconfig
```

Notice the `---xcconfig-overrides` the argument that indicates the SwiftPM to use a different xcconfig file for the generated Xcode project.

Try to import your framework and use its API. The Xcode project should compile:

```swift
// main.swift
import Sentry

// Your setup logic
```

## Build the Swift package from the terminal

If you try to run `swift build` at this point,
it'll fail.
Although the generated Xcode project includes the build settings to link against the framework,
SwiftPM doesn't use the Xcode project to compile your tool and therefore,
it doesn't know how to link the framework.

Fortunately,
the `swift build` command accepts arguments to be passed to the compiler:

```bash
swift build \
  --configuration Release \
  --Xswiftc -F -Xswiftc ./Frameworks/ \
  --Xswiftc -framework -Xswiftc Sentry
```

If we run that command, we should get the tool compiled and linked dynamically against the framework.

## Add the runtime path

If we distribute the binary under `.build/release/MyTool`,
users will get an error when they try to run it from the terminal.
Since the framework is dynamically linked,
the linker will try to link the framework at runtime and will fail because it won't be able to find it.

To fix the issue, you need to make sure of 2 things:

- The frameworks is copied as part of the installation.
- The directory where the framework is placed is part of the binary runtime search paths.

If we assume we'll copy the framework into the `/usr/local/Frameworks` directory,
we can run the following command to add that directory to the runtime search paths.

```bash
install_name_tool -add_rpath "/usr/local/Frameworks" "/path/to/MyTool"
```

After running that command,
and having the error tracking framework in that directory,
you should be able to run the tool successfully.

## Conclusions

As we have seen,
the process is not as straightforward as it could be with other programming languages like Swift.
The complexity comes from the fact that the SwiftPM doesn't provide an API to link against existing pre-compiled dynamic frameworks, nor a way to handle the installation of the tools and its dependencies in the user's environment.

I hope you found the blog post useful and that it encourages you to add error tracking to your command line tools written in Swift.
