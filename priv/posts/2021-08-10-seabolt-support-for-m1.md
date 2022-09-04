---
title: Seabolt support for M1
categories: ['graph databases', 'neo4j', 'seabolt', 'open source']
---

As part of building **Chimera**,
an AppleOS tool for capturing networked knowledge, thoughts, and ideas,
I encountered an issue trying to set up [Neo4j](https://neo4j.com/developer/ruby/) on an M1 laptop _(i.e. arm64 architecture)_.
It turns out that [Seabolt](https://github.com/neo4j-drivers/seabolt),
the connector that [neo4j-ruby-driver](https://github.com/neo4jrb/neo4j-ruby-driver) uses to communicate with a running instance of Neo4j,
doesn't have support for M1s.
It was a bit of a bummer,
but luckily I found [this fork](https://github.com/teomores/seabolt-M1) that someone created to add support.

If you run into this same issue in the future,
you can either run the steps on that repository or download the [compiled version](/assets/tools/seabolt/seabolt-1.7.4-dev-Darwin.tar.gz) that I built myself.
[Here](seabolt-1.7.4-dev-Darwin.tar.gz.sha256) is the sha256 checksum to validate you downloaded the correct binary.

```bash
shasum -a 256 seabolt-1.7.4-dev-Darwin.tar.gz
```

Once you verify the binary is correct,
you can untar the content,
and copy the dynamic library into the directory where the driver expects it:

```bash
cd build/dist/lib
cp libseabolt17.dylib /usr/local/lib/libseabolt17.dylib
```

And that would be it.
The Neo4j Ruby driver should be able to initialize successfully.

### A note on Chimera

It's the first time I mention Chimera,
so you might be wondering what's that tool.
You are probably familiar with tools for capturing networked notes like [Roam Research](https://roamresearch.com/) and [Obsidian](https://obsidian.md/).
They are great because they remove the friction of giving your ideas, knowledge, and thoughts a structure other than the one they have in your brain.
However,
they are designed and optimized for the web.
If you try to use them from your phone,
the user experience is terrible.
And because ideas can arise at any time,
and you usually have your phone with you,
I think having an app optimized for native will take the experience of capturing them to a whole new level.
So that's what I set out to build;
a tool for **networked thoughts, ideas, and knowledge**.
I'll focus on Apple platforms first,
following their [human interface guidelines](https://developer.apple.com/design/human-interface-guidelines/).
I'm very excited to use [Tuist](https://tuist.io) myself and learn about [SwiftUI](https://developer.apple.com/xcode/swiftui/) to make this happen.
