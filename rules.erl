%%%-------------------------------------------------------------------
%%% @author foobar
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Apr 2014 01:42
%%%-------------------------------------------------------------------
-module(rules).
-author("foobar").

%% API
-export([safe_divide/2, slope/2, line_formula/2]).

safe_divide(A, B) when B == 0 -> % vertical case
  -999;

safe_divide(A, B) ->
  A / B.

slope(A, B) ->
  StartY = element(2, A) - element(2, B),
  StartX = element(1, A) - element(1, B),
  safe_divide(StartX, StartY).

line_formula(A, B) ->
  Slope = slope(A, B),
  case Slope == -999 of
    true -> {vertical, fun(StartX) ->
      StartX == element(1, B) end};
    false -> {horizontal, fun(X, Y) ->
      Y - element(2, B) == Slope * (X - element(1, B)) end}
  end.

% {Type, Func} = line_formula(5,5)

diff_points(A, B) ->
  X = element(0, A) - element(0, B),
  Y = element(1, A) - element(1, B),
  safe_divide({X, abs(X)}, {Y, abs(Y)}).