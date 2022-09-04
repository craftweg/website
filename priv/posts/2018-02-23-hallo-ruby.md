---
title: Hallo Ruby, wie geht's?
excerpt: It's been a long time since the last time I coded something on Ruby. In this blog post I talk about why I started using it again, and how it feels after spending a few years working with a compiled language like Swift.
categories: [technology, detox, disconnection]
---

It's been a long time since the last time I built something in Ruby. Most of the work that I've done with the language while I was iOS developer were changes on either the CocoaPods `Podfile`, or the `Fastfile`. I became super optimistic when Swift came out, and even built some command line tools and libraries contributing to the community. However, as I wrote in one of my posts, I decided to devote most of my time on interpreted and community-driven languages like Ruby or Javascript. Two things motivated me to make this decision:

- Ruby is the primary programming language at [Shopify](https://shopify.com), my current company. That was a decision made a while ago, and all the internal tools and libraries are built in Ruby. It didn't make any sense to push for another language that couldn't fully leverage the existing stuff or be integrated easily.
- I've been doing Swift since it was released. Most of my open source projects are written in Swift, and I like the language. It's beautiful and well designed. Things are moving fast, and the community is very involed the development and the decisions that are being made. However, I did a retrospective on what doing Swift means to me as a developer, and I realized that I was limiting the scope of the software that I build, contributing towards an ecosystem that is controlled by a company with a lot of power, Apple. Doing Ruby and Javascript, programming languages mainly driven my communities, I'd make my software accessible from any platform, or ecosystem. Anyone can access a website, but not everyone can have access to an iPhone or a macOS device.

Since I joined Shopify, I've been doing mostly Ruby. There are great engineers with a lot of experience here, and it's a fantastic opportunity for me to learn. It felt bizarre the first time that I tried to write some Ruby after some time off. I'd like to outline some of these strange feelings:

- **Types:** This was probably the most awful thing for me. I wasn't aware of how much I was used to types. I just used them, and I safely wrote my apps or Swift scripts. There are no types in Ruby. You call a method that takes a few arguments with some names, but you don't know which types the method implementation is expecting. Should this argument that I'm passing be a string? Should it be an array of String? With Swift you can write the code with a lot of confidence, but with Ruby most of the times, you have to dig into implementations to know what types the method expects. I've seen some Ruby projects, and they seem to leverage documentation to offer types information.
- **Where should I validate my data:** Our software gets input and returns output. If we take a mobile app, for instance, inputs are user interactions, and the output is the views presented on the screen. When an input is received, the action is propagated through our software, to produce the output. In every step of the propagation, we have the types system and the compiler to make sure that all the pieces in our software match. It won't let us go to production or the store if there's a mismatch. With Ruby, the validation happens as the action propagates through the system. If the system hasn't been designed properly, it'll result in a runtime error, and the system will need to recover from it. That scares me, and to be honest, I don't know what's the best approach to minimize this yet. It doesn't make sense to validate all the inputs in our methods because it's slow and we shouldn't assert for something that we've wrongly implemented. But if we only validate the input, can expect some runtime errors to blow up unless we thoroughly test all kind of integrations in our software.

- **Code organization:** In Ruby, there's this notion of modules. Modules are used among others, to create namespaces. That's an idea that didn't take me much to swallow cause there's something similar in Swift, but how to split modules and classes in different `.rb` files is another story. I've checked multiple open source projects, and each of them does it differently. I've seen some using `require_relative`, others using an umbrella entry point Ruby file that defines the project hierarchy autoloading all the components. I've stuck to the latter, and it's working well for me. `autoload` is not thread-safe, and that it'll be deprecated, but since I don't have any thread-safety requirements in the tools that I write, it's safe to use it. This is an example of what an umbrella Ruby file looks like:

```ruby
module Catalisis
  module Builder
    autoload :Project, 'catalisis/builder/project'
  end
end
```

I'm getting used to the things that I mentioned above. When you spend some years with a language, you tend to replicate the patterns and styles into the new language. For example, instead of using the naming convention that is commonly used in Ruby projects I literally brought the one that Swift recommends, where if something can be encoded, it should be called `Encodable`.

There are things from writing software in Ruby that I'm enjoying a lot:

- **Minitest/guard:** You can see how mature the language and the community are when you start using the tools. One that surprised me a lot if miniguard. When you write tests, it detects the files that you changed and runs the tests of those files, imediately. You can focus on writing your code/tests, and there'll be a parallel process running and telling you whether everything passes or there's an issue. You can do proper TDD.

- **Editor:** The language is not tied to any editor/IDE so you can choose whatever works best for you. If you prefer something closer to the Xcode experience, you can try any IDE from the JetBrains suite. If you are a minimalist and just want a simple text editor with syntax highlighting and pluggable add-ons to customize your workflows and make you more productive you can use Sublime, Atom or VSCode. I personally use VSCode. It' simple, fast and extensible. It has just what I need to work on my projects.

- **Libraries:** Whatever you can imagine can very likely found as a Gem. The community has been building libraries for a long time. This saves you a considerable amount of time.

- **Distribution:** Your projects can be distributed as gems. You can install it on your system, and it'll install all the necessary components to get it working. This is not officially supported by Swift and its package manager, so you have to appeal to non-official tools. I wouldn't be surprised if Apple includes this as a feature in the Swift Package Manager, but even with that, pre-compiled binaries would break with new versions of Swift because it hasn't reached ABI stability yet.

I hope you enjoyed this brief reflection. If you are more familiar with Kotlin or Javascript, you can replace Swift and Ruby by Kotlin and Javascript and the points mentioned above should apply as well. As I mentioned earlier, making the software that I write more accessible is for me one of the key motivators and having the opportunity to do it at Shopify is one of the best decisions I've recently made. You can expect more Ruby OSS coming from me from now on :).

If you have had a similar experience transitioning from a static to a dynamic language I'd like to hear your experience. Don't hesitate to leave a comment right below.
