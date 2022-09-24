---
title: Typing file-system paths in Typescript
description: Learn about an NPM package that we published recently, typed-file-system-path, that adds primitives to work with file-system paths more safely using types.
categories: [cli, typescript, node, npm]
---

**Have you ever noticed how common it is in standard libraries to treat file system paths as strings?** In fact, Node’s [path](https://nodejs.org/api/path.html) module exports a handful of convenient functions, all of which expect string arguments. There are a few caveats in following that approach. The first and more prominent one is that developers naturally operate with paths as if they were strings, which often leads to bugs. For example, concatenating a string that represents a relative path (e.g., `index.ts`) to an absolute one (e.g., `/project/src`) leads to `/project/srcindex.ts`, which is wrong. These issues don’t happen if we use the functions provided by the `node:path` module, but once again, they are strings; why not treat them as such?

The second issue is that APIs with paths as arguments or output values are not explicit enough about the type of paths. This is somewhat solvable with documentation, but wouldn’t it be better if the compiler, Typescript, is the one guiding you to use the APIs correctly. For example, making the compilation fail if you pass a relative path when the API expects an absolute one.

And last but not least, maintaining a piece of business logic that has paths as strings put the developer in the position of having to make assumptions, and that’s always a terrible idea. *Is this path here absolute? Or maybe it’s relative? If it’s relative, is it relative to the working directory? Or maybe the project’s directory?* You don’t want project contributors to be asking themselves those questions. Instead, you want paths to be made early in your system and pass them around, making it clear that they are operating with an absolute path and not a string prone to misusage.

To solve the above issues, I open-sourced a tiny NPM package, [typed-file-system-path](https://www.npmjs.com/package/typed-file-system-path), which provides primitives for modeling absolute and relative paths and operating with them. The API is simple. You have utilities to initialize a relative or an absolute path. They’ll through if you are initializing them with an invalid path. The primitives provide convenient functions to prevent having to import utilities from the `node:path` module:

```language-ts
import { relativePath, absolutePath } from "typed-file-system-path"

// Initialize an absolute path
// @throws InvalidAbsolutePathError if the path is not absolute.
const dirAbsolutePath = absolutePath("/path/to/dir")

// Initialize a relative path
// @throws InvalidRelativePathError if the path is not relative.
const fileRelativePath = relativePath("./tsconfig.json")
```

The inspiration for this project comes from [Path.swift](https://github.com/apple/swift-tools-support-core/blob/main/Sources/TSCBasic/Path.swift), a primitive that Apple built as part of their [swift-tools-support-core](https://github.com/apple/swift-tools-support-core/blob/main/Sources/TSCBasic/Path.swift) and that I used extensively in [Tuist](https://github.com/craftweg/typed-file-system-path).
Up next is adding more convenient functions,
and update [Gestalt](https://github.com/gestaltjs/gestalt) to use the `AbsolutePath` and `RelativePath` types.
