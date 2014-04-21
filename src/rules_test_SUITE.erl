-module(rules_test_SUITE).
-include_lib("eunit/include/eunit.hrl").

in_range_a_test() -> 
	?assertEqual(true, rules:in_range({0, 0})),
	?assertEqual(true, rules:in_range({1, 1})),
	?assertEqual(true, rules:in_range({2, 7})),
	?assertEqual(true, rules:in_range({3, 6})),
	?assertEqual(true, rules:in_range({4, 5})),
	?assertEqual(true, rules:in_range({5, 4})),
	?assertEqual(true, rules:in_range({6, 3})),
	?assertEqual(true, rules:in_range({7, 2})).


in_range_b_test() -> 
	?assertEqual(true, rules:in_range({0, 9}, 0 , 10)),
	?assertEqual(true, rules:in_range({1, 1}, 0, 2)),
	?assertEqual(true, rules:in_range({2, 7}, 1, 8)),
	?assertEqual(true, rules:in_range({3, 6}, 2, 7)),
	?assertEqual(true, rules:in_range({4, 5}, 3, 6)),
	?assertEqual(true, rules:in_range({5, 4}, 3, 6)).


not_in_range_a_test() -> 
	?assertEqual(false, rules:in_range({0, 8})),
	?assertEqual(false, rules:in_range({1, 9})),
	?assertEqual(false, rules:in_range({2, 10})),
	?assertEqual(false, rules:in_range({8, 6})),
	?assertEqual(false, rules:in_range({9, 5})),
	?assertEqual(false, rules:in_range({10, 4})),
	?assertEqual(false, rules:in_range({8, 8})),
	?assertEqual(false, rules:in_range({-10, 4})),
	?assertEqual(false, rules:in_range({-8, 8})),
	?assertEqual(false, rules:in_range({7, 9})).



not_in_range_b_test() -> 
	?assertEqual(false, rules:in_range({0, 10}, 0 , 10)),
	?assertEqual(false, rules:in_range({1, 1}, 2, 2)),
	?assertEqual(false, rules:in_range({2, 8}, 1, 8)),
	?assertEqual(false, rules:in_range({1, 6}, 2, 7)),
	?assertEqual(false, rules:in_range({4, 7}, 3, 6)),
	?assertEqual(false, rules:in_range({1, 4}, 3, 6)).