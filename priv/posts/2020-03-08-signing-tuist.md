---
title: A better signing experience in Xcode
categories: ['tuist', 'signing', 'xcode', 'fastlane']
---

A few days ago, [Marek](https://twitter.com/marekfort) decided to take on a proposal that I made for Tuist a while ago, **management of certificates and provisioning profiles**.

As it happened with the definition of dependencies, dealing with certificates and provisioning profiles is something that annoyed me a lot. It takes time to understand all the concepts and get it right right, and it can take even longer to understand issues when they arise. In my experience, there's usually a go-to person in each team to help debug and solve signing issues when they arise. That's pretty bad. Configuring signing should be straightforward and issues should be easier to debug and fix.

[Fastlane](https://docs.fastlane.tools/actions/match) helped with automating the generation of the certificates and the profiles but doesn't prevent developers from setting the wrong settings to their projects.

**How can Tuist do things better?** It can make certificates and profiles an implementation detail of signing; like we did with linking build phases being an implementation detail of dependencies. Those are part of the repository and encrypted using a team's key that will need to be present in the local and CI environments.

At **project generation time**, Tuist will decrypt and validate them, and configure both, the environment and the project, for the signing to work. If something is missing or invalid, we'll fail early to prevent developers from facing signing issues in Xcode.

Moreover, to eliminate the need to configure anything on the user end, we'll establish the following naming convention:

- **Certificates:** Configuration.p12 _(e.g Debug.p12)_
- **Profiles:** Target.Configuration.mobileprovision _(e.g MyApp.Debug.mobileprovision)_

Thanks to that convention, the configuration will be zero, and Tuist will know which certificates and profiles to take from `Tuist/Signing`, for each of the targets that are part of the dependency graph.

Project generation is a powerful tool to help teams with their scaling issues yet we are just starting to see its real benefits. Check out [the docs](https://tuist.io/docs/usage/getting-started/) to know how to adopt it in your projects.
