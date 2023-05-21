---
title: How to Configure VSCode to Use Alternative Shells
description: "Learn how to easily configure VSCode to use your preferred alternative shell installation like ZSH or Fish instead of the default profiles."
categories: [Nix, Shell]
---


If manage the installation of alternative shells like [ZSH](https://en.wikipedia.org/wiki/Z_shell) or [Fish](https://fishshell.com/), as I do via [Nix](https://github.com/pepicrft/dotfiles.nix),
you might consider configuring VSCode to use that installation instead of using the VSCode's default profiles.
If so, you can do it easily by opening the VSCode settings, defining a new profile, and setting it up as the default:

```language-json
"terminal.integrated.profiles.osx": {
    "Nix-managed ZSH": {
      "path": "/Users/pepicrft/.nix-profile/bin/zsh"
    }
},
"terminal.integrated.defaultProfile.windows": "Nix-managed ZSH"
```


