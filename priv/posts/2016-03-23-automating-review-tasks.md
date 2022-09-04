---
title: 'Automating iOS review tasks with Danger'
excerpt: 'Post that explains how to automate review tasks with the help of the tool Danger'
categories: [review, danger, pr, github]
---

This week I've been working automating some review tasks at SoundCloud with a tool called [Danger](https://github.com/danger/danger) from [@orta](https://github.com/orta/) and [@krausefx](https://github.com/KrauseFx). We had some linting tasks in CI that analyzed the code and stopped the whole build process notifying the affected developers about something not matching the project specs. Developers had to go into Jenkins (in our case), check out the build log, fix what was failing, commit and push the changes restarting the pipeline execution. **What if we could report all that handy information and check results directly to GitHub?** That's exactly what Danger tool does. I first heard about it reading this very interesting article from Orta title ["Being a Better Programmer When You're Actually Lazy"](http://artsy.github.io/blog/2016/03/02/Lazily-Automation/). Just summarizing what Danger does:

1. You include an extra step in your CI build process that executes danger `bundle exec danger`
2. Danger reads a file `Dangerfile` that contains the checks _(ruby code)_.
3. It exposes a set of useful environment variables like the PR title, the files that changed,... It also exposes methods to report the result of these checks `warn()`, `fail()`, `message()`.
4. Once `Danger` completes it sends a comment to the opened PR with the results _(as you can see in the screenshot below taken from the article mentioned)_.

> The tool uses the user you specify through a DANGER_GITHUB_API_TOKEN environment variable

![Danger](https://artsy.github.io/images/2016-03-02-Lazily-Automation/danger.png)

### Creating "dangers" in multiple ruby files

When I tried the tool I felt that adding all the Ruby logic in a single `Dangerfile` was going to turn the file into a big mess. _What about having a `danger` folder with all the tasks?_ Then we could require these tasks from `Dangerfile` and execute them one after another.

> The steps below show how I ended up doing it. It doesn't mean it's then only way. There're probably some other alternatives. This is the one I tried and that worked with our project structure, keeping all the danger checks in their own folder.

- First create a folder `danger` where all the tasks/checks will be.
- Each of these checks represents a ruby file. Its structure would be like this one:

```ruby
require 'danger'

module Danger
  module Checks

    # This Danger step checks if the number of line is over a maximum value.
    # In that case it warns the developer
    class PRSize < Base

      def initialize(dangerfile, max_lines)
        @max_lines = max_lines
        @dangerfile = dangerfile
      end

      def execute
        @dangerfile.warn("This PR is over #{@max_lines} lines of code. Make it smaller or create multiple PRs.") if @dangerfile.lines_of_code > @max_lines
      end

    end

  end
end
```

Where every check inherits from `Danger::Checks::Base`. That base class defines a base constructor with taking a `Danger::Dangerfile` instance that contains all the environment variables exposed from Danger, variables like the number of lines of your PR, the new files added,...:

```ruby
require 'danger'

module Danger
  module Checks
    class Base

      attr_accessor :dangerfile

      def initialize(dangerfile)
        @dangerfile = dangerfile
      end

      def execute
        raise "-execute method must be overriden"
      end

    end

  end
end
```

> If you want to use `warn`, `message`, `fail` methods and environment variables you can access them from the @dangerfile attribute.

Then the structure of your `Dangerfile` would look like this one:

```ruby


Dir["./danger/*.rb"].each {|file| require file }

## Constants
MAX_PR_LINES = 500
PINGEABLE_RESOURCES = [
  { regex: /SoundCloud\/Classes\/Player/, username: "pepibumur", name: "Player"}
]
# Checks
Danger::Checks::PRSize.new(self, MAX_PR_LINES).execute()
Danger::Checks::IncludeSpecs.new(self).execute()
Danger::Checks::Todo.new(self).execute()
Danger::Checks::Ping.new(self, PINGEABLE_RESOURCES).execute()

```

These are just some examples of _checks_ that we're using but the options are infinite:

- **PRSize**: Checks if the number of lines in the PR is over a given value.
- **IncludeSpecs**: Checks if any new `.m` file includes unit tests.
- **Todo**: Checks if the developer forgot any `// TODO` somewhere in the code.
- **Ping**: Analyzes modified files and notifies developers that might be directly concerned about these changes because they, for example, own the feature whose file has been modified.

## Conclusion

There're manual processes that are unavoidable, even though, tools like Fastlane & Danger are helping to automate the majority of them. When we're so focused on our projects we don't worry that much about the time we spend in repetitive tasks _(since we only think about developin)_. The time that we can spend on these tasks can be huge and it's worth to spend some time setting up either _Danger_, _Fastlane_ and try to automate as many processes as you can.
