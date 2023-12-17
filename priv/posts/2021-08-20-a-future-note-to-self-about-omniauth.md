---
title: 'A future note to self about Omniauth'
tags: ['rails', 'devise', 'open-source', 'omniauth']
---

Every time I try to set up [Omniauth](https://github.com/omniauth/omniauth) on a Rails codebase I run into the same issue:

```
Not found. Authentication passthru
```

And every time I have to spend a fair amount of time understanding what's causing the error.

Luckiy it won't have anymore after writing this note for my future self.

Besides the standard steps to set up Omniauth and [Omniauth GitHub](https://github.com/omniauth/omniauth-github),
we need to add [omniauth-rails_csrf_protection](https://github.com/cookpad/omniauth-rails_csrf_protection) to bring [CSRF Protection](https://owasp.org/www-community/attacks/csrf) to the requests that are sent from the authentication pages.
After adding the dependency to the `Gemfile`, we need to add a new initializer, `omniauth.rb`, to allow sending `POST` requests from the Omniauth links:

```language-ruby
OmniAuth.config.allowed_request_methods = [:get, :post]
```

In that same initializer,
we need to set the host to ensure Omniauth passes the right redirection URL when initiating the authentication flow.
Otherwise the Omniauth provider might fail due to mismatching URLs:

```language-ruby
OmniAuth.config.full_host = "https://myapp.com"
```

If we generated the Devise views under our project's `app/views` directory, we can notice that the Omniauth links are already configure to be `POST` in the `_links.html.erb` file:

```erb
 <%= link_to("Sign in with #{OmniAuth::Utils.camelize(provider)}",
       omniauth_authorize_path(resource_name, provider),
       { method: :post }) %>
```

And last but not least, we need to instruct Omniauth on what to do once the authentication flow has finished.
We do that by configuring a controller in the `routes.rb`:

```language-ruby
Rails.application.routes.draw do
  # Devise
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
end
```

In the controller each provider is represented by a method with the same name of the provider.
Note that the request's `env` attribute provides all the user metadata that we need to find or create the user in our database and authenticate them using Devise's `sign_in_and_redirect` method:

```language-ruby
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = ... # Create the user

    if @user.persisted?
      sign_in_and_redirect(@user, event: :authentication)
    else
      data = auth_data.except("extra")
      session["devise.oauth.data"] = data
      redirect_to(new_user_registration_url)
    end
  end

  def failure
    redirect_to(root_path)
  end

  def auth_data
    request.env["omniauth.auth"]
  end
end
```

And that should be it.
I hope this is also useful for other users running into similar issues with the [Gem](https://rubygems.org/).
