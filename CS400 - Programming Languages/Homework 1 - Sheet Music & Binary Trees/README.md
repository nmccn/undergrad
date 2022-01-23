# CSCI-400 Homework #2

## Basic Instructions

- Typing `make` should build your code.
- Typing `make hw02` should build your Homework #2 code, and run its unit tests.
- Each unit test is a tuple of the form `(optional_name, input, expected_output)`,
  where `optional_name` can either be `None` or `Some(x)`, where `x` is a
  human-readable name for the unit test.

## Task 1

- Add at least 5 new test cases for the function `get_duration` in `homework02.ml`
  (your test cases should be added to the `sheet_music_tests` list).

## Task 2

- Add functions `traverse2_pre` and `traverse2_post` (similar to `traverse2`) in `homework02.ml`
  which perform pre-order and post-order traversal of a list respectively (returning the new list).
- Add at least 5 test cases for each of your functions in `homework02.ml` (your tests should
  be added to the `tree_tests_pre` and `tree_tests_post` lists respectively).

## Task 3

- In `homework02.ml`, implement a recursive function `(sum n)` which produces
  the result `2 + 4 + 8 + ...` for the first *n* powers of 2 (where *n* is a non-negative integer).
  Do not use OCaml's built-in power function.
- In `homework02.ml`, add at least 5 tests cases for your `sum` function (your test cases
  should be added to the `sum_tests` list).
