---
title: Fixing psych compilation error trying to install Ruby on an Apple M2 laptop
description: "Buckle up for a hilarious adventure in Ruby installation! Unravel the mysteries of rtx, Homebrew, and secret environment variables."
tags: [Homebrew, Ruby, GitHub, rtx, asdf]
---

Let me tell you about the hilarious roller coaster ride I had today while attempting to install [Ruby 3.2.2](https://www.ruby-lang.org/en/news/2023/03/30/ruby-3-2-2-released/) using [rtx](https://github.com/jdxcode/rtx), which is basically a turbocharged version of asdf. Man, oh man, did I encounter some wild errors during this wild adventure! But fear not, dear readers, because I've got the solution to this mind-boggling puzzle, and I'm here to share it with you. **Consider it my gift to humanity, saving you precious time and countless headaches.**

So, buckle up and let's dive into the wacky world of Ruby installation! The first step on this zany journey is to install a few packages via [Homebrew](https://brew.sh). Here's the list of packages you'll need:

```language-bash
brew install zlib readline libyaml libffi
```

Once you've got them installed, it's time to do some secret-agent-style stuff with your environment variables. These variables are like **the secret codes that the Ruby compiler uses to link itself to the libraries you just installed through Homebrew**. Sneaky, right?

Open up your `~/.zshrc` file *(or your shell profile of choice)* and add the following lines:

```language-bash
# ~/.zshrc
export RUBY_YJIT_ENABLE=1
export RUBY_CONFIGURE_OPTS="--with-zlib-dir=$(brew --prefix zlib) --with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline) --with-libyaml-dir=$(brew --prefix libyaml) --with-gdbm-dir=$(brew --prefix gdbm)"
export CFLAGS="-Wno-error=implicit-function-declaration"
export LDFLAGS="-L$(brew --prefix libyaml)/lib"
```


Now, here's the kicker: to make sure these environment variables actually kick in, you need to either open a fresh terminal session or give your profile a good old source. It's like summoning the magical powers of Ruby by performing a secret ritual. Trust me, it's worth it!

Alright, folks, that's all there is to it! You're now armed with the knowledge to conquer the Ruby installation beast and emerge victorious. May your future terminal sessions be error-free, and may your code flow like a river of laughter.
