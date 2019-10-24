# rabbitmq-stamper-exchange

**NOT WORKING!!!** A RabbitMQ exchange type that adds custom header attributes to each message that passes it.

## Installation

Put the release archive aswell as a version of elixir into the RabbitMQ plugins folder (see [default environment variables](https://www.rabbitmq.com/configure.html#supported-environment-variables)) and issue:

``` bash
rabbitmq-plugins enable rabbitmq_stamper_exchange
rabbitmq-service stop
rabbitmq-service start
```

## Development

Make sure you have the following dependencies installed:

```
git elixir
```

### Linux

``` bash
git clone https://github.com/witling/rabbitmq-stamper-exchange
mix build
```

### Windows

Well, [good luck](https://erlang.mk/guide/installation.html#_on_windows)...
