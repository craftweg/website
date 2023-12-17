---
title: Reliably installing Xcode
description: I started developing a tool, install-xcode that aims to help developers to install and upgrade versions of Xcode easily. In this blog post I talk about the motivation behinds building it and some design principles that I'm embrazcing.
tags: [xcode, swift, ios, macos]
---

Apple hasn't traditionally done a good job at providing convenient channels for distributing their tools for development environments. A good example of that is Xcode. If you want to install it on your laptop and have an account on the App Store is fine. You just need to search for it, click download and voila 🎉! You can start coding straight away.

However, if the environment where you are trying to install Xcode doesn't have a GUI, the installation process is not straightforward. First of all, one needs to know the link where to download Xcode from. You can authenticate on the developer portal, go to the downloads section, and copy the link of the Xcode version that you wish to download. Not too much of a hassle, but it's one step that needs to be done manually. Optionally, you can depend on a third-party website like [xcodereleases](https://xcodereleases.com/), which provides an up-to-date list of all the Xcode versions with their download link.

Compared to other apps that you can drag & drop into the system `/Applications` directory and start using them, Xcode requires some additional steps to be executed:

- Agree with non-agreed or new licenses.
- Install missing components.

[xcode-install](https://github.com/xcpretty/xcode-install), a well-known Ruby tool from the community, has been the tool most teams resorted to, including Shopify. It drives the whole process asking the user for input if necessary _(like providing the 2 factor authentication code to authenticate the access to the download page)_. The tool makes the process more convenient, but in my experience, doesn't provide the level of reliability and convenience that one expects when upgrading Xcode versions. It's not something that we have to do every day, but when it has to be done, it's fairly frustrating seeing the tool dumping errors on the terminal. For that reason, I embarked on developing a new command line tool in Swift to help developers install and upgrade Xcode versions:

- The tool will be written in Swift. No more dependencies with Ruby or transitive native dependencies whose compilation might fail as stated on the [xcode-install's README](https://github.com/xcpretty/xcode-install#installation).
- It's distributed as a self-contained binary. Just install it anywhere on the system and run it.
- No more authentication required from the installer. The list of versions will be synchronized periodically and placed on the repository as a json file, `downloads.json`. If all of a sudden Apple decides to introduce a 3 factor authentication with a short notice period, well, users of the tool won't have to change anything, we'll deal with that for them.

It's still work in progress but you can look in to it [on this repository](https://github.com/angledotdev/install-xcode).

I hope you are having a great weekend 🥘🌴
