-module(temp).
-export([convert/1]).

convert({c, C}) -> {f, c2f(C)};
convert({f, F}) -> {c, f2c(F)}.

% Fahrenheit to Centrigrad
f2c(F) -> round((5 * (F - 32)) / 9).
% Centrigrad to Fahrenheit
c2f(C) -> round((C * 9) / 5) + 32.
