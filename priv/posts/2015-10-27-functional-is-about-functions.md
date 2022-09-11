---
title: Functional is about functions (Swift)
description: 'Quick introduction to what Functional Programming in Swift is from the simple perspective of functions'
categories: [functional, functions, programming, reactive, swift]
---

Since Swift 2.0 was launched this term has become very popular. You attend conferences and this is usually the topic most of the people talk about. You see people even struggling for its use in their apps, really overwhelming for it. Why? It’s **something that can be easily done with Swift but it’s not something new** _(a lot of languages where already offering fully functional paradigms before)_

> Ey Pedro! Do you use functional in your apps? I wanna start using it, I’m watching a lot of talks and reading a couple of books. What do you think about? Should I use it?

## Maths

Functions is not anything new, back in the school we were told that a function is something that has some input arguments or variables and after some operations they return a value. From the Engineer perspective I was told that these was systems or black boxes that depend on an input stream of data and the output only depends on the input in each instance (no feedback cycle systems)

> f(x, y) = x + y

Notice that when we create a function we’re actually a scope of operations that doesn’t take data out of there, consequently the logic subset is constrained.
Thinking about it the concept isn’t complex at all, but… we were given more flexibility when we were told that we could save states under something called classes, voila! OOP

![Black box](/images/posts/black-box.png)

## Object oriented programming

We started grouping these functions into something called classes and assigning it a state which is created when and instance of this class is created. We still have functions but they seem to belong now to something and in languages like Objective-C _we cannot extract them from its scope (ask a Javascript developer about functions and contexts and you’ll get surprise about what they’re able to do)_. We sticked to Object Oriented principles and we set ourselves far from the basic function concept we saw above.
Object Oriented programming introduces a grade of flexibility and mutability working with objects and its functions. I’m sure most of you have coded something like this:

```swift
class ApiClient {

  // MARK: - Attributes

  var token: String?

  // MARK: - Init

  init(token: String) {
    self.token = token
  }

  // MARK: - Public

  func reset() {
    token = nil
    cancelRequests()
  }

  func execute(request: Request, completion: (Result<AnyObject, Error>) -> Void) {
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
    	let authRequest: Request = self.authenticatedRequest(request)
    	// Execute the request and get the response: let result
    	dispatch_async(dispatch_get_main_queue()) {
    	  completion(result)
    	}
    }
  }

  // MARK: - Private

  func authenticatedRequest(request: Request) -> Request {
    // Authenticating
  }
}
```

Let’s analyse the problems the implementation above presents. It’s a typical pattern on mobile apps and I’ve seen lots of workarounds facing different unexpected states that weren’t taken into account when it was implemented _(Note: This implementation can be more secure with Swift immutability concepts but I just copied how it would be using the same Objective-C format)_

- **State mutability:** We have a function that depends on an input value, Request _(great!)_ and also depend on two other variables, the token status and the time _(yes, we added asynchronous inside)_. We have three time states _(before asynchronous, in asynchronous block, and in main thread block)_ and two variable states _(valid / invalid)_. Grouping them we have two states for every time instance. Do we usually cover all of them when we implement a function like that? Probably **not**. If our execution reaches any of the states our app won’t know what to do or with treat it as an other existing contemplated case.

_Note: Adding threading logic inside functions adds an extra complexity because by the time these closures are executed the state might have changed._

