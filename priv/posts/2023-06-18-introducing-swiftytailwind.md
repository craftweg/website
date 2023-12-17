---
title: Integrating Tailwind into your Swift projects
description: "Tailwind: A game-changer for web styling, with seamless integration into Swift server projects using SwiftyTailwind."
tags: [Swift, Tailwind]
---

In recent years, [Tailwind](https://tailwindcss.com) has gained popularity as a web styling tool. Frameworks such as [Ruby on Rails](https://rubyonrails.org) and [Phoenix](https://www.phoenixframework.org) default to using Tailwind for new projects. If you're unfamiliar with Tailwind, it provides **a set of well-defined and configurable utility classes that ensure consistent styling and allow for atomicity of markup and style**. While JavaScript-based UI solutions like [React](https://react.dev) or [Vue](https://vuejs.org) already offer this functionality, they rely on the JavaScript ecosystem of tools and packages. Tailwind, on the other hand, brings these benefits to other ecosystems without introducing additional dependencies. It accomplishes this through a simple CLI that runs during build time and outputs CSS, removing any unused classes from the project. Essentially, using Tailwind doesn't require developers to install new system dependencies like [NodeJS](https://nodejs.org/en), making it easier to contribute to a project.

When I returned to working with [Swift](https://www.swift.org), I noticed that the Swift ecosystem lacked an easy way to integrate Tailwind into Swift on the Server projects, such as those based on [Vapor](https://vapor.codes) or [Publish](https://github.com/JohnSundell/Publish). To address this, I took it upon myself to create a new Swift package called [**SwiftyTailwind**](https://github.com/pepicrft/swiftytailwind). It allows for the lazy downloading and execution of the Tailwind CLI using system processes. Below, you'll find an example of how to use `SwiftyTailwind`:

```language-swift
let tailwind = SwiftyTailwind()
try await tailwind.run(input: .init(validating: "/app/app.css"), output: .init(validating: "/app/build/app.css"))
```

## Integrating it with [Publish](https://github.com/JohnSundell/Publish)

Integrating SwiftyTailwind is a breeze with the use of [plugins](https://github.com/JohnSundell/Publish#building-plugins). Simply instantiate and pass a plugin, and Publish will execute the code within the closure, generating the CSS file at `./Output/output.css`. Remember to include the necessary code in the `<head>` tag of your website to load these styles.

```language-swift
try Site().publish(withTheme: .tailwind, plugins: [
    .init(name: "Tailwind", installer: { context in
        let rootDirectory = try! AbsolutePath(validating: try context.folder(at: "/").path)
        try await tailwind.run(input: rootDirectory.appending(components: ["Style", "input.css"]),
                               output: rootDirectory.appending(components: ["Output", "output.css"]))
    })
])
```

## Integrating it with [Vapor](https://vapor.codes)

Integrating SwiftyTailwind with a Vapor project is a seamless experience. To begin, you need to configure the app to serve static assets located in the default `Public` directory by Vapor. Here's an example of the code:

```language-swift
app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
```

Next, create an instance of `SwiftyTailwind` and invoke it by providing the file `Resources/Styles/app.css` as input. Additionally, set the options `watch` and `content` to point to `Resources/Views/**/*.leaf`. Take a look at the code example below:

```language-swift
// Tailwind
let publicDirectory = try AbsolutePath(validating: app.directory.publicDirectory)
let inputCSSPath = try AbsolutePath(validating: app.directory.resourcesDirectory).appending(.init("Styles/app.css"))
let outputCSSPath = publicDirectory.appending(component: "app.css")
async let runTailwind: () = try tailwind.run(input: inputCSSPath, output: outputCSSPath, options: .watch, .content("Resources/Views/**/*"))
async let runApp: () = try await app.runFromAsyncMainEntrypoint()

_ = await [try runTailwind, try runApp]
```

Finally, update the `<head>` section of your views to load the generated app.css file from the Public directory. Here's an example:

```language-html
<link rel="stylesheet" href="/app.css">
```

And that's it! `SwiftyTailwind` will monitor file changes in your `Resources/Views` directory and automatically regenerate the CSS output.

You can check out the [Examples](https://github.com/pepicrft/SwiftyTailwind/tree/main/Examples) directory in the project repository.


## Contributing to Swift on the Server

When compared to programming languages that have a more established presence in web development, Swift's ecosystem is still in its early stages. However, I am determined to contribute to changing that by building and sharing utilities with the community. Tailwind was my initial contribution, but I also have plans to introduce [ESBuild](https://esbuild.github.io) and [Orogene](https://orogene.dev) to Swift. These additions will enable a more advanced build pipeline in Vapor and facilitate fetching Node dependencies without relying on the NodeJS runtime. Exciting developments are on the horizon, so stay tuned for more updates!
