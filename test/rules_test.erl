-module(rules_test).
-include_lib("eunit/include/eunit.hrl").

in_range_test_() -> ?assertEqual(true, rules:in_range({5, 5})).
