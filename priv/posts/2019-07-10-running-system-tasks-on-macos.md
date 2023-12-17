---
title: Running system tasks with Swift and Foundation
description: In this blog post, I talk about my experience using one of Foundation's APIs, Process.
tags: [foundation, swift, macos]
---

Have you ever tried to use Foundation's API on macOS to run system tasks?
Perhaps you know the class [`Process`](https://developer.apple.com/documentation/foundation/process),
which is provided exactly for that purpose.
I tried to used it in [Angle](https://www.angle.dev),
a side project that I'm developing with some friends,
and I'm struggling to use it properly.
These are the issues that I ran into:

- When the application that triggers the process gets killed,
  the process remains running.
  After digging around,
  I [found](https://github.com/Carthage/ReactiveTask/blob/master/Sources/Task.swift#L408) that there's a private method,
  `setStartsNewProcessGroup:` to tell the process whether it should terminate when the process that triggers it finishes. Why is that method private?
- It doesn't ensure that the standard output, error, and completion events are serialized in the same order.
  That may result in events coming in the wrong other,
  for example,
  a process that completes before the standard error message comes.
  Projects like [ShellOut](https://github.com/JohnSundell/ShellOut/blob/master/Sources/ShellOut.swift),
  which wrap `Process` to provide a more convenient API,
  [have to use](https://github.com/JohnSundell/ShellOut/blob/master/Sources/ShellOut.swift#L357) to ensure the events come in the right order.

The best implementation that I found so far to run tasks in the system is the one from the Swift Package Manager,
which interestingly,
doesn't use Process but its [own implementation](https://github.com/apple/swift-package-manager/blob/master/Sources/Basic/Process.swift) of it.
Unfortunately,
you can't/shouldn't copy-paste the class into your project.

It's unfortunate that those issues haven't been tackled.
The API is not very user-friendly and there's a lot of room for improvement to make it more straightforward to use.
If we look at Ruby's API, this is how we look like:

```language-ruby
require 'open3'

# Launch the process and capture the standard output in a variable.
developer_path = `xcode-select -p`

# Launch the process and forward the standard output and error.
system("xcodebuild", "build", "-project", "MyProject.xcodeproj") || abort

# Launch the process and capture the standard output and error
stdout_str, stderr_str, status = Open3.capture3("xcrun", "simctl", "list", "devices", "-j")

# Launch the process and call the block with the
Open3.popen3("xcodebuild", "build", "-project", "MyProject.xcodeproj") {|stdin, stdout, stderr, wait_thr|
  pid = wait_thr.pid
  exit_status = wait_thr.value
}
```

As you can see, we have several options from which we can choose depending on what we'd like to do with the process:

- Fire and forget.
- Fire and collect its output.
- Fire and notify me when the an event _(e.g. standard output data)_ has been sent.

The most reliable abstraction that I've found is [ReactiveTask](https://github.com/Carthage/ReactiveTask),
which is developed by the Carthage team and used by Carthage.
It provides a beautiful reactive API using [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift),
with which you can use Reactive operators and subscribe to the events that you are most interested in.
If there's a good use case for the usage of the reactive paradigm, this is to me one.
A process is an operation that starts,
sends a bunch of events,
and then completes.

Unfortunately 😕,
Angle has already [RxSwift](https://github.com/ReactiveX/RxSwift) as a dependency,
and I doubt it's a good idea to add another reactive library to the stack.
For that reason,
I started developing internally an implementation similar to ReactiveTask's,
but using RxSwift.
It's still WIP,
but if I'm happy with the result,
we might open source it.

I wonder if I'm the only one having this experience with the `Process` class,
or there are other developers that are struggling with the same issues.
If you are one of those,
I'm curious to know how you overcame them.

Have a wonderful week!
