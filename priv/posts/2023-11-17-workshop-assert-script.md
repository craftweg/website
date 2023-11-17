---
title: "Ensuring a smooth workshop experience"
description: "In preparation for a workshop that I'm conducting in Swiftable (Buenos Aires), I came up with an idea to ensure a smooth experience following the workshop"
categories: ['Swiftable', 'Conferences', 'Open Source', 'Tuist']
---

While preparing a workshop for [Swiftable](https://swiftable.com),
I wondered how the attendees could verify that they were ready to continue with the next topic.
Jumping to the next topic with their setup in an invalid state can make a difference between enjoying the workshop from beginning to end and feeling completely stuck and lost.
To tackle it,
I came up with the idea of providing the developers with a script that they can run at the end of every section:

```language-bash
bash <(curl -sSL https://url-to-server.com/assert.sh) 1
```

`1` is the number of the section that they just completed. Note how convenient it is to run it because you only need `bash` in your system, which is a safe assumption to make.
I believe the fewer system requirements for the workshop and everything that surrounds it, the better.
As a fallback, I provide a Git repository and a commit sha at the end of every section that developers can check out to continue with the workshop.

I'll test the method in a couple of weeks and report back.
