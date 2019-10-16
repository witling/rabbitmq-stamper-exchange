-module(rabbit_exchange_type_stamper).

-rabbit_boot_step(
   {?MODULE,
    [{description, "exchange type stamper: registry"},
     {mfa,         {rabbit_registry, register,
                    [exchange, <<"stamper">>, ?MODULE]}},
     {cleanup, {rabbit_registry, unregister,
                [exchange, <<"stamper">>]}},
     {requires,    rabbit_registry},
     {enables,     recovery}]}).

-include_lib("rabbit_common/include/rabbit.hrl").
-include_lib("rabbit_common/include/rabbit_framing.hrl").

-behaviour(rabbit_exchange_type).

-import(rabbit_misc, [table_lookup/2]).
%-import(rabbit_delayed_message_utils, [get_delay/1]).

-export([description/0, serialise_events/0, route/2]).
-export([validate/1, validate_binding/2,
         create/2, delete/3, policy_changed/2,
         add_binding/3, remove_bindings/3, assert_args_equivalence/2]).
-export([info/1, info/2]).

%-define(EXCHANGE(Ex), (exchange_module(Ex))).

description() ->
    [{name, <<"stamper">>},
     {description, <<"Stamper Exchange.">>}].

info(_X) -> [].
info(_X, _) -> [].

serialise_events() -> false.

route(#exchange{name = Name}, _Delivery) ->
    rabbit_router:match_routing_key(Name, ['_']).

validate(_X) -> ok.
validate_binding(_X, _B) -> ok.
create(_Tx, _X) -> ok.
delete(_Tx, _X, _Bs) -> ok.
policy_changed(_X1, _X2) -> ok.
add_binding(_Tx, _X, _B) -> ok.
remove_bindings(_Tx, _X, _Bs) -> ok.
assert_args_equivalence(X, Args) ->
    rabbit_exchange:assert_args_equivalence(X, Args).
