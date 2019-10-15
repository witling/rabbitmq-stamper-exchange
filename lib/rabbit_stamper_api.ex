defmodule RabbitStamperApi do
    def init(Req, _State) do

    end

    def content_types_provided(ReqData, Context) do
        {[{<<"application/json">>, to_json}], ReqData, Context}
    end

    def to_json(ReqData, Context) do
        :rabbit_mgmt_util:reply([], ReqData, Context)
    end

    def is_authorized(ReqData, Context) do
        :rabbit_mgmt_util:is_authorized_admin(ReqData, Context)
    end
end