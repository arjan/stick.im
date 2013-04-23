
-module(controller_stickim).

-export([
    resource_exists/2,
    html/1
]).

-include_lib("controller_html_helper.hrl").

%% @doc Check if the id in the request (or dispatch conf) exists.
resource_exists(ReqData, Context) ->
    Context1  = ?WM_REQ(ReqData, Context),
    ContextQs = z_context:ensure_qs(Context1),
    try
        Id = z_context:get_q("id", ContextQs),
        case m_stickim:get(Id, ContextQs) of
            {ok, _} ->
                ?WM_REPLY(true, ContextQs);
            {error, notfound} ->
                ?WM_REPLY(false, ContextQs)
        end
    catch
        _:_ -> ?WM_REPLY(false, ContextQs)
    end.

%% @doc Show the page.  Add a noindex header when requested by the editor.
html(Context) ->
    Id = z_context:get_q("id", Context),
    {ok, Stickim} = m_stickim:get(Id, Context),
	RenderArgs = [{s, Stickim} |  z_context:get_all(Context)],
    Template = z_context:get(template, Context, "stickim.tpl"),
    Html = z_template:render(Template, RenderArgs, Context),
	z_context:output(Html, Context).
