-module(lists1).
-export([mini/1, maxi/1, min_max/1]).

% Min
mini([]) -> none;
mini([H|T]) -> mini(H, T).
mini(Min, []) -> Min;
mini(Min, [H|T]) when Min > H -> mini(H, T);
mini(Min, [_|T]) -> mini(Min, T).

% Max
maxi([]) -> none;
maxi([H|T]) -> maxi(H, T).
maxi(Max, []) -> Max;
maxi(Max, [H|T]) when Max < H -> maxi(H, T);
maxi(Max, [_|T]) -> maxi(Max, T).

% MinMax
min_max(L) -> {mini(L), maxi(L)}.
