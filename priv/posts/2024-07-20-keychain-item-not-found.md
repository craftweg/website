---
title: "The specified item could not be found in the keychain"
description: "Fix the not found keychain item issue by making the keychain the system default"
tags: ["Signing", "macOS"]
---

Trying to `codesign` a macOS CLI on CI using certificates in a temporary keychain yielded the following error:

```lang-bash
The specified item could not be found in the keychain
```

It turns out that even when passing the keychain with flags like `--keychain`, if the keychain is not made the default one, it fails. Therefore, I ended up making it the default:

```language-bash
security create-keychain -p $KEYCHAIN_PASSWORD $TMP_KEYCHAIN_PATH
security default-keychain -s $TMP_KEYCHAIN_PATH
security import $CERTIFICATE_PATH -P $CERTIFICATE_PASSWORD -A
```

So, this blog post is a note for my future self because I'm sure I'll come across this again.
Or perhaps for anyone coming across the same issue.
