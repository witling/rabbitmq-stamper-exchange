defmodule RabbitExchangeTypeStamper.MixProject do
  use Mix.Project

  def version, do: "1.0.0"

  def project do
    [
      app: :rabbitmq_stamper_exchange,
      version: version(),
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # We use `true` as the command to "build" rabbit_common and
      # amqp_client because Erlang.mk already built them.
      {
        :rabbit_common,
        github: "rabbitmq/rabbitmq-common",
        app: false,
        #compile: ":",
        #override: true
      },
      {
        :rabbit,
        github: "rabbitmq/rabbitmq-server",
        app: false,
        #compile: ":",
        #override: true
      },
    ]
  end

  defp aliases do
    [
      build: [ &build_release/1 ],
      make_deps: [
        "deps.get",
        "deps.compile",
      ],
      make_app: [
        "compile",
      ],
      make_all: [
        "deps.get",
        "deps.compile",
        "compile",
      ],
    ]
  end

  defp build_release(_) do
    outdir = "./_build"
    Mix.Tasks.Compile.run([])
    #Mix.Tasks.Archive.Build.run([])
    Mix.Tasks.Archive.Build.run(["--output=#{outdir}/rabbitmq_stamper_exchange.ez"])
    # overwrite old version with new build
    #File.cp("#{outdir}/rabbitmq_stamper_exchange.ez", "./archive/rabbitmq_stamper_exchange.ez")
    # write current build to archive
    #File.rename("#{outdir}/rabbitmq_stamper_exchange-#{version()}.ez", "./archive/rabbitmq_stamper_exchange-#{version()}.ez")
  end
end
