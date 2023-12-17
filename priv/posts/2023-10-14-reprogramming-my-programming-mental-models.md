---
title: "Recalibrating Mental Models in Elixir Programming"
description: "Navigating through Elixir requires a rethinking of traditional OOP mental models, inviting a shift towards domain-centric thinking. Embracing Elixir's functional paradigm offers intriguing challenges and a rewarding, fresh perspective on problem-solving in programming."
tags: ['Elixir', 'Erlang', 'Functional Programming', 'Mental Models']
---

As I delve deeper into programming with Elixir, I am prompted to reconsider the mental models formulated over years of experience. Initially, when contemplating a problem space and a potential solution, my mind spontaneously navigates towards an [Object-Oriented Programming (OOP)](https://en.wikipedia.org/wiki/Object-oriented_programming) world, constructing a picture involving repositories, services, and presenters to facilitate various layers of application, especially testing. However, this model doesn’t quite fit seamlessly into [Elixir](https://elixir-lang.org/)-a functional language where everything condenses down to functions and modules simply act as namespaces to encapsulate them, occasionally embodying semantics similar to interfaces in OOP.

While my mental models are instinctively oriented towards objects and classes, envisioning an ideal—or even a proximate—solution in Elixir poses a challenge. A strategy I’ve adopted to navigate this is to **think in terms of domains instead of the traditional OOP mental model**. Consider the following Elixir functions that interface with a `%Plug.Conn{}` to manage session information:

```language-elixir
Auth.set_authenticated_user(conn, user)
Auth.get_authenticated_user(conn)
Auth.user_authenticated?(conn)
Auth.load_authenticated_user_from_session(conn)
```

This code, expressive and reflective of real-world modeling, underscores one of Erlang creator [Joe Armstrong](https://en.wikipedia.org/wiki/Joe_Armstrong_(programmer))’s points from his [renowned paper](https://erlang.org/download/armstrong_thesis_2003.pdf): the proximate modeling of problems and solutions in Erlang, analogous to real-world scenarios, enhances the maintainability and reasoning of the software. **Adopting this mindset is pivotal and necessitates the relinquishment of numerous concepts ingrained from OOP.**

Moreover, abandoning these concepts also means recalibrating practices built upon them, such as testing. Traditional architectural solutions enable isolated testing. For example, testing business logic without the concern of data origin, since we might mock a repository. However, in the functional realm of Elixir, where every entity is a function or a function combination, the narrative is distinctly varied.

Consider a hypothetical scenario: testing a function combination that symbolizes a slice of business logic, which is more user-centric as opposed to stating, "when I call this function with these arguments, I expect this query to be executed to the database". My journey through various codebases has occasionally led me to allow inertia to dictate, perpetuating historical practices. Yet, the pertinent question that perpetually surfaces as I script in Elixir is: *Do these tests make sense?* *Is it logical to test whether storing the authenticated user appears in a specific key inside the connection assigns?* Or, *would it be more valuable to test, for instance, whether a specific request, requiring user authentication, fails with a designated error if the user is not authenticated?*

In conclusion, as I savor my Saturday morning coffee ☕️, Elixir continues to captivate me. The challenge of mentally rewiring to adapt to its distinctive paradigms is not only intriguing but also refreshingly fun.
