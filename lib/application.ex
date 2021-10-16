defmodule Reenv.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ReEnv.Repo
    ]

    opts = [strategy: :one_for_one, name: Reenv.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
