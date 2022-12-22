defmodule Pepicrft.Repo do
  use Ecto.Repo,
    otp_app: :pepicrft,
    adapter: Ecto.Adapters.Postgres
end
