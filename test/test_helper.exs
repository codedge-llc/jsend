# The built-in JSON module arrived in Elixir 1.18.
exclude = if Code.ensure_loaded?(JSON), do: [], else: [:json]

ExUnit.start(exclude: exclude)
