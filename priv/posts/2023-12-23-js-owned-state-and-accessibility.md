---
title: "JavaScript-owned state and accessibility"
description: "WAI-ARIA attributes are a great layer to persist application state and make the website accessible. However, the convenience of JavaScript APIs to store state makes them store all the state in JavaScript, making the websites less accessible."
tags: ['WAI-ARIA', 'Accessibility', 'JavaScript']
---

I've been following the [Enduring CSS](https://ecss.benfrain.com/) for my projects for a while,
including this blog,
and a principle that stuck with me is the idea of [WAI-ARIA](https://www.w3.org/TR/wai-aria/) attributes to persist state.
I never thought about it until I read the methodology–
if we have HTML markup that represents semantics,
and a set of attributes to represent the state making your website accessible,
*why would I store the state elsewhere?*

This realization made me think about JavaScript and JavaScript web frameworks and their APIs to store state:

```language-js
// React
const [state, setState] = useState(false);

// Vue
const state = ref(0);

// Svelte
const state = writable();

// Solid
const [state, setState] = createSignal(0);
```

They all have a common pattern: **they are convenient**.
But the convenience has a cost–
it's so convenient that developers naturally hoist that's representable by ARIA attributes to JavaScript.
Instead of embracing the platform,
they get distracted by the convenience of the layer in which they are working,
and end up with a solution that's not as accessible as it could be.
It's not the framework's fault.
Not all states are representable by ARIA attributes or should be represented by them.
However,
I think it'd be great to include a reminder in the documentation of these frameworks to consider ARIA attributes before reaching out to the framework's APIs.
Like Enduring CSS does:

> "While the specification is aimed at helping communicate state and properties to users with disability (via assistive technology) it serves the need of a web application project architecture beautifully. Adopting this approach results in what is (perhaps cringingly) referred to as a 'Win Win' situation. We get to improve the accessibility of our web application, while also gaining a clearly defined, well considered lexicon for communicating the states we need in our application logic." [Enduring CSS - Chapter 6](https://ecss.benfrain.com/chapter6.html)

I love how they put it. **It's a win-win situation.**
We should not forget that the web is a powerful platform and that despite how natural it is to get distracted by the convenience of the layer in which we are working,
we are ultimately building for users, some of whom might appreciate that we are building directly on top of the platform.
