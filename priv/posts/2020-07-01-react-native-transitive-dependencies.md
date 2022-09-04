---
title: Transitive React Native dependencies
categories: ['react-native', 'ios', 'android', 'shopify']
---

Today I learned about how dependencies are organized by NPM and Yarn. Let's say we have the following scenario of dependencies:

- `A -> B -> C (3.2.1)`
- `A -> C (1.2.3)`

Javascript dependency managers will structure the dependencies following the structure below:

```
node_modules/
  a/
  b/
    node_modules/
      c/ #3.2.1
  c/ # 1.2.3
```

With this scenario package managers like [Bundler](https://bundler.io/) or [Swift Package Manager](https://swift.org/package-manager/) would error, but NPM and Yarn do not. Javascript bundlers like Webpack and Metro might be able to resolve those and generate a valid Javascript code that runs successfully _(perhaps with a larger size than expected)_.

The problem comes when the `C` dependency is a React Native dependency that includes native code. The [React Native CLI](https://github.com/react-native-community/cli) uses CocoaPods and Gradle to link the native code that is distributed as part of the NPM package. In the above scenario, we can't link both versions of the `C` dependency so the CLI decides to link only the direct dependencies.

That means that adding `B` as a dependency of my React Native app also means that I have to add `C`. Otherwise, the app will crash when it tries to access the non-existing native code from `C`.

I find it very weird that the app needs to know about transitive dependencies as well, but I can't think of a better way for the CLI to solve it. I guess one thing that it could do is to extend its logic to lookup transitive dependencies as well, detect conflicts, and fail if it finds any.

This is just me and another misterious quirk of React Native development.
