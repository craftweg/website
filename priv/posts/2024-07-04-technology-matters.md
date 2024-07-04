---
title: "The technology does matter"
description: "The decision of which technology to use in a project can have a significant impact. In this blog post I talk about the impact that Elixir is having in Tuist."
tags: ["Elixir"]
---

If you’ve been following me for some time, you might already know how much I advocate for Elixir. We even rewrote the Tuist server, which was previously written in Ruby.

Developers often say that the technology doesn’t matter, that if you prove a solution solves a problem, you can always rewrite it. But Tuist was already a validated idea, and we had just learned about how nicely Elixir can help achieve and scale so much with a simple stack and very few resources. It felt uncomfortable at first because we were not entirely familiar with the syntax, but more and more we are realizing it was such a great decision.

The most recent reaffirmation happened when we tried to add telemetry to the instance for on-premise organizations. Erlang provides a standard telemetry API that many packages use to report telemetry information, including packages like Phoenix (the web framework) and Ecto (an ORM to access databases). Without a single line of code, we had all that information available, and with just a few lines, we had it converted and served to Prometheus via a /metrics endpoint. Mind-blowing.

Phoenix LiveView was another reaffirmation that took us some time to appreciate as we familiarized ourselves with the technology. It’s common to see many companies bet on React as a way to have a top-notch experience for building UIs, without realizing the pile of complexity and abstractions that becomes their technical debt forever. With LiveView, you get the former without the latter. You barely need to write JavaScript and can declare UI that’s a representation of state entirely in Elixir.

So in our particular case, technology does matter, and it matters a lot. And that’s without even mentioning anything about the concurrent model and the many data races that don’t happen because of it, saving us time we’d otherwise waste on debugging.

If you are building a web service and can afford to learn a new technology, Elixir is a great resource to have in your toolbox.​​​​​​​​​​​​​​​​
