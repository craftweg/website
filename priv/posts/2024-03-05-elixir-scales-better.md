---
title: "Elixir scales better"
description: "In this blog post, I talk about the scaling challenges we faced with Rails, and why we decided to transition to Elixir."
tags: ["Elixir", "Rails"]
---

[Tuist](https://tuist.io) is powered by [Ruby on Rails](https://rubyonrails.org/).
When making the decision, we decided on Rails because of its maturity, productivity, and the ecosystem around it.
We could move fast with it and convert some early customers.
However,
we hit some scaling challenges earlier than we anticipated,
and they made us question whether Rails was the right choice for us in the long term.
Let me give you some context on the service first.

The service has a very basic UI, which might change soon,
and a REST API that the CLI interacts with.
Most of the interaction with the service is done through the API because teams interact with it through the CLI.
By design,
we aimed at keeping an S3-compliant storage,
provided by [Cloudflare](https://www.cloudflare.com/) in this case,
as the source of truth for whether a given binary exists or not.
We didn't think it made sense to replicate that state in the database,
and add additional synchronization logic to keep both in sync.
That meant that all the requests would spend around 90% of their time waiting for IO operations to complete.
To our surprise,
we started seeing slow requests that timed out, and some which came back with 500s.
What was going on?
I started searching, and I came across [this issue](https://github.com/rails/rails/issues/50450) by @dhh.
And there was a piece of his comment that grabbed my attention:

> It's not a good default for apps with quick SQL queries and 3rd party calls running via jobs, **which is the recommended way to make Rails applications.**

3rd party calls are what we were doing (against Cloudflare's APIs),
so he was clearly referring to our use case, but I couldn't wrap my head around the idea of having to use jobs for that.
I mean,
I don't mind adding jobs,
but I'm a huge advocate of simple solutions,
and that didn't feel simple.
So I continued digging into how [Puma](https://github.com/puma/puma) works,
how they use [Ruby threads](https://ruby-doc.org/core-2.5.1/Thread.html) and system processes,
and how you have to figure out the sweet-spot configuration for your service to have the latency and throughput intended.
I learned that the issue that we were facing with Tuist was related to having a low number of threads, 
which resulted in requests having to wait a long time in the Puma queue,
and eventually timing out or being rejected.
I added some additional cores to the production machines,
did some tweaking of processes and threads,
and got it to a point where it was acceptable.
But still,
it didn't feel right.
What are we going to do with our on-premise customers?
Are we going to provide them with guidelines to figure out the right value for the production machines?
Are we going to point them to lengthy guidelines around Rails and performance?
It all felt wrong. Sorry Rails.
You scale, but the cost of it is barely talked about.

All we want is a solution that's able to use all the resources available in the machine,
without much configuration or tweaking to find the ideal values,
and a runtime that's able to handle IO-bound operations efficiently.
At the same time,
we want to keep the productivity that Rails provides.
The good news is that such technology exists,
and I've already talked many times about it in the past.
It's [Elixir](https://elixir-lang.org/).
It feels like the right tool for the job.
I don't have to use jobs because a runtime's global lock is not going to be optimal for the nature of my app.
We can scale the service by throwing more cores at the machine.
Look at Discord, Pinterest, and Supabase, which are all powered by Elixir.
Development is very scalable too. You can use also all the cores available in the machine,
and because it's a functional language,
you do so with minimal risk of introducing flakiness.

So as you might have guessed at this point,
we'll transition to Elixir.
We won't do a full rewrite.
Rather, we'll place a proxy in front of the Rails service,
and run the Elixir service in parallel.
We'll route the traffic to the Elixir service as we migrate endpoints.
It's going to be awesome when we give our on-premise customers a Docker image that can use all the resources available without any configuration required on their end.
Or even better, gear our energies toward building products instead of figuring out how to scale our API.

**Rails scales, but Elixir scales better.**

PS: Despite our excitement for Swift on the Server, we decided to go with Elixir because of the productivity and the ecosystem around it. Erlang's hot-reloading of modules is an unbeatable productivity tool.
