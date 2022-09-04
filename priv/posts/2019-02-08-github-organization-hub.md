---
title: GitHub as an organization hub
excerpt: With the recent GitHub announcement of personal projects, I'm considering using GitHub as a todo platform where I can not only keep track of work-related tasks, but also personal ones. In this brief blog post I talk about how I used to organize myself, and why I think GitHub projects might suit my needs well.
categories: [github, projects, todo, organization, productivity]
---

An idea that I've been pondering lately is **using GitHub for organizing myself**. In the last years, I've tried several approaches to organize myself: _Trello boards, todo apps such as [Todoist](https://todoist.com), plain text files_. None of them worked well for me. I realized that most of my work happens on GitHub, so I found it very annoying having to create references between the tasks and the work on GitHub. For example, if there is an open source issue that I want to address the day after, I have to create a task and then make sure that I don't forget to add the link to the issue, otherwise the task would lack some context.

I tried those services that leverage webhooks to synchronize worlds _([Zapier](https://zapier.com) is an example)_, but it felt too much having to add another tool to the mix. Moreover, if you have ever worked with webhooks you might know how unreliable they are. You create an issue on GitHub and it doesn't show up on the todo app, or complete the task and the GitHub issue doesn't get closed. Thinking about about potential synchronization issues made me feel uncomfortable.

Today I [read this announcement from GitHub](https://github.blog/2019-02-07-user-owned-projects-your-personal-workspace/), where they they announced personal projects. You can use projects, a feature that has been in the platform for a long time, but associated to your user. You can link the projects to the repositories you are involved with. In my case, I can see three projects, **personal**, **shopify**, **open source**:

- **Personal:** I'd create a repository, perhaps named todo, where I can have all life-related tasks. I'd move all my tasks from Todoist into that repository. I get exactly the same features that I use from Todoist: labels, comments, attachments. Furthermore, I don't have to pay for any subscription because GitHub offers now private repositories for free.
- **Shopify:** I'd link this project to all the internal repositories that I work on the most. We are already using GitHub issues to keep track of the work that we are doing or needs to be done so I only need to create tasks for those issues and move them along the project boards. Re-organizing these tasks is something that I'd do as the first thing in the morning. _What should I focus on today?_
- **Open source:** In this one I'd group all the open source work that I do, pretty much the repositories from [Tuist](https://github.com/tuist).

It might sound a geek thing using GitHub as a platform for self-organization but I don't see why not. I think GitHub has all the elements that are necessary for that. I'm even considering building a simple todo client for iOS, written React Native client, and that uses GitHub as a backend. _Do you imagine an app like Todoist but that persist your tasks into a GitHub repository/project?_

I'm going to set up everything in the next days and see if it works or maybe the idea is not as great as I thought it would be.

How do you organize yourself?
