---
title: Streamlining app development
categories: ['shopify', 'react-native', 'xcode', 'apps']
---

One thing that I noticed after [Shopify](https://shopify.com)'s commitment to [React Native](https://reactnative.dev/) is that it foster a culture of turning ideas into mobile apps.
Doing app development is no longer a thing that only mobile developers do.
In hindshight, it was a good company decision, but it presents another set of challenges that my team,
React Native Foundations,
will have to figure out how to overcome.
Those challenges have to do with steps further down the process that are not obvious if you are not a mobile developer per-se:
_How do I share my app with another person?_ _How do I run the app on my device?_ _How can I upload my app to Google Play Store and App Store?_

Yesterday, while thinking about all of this, I came up with the idea of grouping phases along the process of developing apps in 4 categories:

- **Start:** Starting a project happens when a team has an idea and they want to make it tangigle. Traditionally they used the [React Native CLI](https://github.com/react-native-community/cli), but unfortunately, that's not enough. Creating a new project also involves setting up continuous integration and signing. What we are doing here, and we'll share more about it on the company's engineering blog, is moving the creating of projects to a web-app. Developers give their app a name, select what functionality they'd like to opt-into, and the service takes care of the rest. _Cool, isn't it?_
- **Develop:** Once the project is created, developers need to interact with it from the terminal and their editor; they need to build, test, run, and lint their code. This is something that the React Native CLI provides, but that we are wrapping inside an internal CLI tool that minimizes the amount of configuration required by providing a more opinionated development experience. The plan is also to integrate the tool with our internal infrastructure to provide useful workflows.
- **Share:** Once the app is in a usable state, developers usually want to share it with other people. In concrete terms, it would be something like uploading the app to Google Play Store and Testflight. However, at Shopify we have Shipit Mobile and a tophat which makes the sharing process very convenient without having to depend on a third-party provider.
- **Release:** Last but not least, once teams feel the app is ready to be rolled out to the final users, they need to sing and upload it to Google Play Store and Apple Store Connect. This is something for which they can use our internal Shipit Mobile platform.

It's exciting being able to translate the above user intents into workflows that developers can follow.
In the past few years we have been building individual tools that we are slowly bringing together to provide a more cohesive experience that developers enjoy.
