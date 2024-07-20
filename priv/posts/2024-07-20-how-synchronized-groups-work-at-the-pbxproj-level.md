---
title: "How synchronized groups work at the .pbxproj level"
description: "Learn about the new PBXObject types introduced in Xcode 16 to support synchronized groups."
tags: ["Xcode", "Tuist"]
---

I started working on [supporting Xcode 16's features](https://github.com/tuist/XcodeProj/pull/827) in [XcodeProj](https://github.com/tuist/xcodeproj).
One of those features is internal _"synchronized groups"_, 
which Apple introduced to minimize git conflicts in Xcode projects.
In a nutshell,
they replace many references to files in the file system with a reference to a folder containing a set of files that are part of a target.
Xcode dynamically synchronizes the files, hence the name, in the same way packages are synchronized when needed.

I'm excited about it because it addresses an issue that has remained unaddressed for many years and that motivated many people to adopt [Tuist](https://tuist.io) or SPM as a project manager.
However,
I wonder if adding more dynamically-resolved features,
like the resolution of packages,

Whether that'll lead to the best developer experience is something we'll see down the road,
but that's not the point of this blog post.

If you wonder what the changes mean at the `.pbxproj` file level, a format I got very familiar with thanks to my work on Tuist,
here's an overview of what I learned today.
Groups can now have a child of type `PBXFileSystemSynchronizedRootGroup`.
They reference a folder whose files will be automatically synced and tied to a target.
For example, there are a bunch of Swift source files.
In the example below, that folder is `Frameworks`, relative to the parent containing this group:

```language-plist
/* Begin PBXFileSystemSynchronizedRootGroup section */
		6C14E0CA2C4BC30C00635BF3 /* Framework */ = {
      isa = PBXFileSystemSynchronizedRootGroup; 
      exceptions = (6C14E0E62C4BC38800635BF3 /* PBXFileSystemSynchronizedBuildFileExceptionSet */, ); 
      explicitFileTypes = {}; 
      explicitFolders = (); 
      path = Framework; 
      sourceTree = "<group>"; 
      };
/* End PBXFileSystemSynchronizedRootGroup section */
```

Then Apple introduced another object, `PBXFileSystemSynchronizedBuildFileExceptionSet`, which is used to provide "exceptions." Those exceptions are used for three things, and maybe others that I'm yet to uncover:

- Filtering out certain files and folders.
- Overriding the default file type.
- Configuring the type visibility.

Those are the only two models that are needed to enable this functionality.
Once we land this feature in XcoeProj,
I'll explore what the API could look like in Tuist for users who want to opt into it,
although the value is not that significative in this case since git conflicts are not that much of an issue in Tuist land.
