-module(time).
-export([swedish_date/0]).

swedish_date() ->
    {Y, M, D} = date(),
    integer_to_list(Y) ++ integer_to_list(M) ++ integer_to_list(D).
