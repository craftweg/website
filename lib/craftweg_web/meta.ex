
defmodule CraftwegWeb.Meta do
  defmacro __before_compile__(_env) do
    quote do
      def metadata(_, _), do: %{}
    end
  end

  defmacro __using__(_) do
    quote do
      @before_compile unquote(__MODULE__)

      def get_metadata(%{private: %{phoenix_action: action, phoenix_view: view}, assigns: assigns}) do
        app_metadata = Application.get_env(:craftweg, :metadata)
        view_metadata = view.metadata(action, assigns)
        view_metadata = view_metadata |> Map.update(:title, app_metadata.title, fn value -> app_metadata.title <> " | " <> value end)
        Map.merge(app_metadata, view_metadata)
      end
    end
  end
end
