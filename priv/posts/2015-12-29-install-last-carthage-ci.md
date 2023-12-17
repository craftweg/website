---
title: 'Install the last Carthage version on CI services (Travis, Circle, ...)'
description: 'Very simple script to keep your Carthage version updated without depending on Brew.'
tags: [carthage, travis, ci]
---

I've lately been working with multiple libraries and integrating them with CI, in particular Travis-CI because these libraries are Open Source. These libraries have dependencies that are resolved and built using [Carthage](https://github.com/carthage) which is distributed through Github Releases and [Brew](http://brew.sh). However, the version in brew does not always match the last version available on Github Releases and your CI providers don't offer the last version either. **What can you do then?**. Get the last version from Github and install it with a very simple script, _how?_:

`gist:pepibumur/3e088a936b9b03359af1`

Use that bash script passing as argument the version of Carthage that you want to install. It'll download the last `.pkg` available and install it. For example, if we wanted to use it in our `.travis.yml` script:

```language-ruby
language: objective-c
notifications:
  email: false
xcode_project: SugarRecord.xcodeproj
osx_image: xcode7.2
before_install:
  - bash update_carthage.sh 0.11
```

Short but useful! Enjoy coding
