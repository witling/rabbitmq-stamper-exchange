-module(rabbit_stamper_mgmt).

-behaviour(rabbit_mgmt_extension).

-export([dispatcher/0, web_ui/0]).

dispatcher() -> [{"/stamper",                         rabbit_stamper_wm, []},
                 {"/stamper/:vhost",                  rabbit_stamper_wm, []}
		].

web_ui()     -> [{javascript, <<"stamper.js">>}].
