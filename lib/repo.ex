defmodule ReEnv.Repo do
  use Ecto.Repo,
    otp_app: :reenv,
    adapter: Ecto.Adapters.Postgres

  defmacrop env_specific(config) do
    quote do
      unquote(
        Keyword.get_lazy(
          config,
          Mix.env(),
          fn -> Keyword.fetch!(config, :else) end
        )
      )
    end
  end

  def init(_, config) do
    {:ok, config
    |> Keyword.merge(env_compiled_settings())
    |> Keyword.merge(
      [
        hostname: System.fetch_env!("DB_HOST"),
        port: System.fetch_env!("DB_PORT") |> String.to_integer(),
        username: System.fetch_env!("DB_USERNAME"),
        password: System.fetch_env!("DB_PASSWORD"),
        database: env_specific(test: "reenv_test", else: System.fetch_env!("DB_DATABASE")),
      ]
      )}
  end

  case Mix.env() do
    :dev ->
      defp env_compiled_settings, do:
      [
        show_sensitive_data_on_connection_error: true,
        log: false,
      ]

    :test ->
      defp env_compiled_settings, do:
      [
        pool: Ecto.Adapters.SQL.Sandbox
      ]

    _ ->
      defp env_compiled_settings, do:
      [
        pool_size: 20,
        queue_target: 5000,
      ]
  end
end
