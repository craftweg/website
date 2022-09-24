---
title: Providing mocks and testing data from your frameworks.
description: This post introduces an approach to share testing data and mocks from your frameworks to other frameworks that might need them for testing purposes.
categories: [xcodeproj, swift, xcode]
---

If you build your apps in a modular manner using Swift, you have probably been in the situation where a `ModuleX` defines some mocks or testing data for its tests in its tests target, but they cannot be shared to be used from other tests targets, playgrounds, example apps... _(essentially because they cannot import a tests target)_ With Objective-C it wasn't an issue at all because we could mock the interface of our dependencies at runtime with just one line of code. In Swift, the definition of mocks or data for testing requires some manual work _(unless you have some code generation in place)_ that we don't want to have to do it more than once. Listed below you can see some scenarios where you face this issue:

- Playground of `ModuleX` wants to access a `Track.testData()` defined in `ModuleXTests`.
- Example app of `ModuleX` wants to access a `Track.testData()` defined in `ModuleXTests`.
- Some tests from `ModuleY`, that depends on `ModuleX`, wants to access `MockClient` defined in `FrameworkXTests`.

> `Module` stands for `Library` or `Framework`, depending on your project setup.

We can overcome this issue by adding another module, that depends on `ModuleX` and exposes your module testing elements, `ModuleXTesting`. Since we would like to use the components in there from `Playgrounds` and example apps it's important that `ModuleXTesting` doesn't depend on the framework `XCTest`. In the snippet below you can see two examples, one of them shows how we use `ModuleXTesting` to define a mock for a protocol, and the other one how we extend an entity to provide testing data.

```language-swift
// ModuleX - MyProtocol.swift
public protocol MyProtocol {
  func sync() throws
}
// ModuleX - Entity.swift
public struct Entity {
    public let name: String
    public init(name: String) {
        self.name = name
    }
}

// ModuleXTesting - MockMyProtocol.swift
import ModuleX

class MockMyProtocol: MyProtocol {
    var syncCount: UInt = 0
    var syncStub: Error?
    func sync() {
        syncCount += 1
        if let syncStub = syncStub { throw syncStub }
    }
}
// ModuleXTesting - Entity+TestData.swift
import ModuleX

extension Entity {
    static func testData() -> Entity {
        return Entity(name: String.random)
    }
}
```

**Applying this little tip to your projects setup, you'll have more reusable testing components and you will save a lot of time when you need to write tests for your projects. The only thing you need to do, is defining your testing elements in a new module that playgrounds, example apps, and other modules have access to.**

> Note: Defining testing data or mocks in a new module applies only to the elements with **public** access. Those are the ones that are accessed from outside the framework tha contains them.

I hope you find the tip useful. If you have gone through this challenge before, I'd love to know how you overcame the issue in your projects.
