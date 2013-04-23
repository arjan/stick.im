
-module(m_stickim).

-behaviour(gen_model).

%% interface functions
-export([
         m_find_value/3,
         m_to_list/2,
         m_value/2,
         
         get/2,
         insert/3
]).

-include_lib("zotonic.hrl").

%% @doc Fetch the value for the key from a model source
%% @spec m_find_value(Key, Source, Context) -> term()
m_find_value(Id, #m{value=undefined}, Context) ->
    {ok, S} = get(Id, Context),
    S.

%% @doc Transform a m_config value to a list, used for template loops
%% @spec m_to_list(Source, Context) -> List
m_to_list(#m{value=undefined}, _Context) ->
    undefined.

%% @doc Transform a model value so that it can be formatted or piped through filters
%% @spec m_value(Source, Context) -> term()
m_value(#m{value=undefined}, _Context) ->
    undefined.


get(Id, Context) ->
    F = fun() ->
                case z_db:select(stickim, Id, Context) of
                    {ok, []} -> {error, notfound};
                    {ok, R} -> {ok, R}
                end
        end,
    z_depcache:memo(F, {stickim, Id}, 3600, Context).
                                 
insert(Id, Props, Context) ->
    {ok, _} = z_db:insert(stickim, [{id, Id}|Props], Context),
    z_depcache:flush({stickim, Id}, Context),
    ok.
