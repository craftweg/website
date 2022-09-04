---
title: Pairing sessions to introduce people to Tuist and open-source
categories: ['tuist', 'community', 'coaching']
---

I recently started having pairing sessions with developers interested in contributing to open-source; it’s something that usually intimidates people, but that becomes easier if someone guides you through the first contribution. You have a person that can answer any question you might have and that can give you an overview of the projects ad the decisions made in the past.

I’ve had two of them and I love it. Getting new people to contribute to Tuist brings new and more diverse ideas to the table. Moreover, they bring more energy which is the fuel for the project to move forward.

To make the first-time experience great, I pick a feature that I know is implementable end-to-end in one session. For example, in the session we worked on a `tuist lint code` command to lint projects’ code using SwiftLint, and in the second one we implemented a `tuis doc` to auto-generate documentation from targets.

Doing these sessions made me realize how great idea it was following the uFeatures architecture in Tuist. It’s very easy to add a new feature alongside the others, and build its business logic by composing existing pieces of business logic. Moreover, it’s easy to compare the existing architecture, with what they know from building iOS apps. For example, I tell them that the CLI is the App Delegate, that commands are like views, and since views should not have logic, we extract the business logic into services.

If you maintain an open-source project I’d strongly recommend doing something like this.

If you are reading this and would like to pair on the project too you can let me know and I’ll be happy to schedule a session and do a bit of hacking together.
