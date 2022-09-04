---
title: Working on a new website for Tuist
excerpt: An update on what I'm up to these days with Tuist. In particular, I talk about the new website that I'm designing and implementing for the project.
categories: [tuist, product, open source, development]
---

Over the past few weeks I've been working on a new website for Tuist's.
This is the third iteration of the website and I'm never tired of going through them;
it takes learning some design tricks and some inspiration from other websites to see the current website as old and not representative.

For someone like me with little experience in creating products,
a task like this one isn't straightforward, yet challenging.
I have to think about the message that I'd like to convey,
the content that I'd like to present,
the combination of fonts, colors, and sizes that represent best the tool.
The website and the GitHub repository is most of the times what users first see when they come across your projects.
If its style and content is not appealing,
developers will probably not give the project a try.

What most developers do is using markdown files in their repositories.
I've seen many creative and well organized markdown files that convey the message of the project well.
In case of Tuist,
we started with something like that but at some point,
we realized markdown was not enough.
I can describe in paragraphs how life-changing Tuist can be projects,
but without a more visual and dynamic explanation,
users won't probably get the idea.
That's where having your own website comes handy.
You are in full control,
not only of the message,
but of the way the message is represented.
You can summarize a bunch of paragraphs in a beautiful animation that lets developers eager to try the tool.

Anyway,
that's where I'm mostly spending my time these days.
For this new iteration I used [Figma](https://figma.com) for the design.
It really feels like GitHub but for design.
I can define my shared components and colors that I can reuse from all the designs,
share them with other people and get their input through comments,
and all of that in the cloud.
If all of that was enough,
I just came across [this new feature](https://www.figma.com/blog/announcing-auto-layout/) that they just launched 🤯.
In case you are interested in giving feedback on the design, [here](https://www.figma.com/file/NjaC1IooavnI82mxRY6T6C/Website-2.0?node-id=1%3A4) is the link.

Moreover,
we are moving away from [Docz](https://www.docz.site/) for generating the documentation.
We'll merge the documentation into the website built with [Gatsby](https://www.gatsbyjs.org/)
The reason why we are doing this is because it gives us the control to design the website,
and make sure that complies with the search engines' algorithsm.
My goal is that each documentation page has the right metadata headers and HTML semantics for the content to be well indexed by search engines like Google.

That's what I'm pretty much up to! On Sunday I'm flying to Canada to spend some days with the team to come up with a roadmap for next year ✈️.
