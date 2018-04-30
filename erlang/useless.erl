-module(useless).

%%% useless module.

-export([add/2, hello/0, mode/0, greet_and_add/1]).
-define(MODE, "decimate").

add(A,B) ->
  A + B.

%% proceed to decimate.
%% io:format/1 is the standard print function.
hello() ->
  io:format("decimate!~n").

mode() ->
  io:format(?MODE).

greet_and_add(X) ->
  hello(),
  add(X, 2).