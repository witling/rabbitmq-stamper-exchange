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
      outdir: "./_build",
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      #extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps() do
    [
      # We use `true` as the command to "build" rabbit_common and
      # amqp_client because Erlang.mk already built them.
      {
        :rabbit_common,
        git: "https://github.com/rabbitmq/rabbitmq-common.git",
        app: false,
        #path: "deps/rabbit_common",
        compile: "true",
        override: true
      },
      {
        :rabbit,
        git: "https://github.com/rabbitmq/rabbitmq-server.git",
        app: false,
        #path: "deps/rabbit",
        compile: "true",
        override: true
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
    compile_erlang_deps(Mix.Project.config[:deps_path])
    outdir = Mix.Project.config[:outdir]

    Mix.Tasks.Compile.run([])
    Mix.Tasks.Archive.Build.run(["--output=#{outdir}/rabbitmq_stamper_exchange.ez"])
  end

  defp compile_erlang_deps(deps_path) do
    #IO.puts(Mix.Project.config)
    {:ok, deps} = File.ls(deps_path)

    deps |> Enum.map(fn dep ->
        {:ok, dep_files} = File.ls("#{deps_path}/#{dep}/src")
        dep_files |> Enum.map(fn dep_file ->
          IO.puts(deps_file)
          Mix.Compilers.Erlang.compile()
        end)
    end)

  end
end