- **External control:** In relation with the previous, this mutability is mostly controlled externally, we end up using a [Singleton](https://en.wikipedia.org/wiki/Singleton_pattern) pattern used all around the app. When we login we set the token, when we logout, we clean the token. This adds some uncertainty to our internal implementation. What happens if I try to execute the request and someone removed the token, for example resetting the client?

- **Retain cycles:** I talked about classes as scopes for functions that have a state. When we define functions that use the object state we’re indirectly retaining that scope which means, if that function is in memory, the object that contains the function will be as well. In the example above the GCD asynchronous closure is retaining self to generate authenticated request. Until this closure gets executed ApiEntity is going to be retained by two entities. If for any reason the closure was retained in memory, you’ll be retaining side objects.

> This is a common mistake for Objective-C, and most of them even don’t know what’s going on when they’re using reference objects inside blocks. Fortunately Swift solved it pretty well with types and retain level specification when closures are defined.

I’ve seem the problems above manifesting when the user logouts and you want to reset the state of your static/singleton API client. Things start to behave quite randomly.

## Functional

Let’s bring our function concept and make it simpler. Remember:

```swift
func execute(request: Request, session: Session, completion: (Result<AnyObject, Error>) -> Void) {
  let authenticatedRequest: (Request, Session) -> (Request) = { request in
    // Authenticates the request
  }
  let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
  dispatch_async(dispatch_get_global_queue(priority, 0)) {
    let authRequest: Request = authenticatedRequest(request, session)
    // Execute the request and get the response: let result
    dispatch_async(dispatch_get_main_queue()) {
    	 completion(result)
    }
  }
}
```

The example above have in essence two functions:

> g(request, session) = auth_request

> f(request, session, completion) = execute(g(request, session), completion)

We’re not accessing any external scope that retains the state, we’re instead passing all the data needed for this operation as input parameters and even using internal helper functions that in the same way take input parameters and returns data.

As you see functional is not something magic, it’s something that has been always with us, but that being Objective-C developers we forgot and now we have the opportunity to use it again with a better and readable syntax.

## Namespaces

### Where should I place my functions?

With OOP it’s seems easier to organise our code logic, we have models, controllers, presenters, factories, … Each of these entities as its own file and we group them by type or by feature inside the app. But what about organising functions? Where should I have them? You can do it everything as top level entities but you’ll end up messing up the top-level namespace with tons of functions.

**Building namespaces with Structs**
My suggestion about this is use structs to create namespaces in Swift grouping the functions that are related to the same business logic. For example if you have a set of functions related to network. Group them under Network as shown below:

```swift
struct Network {
  static func execute(request: Request, completion: (Result<AnyObject, Error>) -> Void)
  static func authenticate(username: String, password: String, completion Result<Session, Error> -> Void)
}
```

## Recommendations

If you’re thinking about using functional approaches in your Swift code but you don’t know how, or what to do don’t worry, it’s not something you have to necessarily do to get your app working, but it’s something definitively will help your code to be more reusable, robust, and stable. From my experience try to keep the following points in mind:

- **Think on problems as functions.** If problems are too big, think about them as small problems combined.
- **Swift offers immutability concepts:** Use let variables and avoid unpredictable states. Force yourself to check the state of the variables or copy the values instead of modifying existing values.
- **Prefer value to reference types:** When you’ve to model an entity, try to do it first using an struct. Use let attributes in that struct and in case you want a new struct with an attribute changed, create a new struct changing that attribute. Structs offer mutability but again, force yourself to don’t mutate states.
- **Be hybrid:** There’s no need to do it everything functional. When you have a bit of experience you’ll understand what your code asks you for.

And overall, don’t overwhelm with this concepts. You can also use Object Oriented Programming with Functional safety thanks to Swift immutability concept concepts.

## References

<iframe title="Video" width="560" height="315" src="https://www.youtube.com/embed/oFlJMkOJz70" frameborder="0" allowfullscreen></iframe>

- [Functions, a love story](https://www.youtube.com/watch?v=oFlJMkOJz70) by Josh Abernathy
- [Functional Reactive Programming in an Imperative World](https://realm.io/news/nacho-soto-functional-reactive-programming/) by Nacho Soto
- [Enemy of state](https://www.youtube.com/watch?v=7AqXBuJOJkY) by Justin Spahr-Summers

If you are interested also in the Reactive paradigm you can subscribe here https://leanpub.com/functionalreactiveprogrammingswift to a book I’m writing about Functional Reactive Programming with Swift.
