defmodule JSend.MixProject do
  use Mix.Project

  @source_url "https://github.com/codedge-llc/jsend"
  @version "0.1.0"

  def project do
    [
      app: :jsend,
      deps: deps(),
      docs: docs(),
      elixir: "~> 1.14",
      name: "JSend",
      package: package(),
      start_permanent: Mix.env() == :prod,
      version: @version
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: [:dev]},
      {:jason, "~> 1.0", optional: true}
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md",
        "LICENSE.md": [title: "License"]
      ],
      formatters: ["html"],
      main: "JSend",
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"],
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp package do
    [
      description: "JSend API specification.",
      files: ["lib", "mix.exs", "README*", "LICENSE*", "CHANGELOG*"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/jsend/changelog.html",
        "GitHub" => "https://github.com/codedge-llc/jsend",
        "Sponsor" => "https://github.com/sponsors/codedge-llc"
      },
      maintainers: ["Henry Popp"]
    ]
  end
end
