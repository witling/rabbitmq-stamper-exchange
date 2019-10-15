defmodule RabbitExchangeTypeStamper do
  @moduledoc """
  Documentation for RabbitExchangeTypeStamper.
  """

  # make @rabbit_boot_step behave more like an erlang attribute
  Module.register_attribute __MODULE__,
    :rabbit_boot_step,
    accumulate: true, persist: true

  @rabbit_boot_step [__MODULE__, [
    {:description, "exchange type stamper"},
    {:mfa,         {:rabbit_registry, :register,
                    [:exchange, "stamper", __MODULE__]}},
    {:requires,     :rabbit_registry},
    {:enables,      :kernel_ready}
  ]]

  @behaviour :rabbit_exchange_type
  @behaviour :rabbit_mgmt_extension

  @impl :rabbit_exchange_type
  def description do
    [{:description, "the stamper exchange"}]
  end

  @impl :rabbit_mgmt_extension
  def dispatcher do
    [{"/stamper", :rabbit_stamper_api, []}]
  end

  @impl :rabbit_mgmt_extension
  def web_ui do
    [{:javascript, "stamper.js"}]
  end
  
  def route(exchange, delivery) do
    []
  end

  def info(_) do
    []
  end

  def info(_, _) do
    []
  end

  def serialise_events do
    false
  end

  def validate(_) do
    :ok
  end

  def validate_binding(_, _) do
    :ok
  end

  def create(_, _) do
    :ok
  end

  def delete(_, _, _) do
    :ok
  end

  def policy_changed(_, _) do
    :ok
  end

  def add_binding(_, _, _) do
    :ok
  end

  def remove_binding(_, _, _) do
    :ok
  end

  def assert_args_equivalence(x, args) do
    :rabbit_exchange.assert_args_equivalence(x, args)
  end

end