---
title: Extensions, dependency injection and frameworks
description: Learn how handy protocol extensions can be, when used in a frameworks architecture.
categories: [soundcloud, core, developer, ios, xcode, swift, extensionss]
---

I'd barely used extensions in my Swift code. When we started using Swift at SoundCloud I noticed a common parttern that most of people follow. They created extensions to organize the interface methods in different _"namespaces"_. As shown in the example below:

```language-swift
struct MyStruct {
  let name: String
}

extension MyStruct {
  func run() {
    print("\(name) runs")
  }
}
```

Extensions were used for pure style reasons, keeping the interface well organized. The interface could even be separated in different files follogin the `Objective-C` name style, `MyStruct+Runner.swift`.

With the transition into frameworks we found out a couple of use cases for extensions that might help you if you plan to transition your monolithic app into frameworks. I'll go through them and show you some exaples:

### Implicit dependency injection

When a framework provides a feature, it takes all the dependencies _(aka Services)_ from the app. Typically a constructor of a feature that is defined in a framework looks like this:

```language-swift
// Feature.framework
public class MyFeature {
  private let client: Client
  public init(client: Client) {
    self.client = client
  }
  public var service: Service { return MyFeatureService(client: self.client) }
}

```

Every time we instantiate the feature from the app, we'll end up writing the same initialization, passing the dependencies managed by the app:

```language-swift
// App
class Services {
  static var client: Client!
}

let feature = Feature(client: Services.client)
let anotherInstance = Feature(client: Services.client)
```

The more dependencies our feature has, the more code we'll duplicate, since by default, all the instances will take the same dependencies _(in rare cases we'll inject a different dependency into a feature)_. **Here is where extensions came very handy**. Since we want to prevent our developers from write the same initialization logic all the time, we can extend the class from the app, adding up a convenience initializer:

```language-swift
// App
extension Feature {
  convenience init() {
    self.init(client: Services.client)
  }
}
let feature = Feature()
let anotherInstance = Feature()
```

### Behaviour conformance

Another very useful use case for extensions in a frameworks setup is the conformance of application protocols from a framework model. In our transition into frameworks, we wanted to be able to reuse components from the app until we had time to migrate them into their own framework. To reuse these components _(e.g. a TableViewCell presenter)_, the component _(in the app)_ and the model _(in the framework)_ had to speak the same language, in other words, they had to know about a shared interface. Since these interfaces are something application specific, that the framework shouldn't be aware of, it didn't make sense to pull them out to the framework. It'll be clearer with an example:

1. The model `SearchEntity` is extracted into its own `Search.framework`.
2. From the app, the user can select a search result and open the player. The player requires the entity to conform a `PlayQueueEntity` protocol that is defined in the app.
3. Since the `Search.framework` could be used in a different app/target where the results are not opened in a player, conforming the `PlayQueueEntity` protocol from the `Search.framework` wouldn't make sense. Otherwise, the framework would know **where** it's going to be used.

Thanks to extensions we can solve this issue. By just conforming a protocol from the app, we provide our framework models with a behaviour that they didn't have originally:

```language-swift
// Search.framework
struct SearchEntity {
  let title: String
  let identifier: Sring
}

// App
extension SearchEntity: PlayQueueEntity {
  let artworkUrl: URL {
    return "xxxx/\(self.identifier)"
  }
}
```

By doing that the `Search.framework` can be very generic, and depending on where they are used, we extend the interfaces of its models.

---

#### These are two examples where extensions in Swift saved us a lof of time, duplicated and coupled coded. If you are using also entensions in your projects and you'd like to share your use cases do not hesitate to leave a comment below. I'm looking forward to hear how you use them.
