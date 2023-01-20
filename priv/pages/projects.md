---
title: "Projects"
description: "Learn about the projects that Pedro Piñera got involved with."
---

This page contains projects that I am or was involved with.

## Under development

### [Gesttalt](https://github.com/gesttalt)

- **Source:** Open
- **Programming languages:** Elixir

Gesttalt is an open-source localization hub. The goal is to empower organizations and translators to build great localized experiences.

### [Chimera](https://github.com/chimerarun)

- **Source:** Open
- **Programming languages:** Rust, Swift, Typescript, Elixir

Chimera is a knowledge base tool to work with [zettelkt](https://github.com/zettelkt) files.


### [zettelkt](https://github.com/zettelkt)

- **Source:** Open
- **Programming languages:** Rust, Swift, Typescript

The [Roam Research](https://roamresearch.com/) project led to a proliferation of tools to build graphs of interconnected thoughts (e.g., [Logseq](https://logseq.com/), [Obsidian](https://obsidian.md/)) that solved the same problem without aligning on a format that would make “second brains” portable across tools. zettelkt aims to be that missing standard to achieve portability and the narrow waist for more interfaces for the second brain to flourish. The standard is named after the German sociologist Niklas Luhmann's[ knowledge management method](https://en.wikipedia.org/wiki/Zettelkasten).


### [Catalysis](https://github.com/catalysisdev)

- **Source:** Open
- **Programming languages:** Typescript

Catalysis is a modern opinionated and batteries-included [NodeJS](https://nodejs.org/en/) framework for building digital experiences with web technologies. It's designed to spark joy through convenient abstractions and workflows that [conceptually compress](https://m.signalvnoise.com/conceptual-compression-means-beginners-dont-need-to-know-sql-hallelujah/) the intricacies of building apps.


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
