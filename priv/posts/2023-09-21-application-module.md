---
title: "Exploring Mocking Solutions in Elixir: Introducing application_module"
description: "Exploring Elixir's Mox for mocking reveals boilerplate code issues. A new package, application_module, aims to streamline this process."
categories: ['Elixir', 'Testing', 'Mocking']
---

I've recently delved into the world of mocking in Elixir and have been particularly intrigued by the Mox package, endorsed by José Valim. While studying this approach, I noticed that it could introduce a considerable amount of boilerplate code into a codebase, along with potential inconsistencies in how module references are managed in the application environment. I couldn't help but think there had to be a more streamlined solution. 

Take, for example, the typical module structure in such a setup:

```language-elixir
defmodule MyModule do
  @behaviour __MODULE__.Behaviour

  def hello(name) do
    application_env_module().hello(name)
  end

  def application_env_module() do
    get_in(Application.get_env(:my_app, :modules), [:my_module]) || __MODULE__.Implementation
  end

  defmodule Implementation do
    @behaviour MyModule.Behaviour

    def hello(name) do
      "Hello #{name}"
    end
  end

  defmodule Behaviour do
    @callback hello(name :: String.t()) :: any()
  end
end
```

In this example, `MyModule` serves as a facade that selects an appropriate module based on the application environment configuration. If a module atom is specified, it's utilized; otherwise, the code defaults to the built-in implementation. However, this structure has some downsides:

- Boilerplate code that acts as a proxy to the underlying implementation could be automatically generated.
- The method `application_env_module` and related naming conventions can become inconsistent across the codebase.

To tackle these challenges and experiment with Elixir macros, I created a new package for the Elixir ecosystem named [`application_module`](https://hex.pm/packages/application_module). With this package, the previous example can be refactored as follows:

```language-elixir
defmodule MyModule do
  use Application.Module

  defimplementation do
    def hello(name) do
      "Hello #{name}"
    end
  end

  defbehaviour do
    @callback hello(name :: String.t()) :: any()
  end
end
```

Notice how much more concise and ergonomic the code has become. I chose to prioritize convention over configuration, thereby standardizing the naming of child modules and the keys within the application environment.

For those who use Mox for mock definitions, you can easily set a mock like so:

```language-elixir
Mox.defmock(MyModule.mock_module(), for: MyModule.behaviour_module())
MyModule.put_application_env_module(MyModule.mock_module())
```

I'd love to hear any feedback on the implementation or the API design. This is my inaugural venture into Elixir macros, and the journey has been both rewarding and a process of trial and error.
