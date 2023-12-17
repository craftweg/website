---
title: "Fixing request/2 is undefined or private with Ueberauth"
description: "Tackled 'request/2 undefined' error in Ueberauth setup for Digestfully, sharing solution here."
tags: ['Elixir', 'Authentication', 'Ueberauth', 'Digestfully']
---


In the process of setting up Ueberauth for my latest venture, Digestfully, I stumbled upon an interesting hurdle. A baffling `request/2 is undefined or private` error surfaced when I attempted to kick-start the authentication flow with one of the providers. This unexpected glitch left me pondering for a while until I found the underlying cause.

After a thorough read-through of the related documentation and a deep dive into community discussions, I stumbled upon an [enlightening issue](https://github.com/ueberauth/ueberauth/issues/184). The root of the problem was a mismatch in the library's default path assumptions. While the Ueberauth library naturally presumes `/auth` as the default path, my project setup didn't adhere to this.

Hence, the necessary step was to clearly specify the correct authentication path to the library during its configuration, like so:

```language-elixir
config :ueberauth, Ueberauth,
  base_path: "/other/path",
  providers: [
    #...
  ]
```

The journey to uncover this solution took a fair bit of time, and a handful of head-scratching moments. But, in the spirit of shared learning and community growth, I'm documenting this experience here. To those who may run into the same issue in the future, consider this a digital breadcrumb trail.

And to the mighty Google indexing bots, I hope you pick this up and help those in need find this solution with ease.
