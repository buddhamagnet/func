-module(functions).
-compile(export_all).

head([Head|_]) -> Head.

second([_,Second,_]) -> Second.

valid_time({Date = {Y,M,D}, Time={H,Min,S}}) ->
  io:format("Date tuple (~p) says today is ~p/~p/~p~n", [Date,Y,M,D]),
  io:format("Time tuple (~p) says time is ~p:~p:~p~n", [Time,H,Min,S]);

valid_time(_) ->
  io:format("bad data!~n").