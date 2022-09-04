---
title: Consistent vs convenient
excerpt: I analyze in this post why some decisions that we make in our projects might turn into bad viruses that spread all over the code base.
categories: [consistency, convenience, rxswift, swift, xcode, reactive, realm]
---

Have you ever used programming paradigms like [functional](https://en.wikipedia.org/wiki/Functional_programming) or [reactive programming](https://en.wikipedia.org/wiki/Functional_reactive_programming)? Have you tried the revolutionary approach to model how the state is contained and flows in your app, [Redux](http://redux.js.org/)? I find it great that companies and open source organizations try to solve issues that we developers, have to face on a daily basis by introducing new concepts in the industry. We'll see more of those coming, and what it's cool nowadays won't be in a matter of months/years. Do you think reactive programming is the coolest thing ever? Let's see in a few years if it was the coolest thing ever, or there was still space for even cooler alternatives.

If there's something I've learned in my short career as a software engineer is that there's no perfect paradigm, pattern, or architecture and that it all depends on our problems or particular needs. Something that is convenient for other projects and teams might not be convenient for us. _Have you worked on a code base where someone introduced a new concept/library, like a Reactive programming library, and you ended up very concerned when that thing spread all over the codebase?_ There are libraries that we introduce and that are isolated, we can easily abstract them with an interface, but there are others that as soon as we use them, they spread very quickly across the codebase. They are like viruses, and as soon as you open them the door, they have everything they need to spread around.

> I have nothing against the paradigms mentioned above. I think each paradigm that changes the way we code should be used consciously, and we should regularly evaluate if the choice we made works out for us and that is not becoming a burden that we need to carry on.

I wondered why those elements end up behaving like viruses. There must be something, in the team or the project, that helps them spread that fast. I think the reason why that happens is that it brings up a dilemma to developers when they need to work with code that already includes the virus. **They need to decide between choosing the consistent solution, or the convenient one**, and most of the times we lean towards the consistent solution. You'll understand this better with a couple of examples.

---

##### Example 1 - Reactive programming

Let's say there's a component A, whose interface is mostly implemented with reactive observables _(even if methods are just simple getters that return values synchronously)_. You need to extend that interface to just return a property whose value you need from outside. _Will you expose an observable, or just a getter?_ For your particular use-case it may make more sense going with just a simple getter since you don't need any reactive magic like scheduling in threads or doing a binding. But you'll most likely be influenced by the existing API and do it with observables, since you want to be consistent with the code that is already there. Little by little, what was an isolated interface, is powerful enough to force the usage of observables far beyond the closest element.

##### Example 2 - Redux store

Redux was introduced in the codebase, and we already moved a lot of states to the store. The session of the user, the state of the navigation, the settings, the search results that will be presented in the search view. We need to work on a new view whose simple state we need to persist in memory. Again, it might be more convenient to do it in a view model next to the view, but since we already have some views that do it in Redux, we do the same, and we add some complexity to the store state.

---

These are two examples to illustrate what I'm talking about, but you can think of any other element that you can introduce in a codebase: _VIPER, declarative programming, MVVM, Realm_. When we developers, have to choose between consistency and convenience we usually lean toward consistency. By doing that we push new element beyond its scope and we turn it into a burden that the team has to carry on. Usually, when we realize that the burden is a heavy burden, it's too late to give steps back.

I'm a bit skeptical when it comes to introducing such elements in codebases where more people are working on. This involves being able to control the hype those new technologies, libraries, paradigms come with. In my experience, the closest you are to the language and the system frameworks, the more familiar your team is with the codebase. They feel more confident when they need to make changes when they need to propose improvements, and they don't have to go through any cumbersome dilemma that the codebase exposes them to. If you are not sure whether a new thing could potentially be a _"virus"_ I recommend you to talk to other teams that have experience using it. Talk to as many teams as possible before making the decision because, because you won't find such information in documentation websites, READMEs, or even tech-talks.
