---
title: "Projects"
description: "Learn about the projects that Pedro Piñera got involved with."
---

This page contains projects that I am or was involved with.

## Under development

### [Gestalt](https://github.com/gestaltmd)

- **Source:** Closed
- **Programming languages:** Swift and Elixir

Inspired by graph-based knowledge based apps like [Obsidian]() or [Logseq](),
I embarked on building an app, [Gestalt](https://github.com/gestaltmd),
with a similar foundation at its core,
but with an interface designed to embrace Apple platforms and their [Human Interface Guidelines](https://github.com/gestaltmd).
One of the long-term plans is to build an ecosystem of extensions for third-party developers to extend the app.

## Low maintenance

### [typed-file-system-path](https://github.com/pepicrft/typed-file-system-path)

- **Source:** Open under the MIT license
- **Programming language:** Typescript

`typed-file-system-path` takes inspiration from [Path.swift](https://github.com/apple/swift-tools-support-core/blob/main/Sources/TSCBasic/Path.swift) in [swift-tools-support-core](https://github.com/apple/swift-tools-support-core/blob/main/Sources/TSCBasic/Path.swift) and provides typed primitives to work with file-system paths instead of strings. Even though it might seem unnecessary because it wraps a the `string` representing the path, it allows designing APIs that make it explicit if they work with absolute or relative paths and logic that doesn't have to make any assumptions.

## No longer maintainer of

### [Tuist](https://github.com/tuist/tuist)

- **Source:** Open under the MIT license
- **Programming language:** Swift

I created Tuist to scratch an itch during my time at [SoundCloud](https://soundcloud.com).
Scaling up Xcode projects was only an option for companies that could afford to invest in an alternative build system,
so I decided to democratize a solution for that problem.
Tuist is a CLI tool that leverages Xcode project generation to bring consistency to projects and provide productivity-oriented tools such as local and remote caching.
