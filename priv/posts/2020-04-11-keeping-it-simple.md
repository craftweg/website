---
title: Keeping it simple
categories: ['product', 'tooling', 'development principles']
---

If there's something that characterizes my approach to problem solving these days is **simplicity.**
Working on acquiring a product mind-set in the last 2 years has helped me realize how obsessed we,
developers,
are with configurability.
_Why is that?_ I think it has to do with trying to model the world as it is with software ―
and the world is complex.
We want to have flags, arguments, and options to model all possible scenarios we might encounter;
we want every single detail of our software to be configurable.
I've seen developers anticipating to those scenarios too:
_what if teams want to do X_, _what if we want this feature to behave differently_,...

This is a constant when working on [Tuist](https://tuist.io).
In this case,
developers often ask for features that mimic **Xcode's complexity**,
and that's precisely the reason why we are providing Tuist as an abstraction:
_to conceptually compress Xcode's complexities and initriciacies._
My first thought is often:
_if we add X, Y, and Z, which is what Xcode provides, we'll end up with the same thing, but in a different language._
Teams might need that,
and that's fine,
but unfortunately,
that's not what Tuist is amining for.
We aim to **challenge projects' complexity and nudge them to be simpler.**
The adoption of Tuist might require simplification on the user side,
but believe me,
both your team and Xcode will be so thankful for that.

Something that works for me to challenge developers' requests is asking them **whys** until I reach their core motivation or root problem.
They typically come with a solution in mind, without really understanding what they need that for ―
they haven't spent time going through those whys themselves.

I'm aware that this mind-set when developing a product like Tuist might suppose not pleasing everyone ―
but it's fine because that's not our goal.
The goal is to remain small and close to our gist of keeping things simple.
That's what makes users of Tuist love it,
and most importantly,
enjoy scaling up their projects.

If you are a developer working close to product,
whether a product is a tool for developers, or a user-facing app,
I'd encurage you to work on having this mindset of understanding the motivations behind features,
and striving to keep them simple.
