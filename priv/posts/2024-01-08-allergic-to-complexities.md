---
title: "I'm allergic to complexities"
description: "I like understanding complexities to simplify them. In this post, I share some examples of complexities that I'm intentionally avoiding because they are complex and therefore not fun."
tags: ["Complexities", "Fun"]
---

Call me weird, but I'm allergic to complexities.
There are software crafters who enjoy understanding and working with complexities in software.
**I only enjoy understanding them to conceptually compress** them to build simpler experiences that are fun to work with.
At the end of the day,
it's not fun if you want to deliver value to people,
and your tools, frameworks, and languages slap your face with complexities.
Here are some examples of unnecessary complexities that I'm intentionally avoiding because they are not fun:

- **It's not fun** to replace Xcode projects and build system with new building (more advanced) building blocks that break with every Xcode release. I look at you [Bazel](https://bazel.build/).
- **It's not fun** when your shiny JavaScript-powered project fails to build after you do a minor version dependency update due to a cryptic error message that comes from ten layers of dependencies deep.
- **It's not fun** when you can't debug your JavaScript code because it's gone through a series of transformations and optimizations that make it impossible to understand. And it's even less fun when you have to set up a system for your error-tracking solution to be able to help you with source maps.
- **It's not fun** when you can't debug your issues because of the layers of abstractions and proprietary tech your project is building upon. I look at NextJS, Vercel, proprietary serverless runtimes, and Xcode.
- **It's not fun** when you have to read books and take courses to understand the architecture that software introduced in a code base because they saw everyone in the community talking about it.
- **It's not fun** when the programming language that you use gets unnecessarily complex because it's trying to be everything for everyone. I look at you, Swift.
- **It's not fun** when you have to build your standard library because the language that you use, JavaScript, lacks it. And it's even less fun when the people who built the packages required for that are often jumping from one project to another, leaving you with a broken project.
- **It's not fun** when there are thousands of ways to do the same thing, and you have to spend time learning them to understand the code that you are reading.
- **It's not fun** when the tooling that you use tries to be smart about how you want to use it and ends up being a black box that you can't understand.
- **It's not fun** when your toolchain and code editor don't integrate well and you have to spend time configuring it to make it work.

I believe the ecosystems with the healthiest communities are the ones that can spot the complexities and work together to simplify them. [Rails](https://rubyonrails.org/) is an excellent example of that. [Erlang](https://www.erlang.org/) and [Elixir](https://elixir-lang.org/) have also done a great job at that. That's the reason why I connect with them and enjoy working with them. Because I can stay focused on the problem that I'm trying to solve and not on the tools that I'm using to solve it. And more importantly, I do it with the relief of knowing that they haven't abstracted a huge pile of complexity like JavaScript is obsessed with doing. Because knowing that makes me uncomfortable. That pile of complexity is going to bite me at some point, and I'm going to have to deal with it. Not for me.
