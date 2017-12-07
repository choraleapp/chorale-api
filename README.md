# Chorale API

Chorale is a music+podcast app. The backend for it — the user auth, app hooks, where music’s hosted — runs because of the code found here.

## Install

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `chorale_api` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:chorale_api, "~> 0.1.0"}]
    end
    ```

  2. Ensure `chorale_api` is started before your application:

    ```elixir
    def application do
      [applications: [:chorale_api]]
    end
    ```

## License

[AGPLv3](https://github.com/choraleapp/chorale-api/blob/master/LICENSE.md)
