-module(processes).
-export([two_processes/2, two_processes_function/1]).

% Start two processes and sends M times a message, forward and backward between them
two_processes(M, Message) ->
    First = spawn(?MODULE, two_processes_function, [M]),
    Second = spawn(?MODULE, two_processes_function, [M]),
    First ! {Second, Message},
    ok.

two_processes_function(0) ->
    io:format("Terminating process~n");
two_processes_function(Count) ->
    receive
	{From, Msg} ->
	    io:format("Received message ~p~n", [Msg]),
	    From ! {self(), Msg}
    end,
    two_processes_function(Count - 1).
