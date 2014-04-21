-module(rules_test_SUITE).
-include_lib("eunit/include/eunit.hrl").

in_range_test() -> 
	?assertEqual(true, rules:in_range({5, 5})).
