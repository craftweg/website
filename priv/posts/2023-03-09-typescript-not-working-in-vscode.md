---
title: Typescript not loading in Visual Studio Code
description: "I share the investigation into Visual Studio Code not loading Typescript and the solution I found - enabling the @builtin typescript extension."
tags: [typescript, visual studio code]
---

I spent much time today investigating why Visual Studio Code was not loading Typescript as usual.
I initially thought it was due to the Typescript compiler, `tsc`, not being present in the environment.
However, it turned out that Typescript is an internal extension of VSCode, and it was disabled for some reason.
If you ever come across the same issue,
all you have to do is to search the following extension in VSCode:


```language-bash
@builtin typescript
```

The `@builtin` is essential because the search filters out internal extensions by default.
Once you enable it, it'll start working again.
What caused it? I don't know, and I think it'll remain a mystery forever.
