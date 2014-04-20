%%%-------------------------------------------------------------------
%%% @author foobar
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%% A= start, B= end, hd(A) = X, tl(A) = Y
%%% @end
%%% Created : 20. Apr 2014 01:42
%%%-------------------------------------------------------------------
-module(rules).
-author("foobar").

%% API
-export([
  safe_divide/2, slope/2, line_formula/2,
  in_range/3, in_range/1
]).
-record(minmax, {min = 0, max = 8}).

safe_divide(A, B) when B == 0 -> % vertical case
  -999;

safe_divide(A, B) ->
  A / B.

slope(A, B) ->
  X = element(1, A) - element(1, B),
  Y = element(2, A) - element(2, B),
  safe_divide(X, Y).

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
  X = element(1, A) - element(1, B),
  Y = element(2, A) - element(2, B),
  safe_divide({X, abs(X)}, {Y, abs(Y)}).

in_range(N, Min, Max) when is_integer(N) ->
  (N >= Min) and (N < Max);

in_range(A, Min, Max) ->
  X = element(1, A),
  Y = element(2, A),
  H=in_range(X, Min, Max),
  T=in_range(Y, Min, Max),
  H and T.

in_range(A) ->
  MinMax = #minmax{},
  in_range(A, MinMax#minmax.min, MinMax#minmax.max).
