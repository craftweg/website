---
title: "Integrating Swift Macros with Xcodeproj native blocks"
description: "Exploring native Swift macro support in Tuist to simplify and accelerate Xcode project builds."
categories: ['Macros', 'Swift', 'Xcode']
---
[Swift Macros](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/macros/) were introduced by Apple as a feature bundled within Swift Packages. This approach enhances shareability—a notable limitation of [XcodeProj](https://github.com/tuist/xcodeproj) elements like [targets](https://github.com/tuist/XcodeProj/blob/main/Sources/XcodeProj/Objects/Targets/PBXNativeTarget.swift). However, it also tightens the reliance on seamless integration between Xcode and the Swift Package Manager (SPM), which, from my experience and that of others, can be less than ideal in large projects with numerous dependencies. In fact, some developers are shifting towards Tuist's methodology, reminiscent of [CocoaPods](https://cocoapods.org), where projects are immediately ready for compilation upon opening.

Given the suboptimal experience offered by Apple's ecosystem, which precludes optimization opportunities, **Tuist employs SPM to resolve packages before mapping them onto Xcodeproj elements.** While generally effective, this approach has encountered occasional setbacks, which developers can rectify by tweaking the build settings of the generated targets. Yet, it has not supported Swift Macros since their announcement.

Interestingly, developers managing Xcode rules for [Bazel](https://bazel.build) quickly [devised a method to accommodate Swift Macros using compiler flags](https://github.com/bazelbuild/rules_swift/pull/1061). Inspired by this, *could Tuist adopt a similar strategy by utilizing targets, dependencies, and build settings?* After some investigation, the answer is affirmative. Here's the **blueprint**:

The macro's representative target must be a **macOS command-line target**, encompassing the macro's source code.
A secondary, dependent target is required, hosting the public macro definition for import by other targets.


Targets wishing to leverage the macro should:
- Establish a dependency on the secondary target for prior compilation.
- Include the setting `OTHER_SWIFT_FLAGS` with the value `-load-plugin-executable $BUILT_PRODUCTS_DIR/ExecutableName\#ExecutableName`.

This setup is contingent upon the secondary target and the dependent targets producing their outputs in the same directory. If that's not the case, `SWIFT_INCLUDE_PATHS` will be necessary to make the module available to the dependent targets.

With this mechanism uncovered, the next step is to integrate it into Tuist's Swift-based DSL and combine it with our binary caching feature. This integration will enable developers to concentrate on targets dependent on macros without the overhead of compiling the macros themselves.
