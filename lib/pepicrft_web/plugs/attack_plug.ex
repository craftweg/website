defmodule PepicrftWeb.Plugs.AttackPlug do
  use PlugAttack

  rule "allow local", conn do
    allow(conn.remote_ip == {127, 0, 0, 1})
  end

  rule "throttle by ip", conn do
    throttle conn.remote_ip,
      period: 60_000, limit: 10,
      storage: {PlugAttack.Storage.Ets, PepicrftWeb.Plugs.AttackPlug.Storage}
  end
end
