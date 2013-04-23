%% @author Arjan Scherpenisse
%% @copyright 2013 Arjan Scherpenisse
%% Generated on 2013-04-23
%% @doc This site was based on the 'empty' skeleton.

%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(stickim).
-author("Arjan Scherpenisse").

-mod_title("stickim zotonic site").
-mod_description("An empty Zotonic site, to base your site on.").
-mod_prio(10).
-mod_schema(1).

-include_lib("zotonic.hrl").

-export([manage_schema/2,
         event/2,
         file_exists/2,
         file_forbidden/2
        ]).

%%====================================================================
%% support functions go here
%%====================================================================

manage_schema(install, Context) ->
    case z_db:table_exists(stickim, Context) of
        false ->
            z_db:create_table(
              stickim,
              [
               #column_def{name=id, type="character varying", length=128, is_nullable=false},
               #column_def{name=path, type="character varying", length=128, is_nullable=true},
               #column_def{name=ip, type="character varying", length=64, is_nullable=true},
               #column_def{name=ua, type="character varying", length=255, is_nullable=true},
               #column_def{name=props, type="bytea", is_nullable=true},
               #column_def{name=updated, type="timestamp", is_nullable=true},
               #column_def{name=created, type="timestamp", is_nullable=true}
              ], Context),

            z_db:equery("alter table stickim add primary key (id)", Context),
            z_db:equery("create unique index stickim_path on stickim(path)", Context);
        true ->
            nop
    end,
    ok.


event(#submit{message={upload, _Args}}, Context) ->

    %% Decode data and write to disk
    
    "data:image/png;base64," ++ Base64Data = z_context:get_q_validated("imgdata", Context),
    [FirstChar|_] = Id = make_id(Context),
    Path = [FirstChar] ++ "/" ++ Id ++ ".png",
    Dir = z_path:files_subdir_ensure("stickim/" ++ [FirstChar], Context),
    TargetFile = filename:join(Dir, Id ++ ".png"),
    file:write_file(TargetFile, base64:mime_decode(Base64Data)),

    {Peer, _} = webmachine_request:get_peer(z_context:get_reqdata(Context)),
    {ok, ParsedPeer} = inet_parse:address(Peer),
    Ip = inet_parse:ntoa(ParsedPeer),

    UA = wrq:get_req_header_lc("user-agent", z_context:get_reqdata(Context)),
    
    %% Save to database
    
    Title = z_html:escape(z_context:get_q("title", Context)),
    Theme = z_html:escape(z_context:get_q("theme", Context)),
    
    ok = m_stickim:insert(Id,
                          [
                           {path, Path},
                           {title, Title},
                           {theme, Theme},
                           {ip, Ip},
                           {ua, UA},
                           {created, calendar:local_time()},
                           {updated, calendar:local_time()}
                          ],
                          Context),
    %% Go to there
    z_render:wire([{redirect, [{dispatch, stickim}, {id, Id}]}], Context).


file_exists(F, Context) ->
    Abs = filename:join(z_path:files_subdir("stickim", Context), F),
    case filelib:is_regular(Abs) of
        true -> {true, Abs};
        false -> false
    end.

file_forbidden(_, _) ->
    false.


make_id(Context) ->
    make_id(z_ids:id(), 3, Context).

make_id(Str, Len, Context) when Len >= length(Str) ->
    make_id(Context);

make_id(Src, Len, Context) ->
    Id = lists:sublist(Src, Len),
    case m_stickim:get(Id, Context) of
        {error, notfound} ->
            Id;
        {ok, _} ->
            make_id(Src, Len+1, Context)
    end.
