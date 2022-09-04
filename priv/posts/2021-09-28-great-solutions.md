---
title: 'Great solutions for the wrong problems'
categories: ['development', 'problem-solving', 'software']
---

As you might know,
I’m a curious person.
That leads me to reading about challenges tech companies run into and the solutions that they come up with,
and connecting them with similar problems with the aim of forming mental models.

Why [React](https://reactjs.org/)? What’s the role of [GraphQL](https://graphql.org/)? Why was [Rust](https://www.rust-lang.org/) created? Where does it make sense to use it? How does it compare to [Go](https://golang.org/)? What are the drawbacks of building a CLI with interpreted languages? How does [SvelteJS](https://svelte.dev/) and [SolidJS](https://www.solidjs.com/) compare to [VueJS](https://vuejs.org/) and ReactJS? What is React Server Components trying to solve? Why does ES modules remove the need for intricate Javascript tooling? Why is "deleting node_modules" a thing in the Javascript ecosystem? Why is the trend in the Javascript community to build tooling in compiled languages?

Problems that are constantly arising push current solutions beyond their limits, and in less-opinionated environments like Javascript’s, new creative solutions emerge like flowers in a field.
The result of that is a rich pool of solutions to choose from.
The **caveat** is that solutions get so much attention that the problems they originally set out to solve remain background or get disregarded in the decision-making process. On top of that they present even more problems that get solved with more layers.
In practice, this means simple projects with convoluted tech stacks that aim to solve problems they don’t really have.

Take React. It solved Facebook’s problems that are now becoming other companies’ problems too. GraphQL is a similar story and it’s now becoming the standard for the request-response model in web applications, even if there’s a single client consuming the API. Just today I came across a product that combines GraphQL with CDN to provide caching to GraphQL APIs. What will follow? Another product that solves synchronization issues between the source API and the caching layer.

We, developers, are usually solutions-oriented, and that makes the matter worse. We get tasked with solving something, and put too much focus on the solution. As a consequence, we end up proposing technologies and languages we are familiar with or that most people are talking about these days. This is very challenging for me. I need to make an effort to understand a problem well and consider multiple solutions before deciding for one. I have to tell my biases to shut up.

As the name of the post says, _we often end up with great solutions for the wrong problems._

**What should we do then?** I think we have to embrace innovation and diversity of solutions. It’s something positive for the industry. However, I think we should **mentor software developers** to be more problem-oriented. They should be able to gain understanding of the problem that they have at hand, evaluate several solutions and understand the trade-offs of each of them, make the best unbiased decision, and document the rational behind the decision for future context and re-evaluation.

Moreover, I think it’d be great if open-source projects include in their READMEs the problem/s they are optimizing for, and some examples of projects for which the solution would and wouldn’t be suitable.

Mastering this is, in my opinion, what sets the difference between a junior and a senior developer. Towards the staff role, developers should be able to find problems to solve in domains with some uncertainty.

It’s not easy. As I mentioned earlier, I have to make an effort every time. However, once the decision is made and the solution executed, it feels extremely rewarding and puts you in the mood of hunting new problems.
