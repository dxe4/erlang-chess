%%%-------------------------------------------------------------------
%%% @author foobar
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%% A= start, B= end
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
-define(MinMax, #minmax{}).

diff(A, B, elm) ->
  case elm of
    x -> element(1, A) - element(1, B);
    y -> element(2, A) - element(2, B);
    xy -> {diff(A, B, x), diff(A, B, y)}
  end.

safe_divide(A, B) when B == 0 -> % vertical case
  -999;

safe_divide(A, B) ->
  A / B.

slope(A, B) ->
  {X, Y} = diff(A, B, xy),
  safe_divide(X, Y).

line_formula(A, B) ->
  Slope = slope(A, B),
  {B_X, B_Y} = B,
  case Slope == -999 of
    true -> {vertical,
      fun(StartX) -> StartX == element(1, B) end};
    false -> {horizontal,
      fun(X, Y) -> Y - B_Y == Slope * (X - B_X) end}
  end.

% {Type, Func} = line_formula(5,5)

diff_points(A, B) ->
  {X, Y} = diff(A, B, xy),
  {safe_divide(X, abs(X)),
    safe_divide(Y, abs(Y))}.

in_range(N, Min, Max) when is_integer(N) ->
  (N >= Min) and (N < Max);

in_range(A, Min, Max) ->
  {X, Y} = A,
  H = in_range(X, Min, Max),
  T = in_range(Y, Min, Max),
  H and T.

in_range(A) ->
  in_range(A, ?MinMax#minmax.min, ?MinMax#minmax.max).

end_point_check(DiffY) ->
  case DiffY == -1 of
    true -> fun(Move, End) -> Move =< End end;
    false -> fun(Move, End) -> Move >= End end
  end.