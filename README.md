# ReEnv

Case project of Sasa Juric's [Rethinking app env](https://www.theerlangelist.com/article/rethinking_app_env), showcasing Ecto configuration in `ReEnv.Repo`, wo/ `config.exs`.

```sh
docker-compose up -d
set -a; source .env; set +a
iex -S mix
```

Test out `Repo` in an `iex` session:
```elixir
Ecto.Adapters.SQL.query! ReEnv.Repo,
                         "create table foo (id integer primary key generated always as identity, bar integer)"
Ecto.Adapters.SQL.query! ReEnv.Repo,
                         "insert into foo (bar) values (2)"
```