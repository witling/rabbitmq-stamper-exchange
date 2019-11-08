# rabbitmq-stamper-exchange

> **NOT WORKING!!!** Erlang does not allow modification of function parameters, yet this would be required for such a plugin. A hack around this could be manually deep-routing the message, but the initial caller wouldn't get a success notification this way.

A RabbitMQ exchange type that adds custom header attributes to each message that passes it.

## Installation

Put the release archive into the RabbitMQ plugins folder (see [default environment variables (https://www.rabbitmq.com/configure.html#supported-environment-variables)) and issue:

``` bash
rabbitmq-plugins enable rabbitmq_stamper_exchange
rabbitmq-service stop
rabbitmq-service start
```

## Development

Make sure you have the following dependencies installed:

```
git
```

### Linux

``` bash
git clone https://github.com/witling/rabbitmq-stamper-exchange
mix build
```

### Windows

Well, [good luck](https://erlang.mk/guide/installation.html#_on_windows)...
