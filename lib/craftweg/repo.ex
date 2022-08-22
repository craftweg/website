defmodule Craftweg.Repo do
  use Ecto.Repo,
    otp_app: :craftweg,
    adapter: Ecto.Adapters.Postgres
end
