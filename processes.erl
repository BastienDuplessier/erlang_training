-module(processes).
-export([two_processes/2, two_processes_function/1, ring_processes/3, ring_processes_function/1, ring_processes_function/2]).

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


% Starts N processes in a ring, send message M times around all processes in the ring
ring_processes(N, M, Msg) ->
    % Create processes
    Process = spawn(?MODULE, ring_processes_function, [M]),
    io:format("Created : process ~p.~n", [Process]),
    Process ! {suiv, ring_processes(N-1, {M, Process})},
    Process ! {self(), Msg}.
ring_processes(0, {_, Suiv}) -> Suiv;
ring_processes(N, {M, Suiv}) ->
    Process = spawn(?MODULE, ring_processes_function, [M, Suiv]),
    io:format("Created : process ~p.~n", [Process]),
    ring_processes(N-1, {M, Process}).

ring_processes_function(N) ->
    receive
	{suiv, Suiv} -> ring_processes_function(N, Suiv)
    end.
ring_processes_function(0, _) -> io:format("Terminating process for ~p.~n", [self()]);
ring_processes_function(N, Suiv) ->
    receive
	{From, Msg} ->
	    io:format("Received message ~p from ~p in process ~p.~n", [Msg, From, self()]),
	    Suiv ! {self(), Msg}
    end,
    ring_processes_function(N - 1, Suiv).
