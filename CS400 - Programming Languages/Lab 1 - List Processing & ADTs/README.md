# CSCI-400 Lab #1 (Individual Lab)

## Setting up the Repository
- **READ THIS FIRST!!**
- **DO NOT CLONE THIS REPO!!!**
- This README and accompanying skeleton code are contained in
  the read-only *assignment* repository --
  you will be able to pull from here, but not push.
- To get started on the assignment, first go to your
  *personal/team* repository for this assignment, and
  carefully follow the `INSTRUCTIONS.md` file there.
- The basic idea is: you will first clone your personal/team
  repository (NOT this assignment repo), and then add a (read only) remote to pull
  the skeleton code from this assignment repository.

## Basic Instructions

- Typing `make` should build your code.
- Typing `make lab1` should build your Lab #1 code, and run its unit tests.
- Each unit test is a tuple of the form `(optional_name, input, expected_output)`,
  where `optional_name` can either be `None` or `Some(x)`, where `x` is a
  human-readable name for the unit test.

## Summary

Your goal in this lab will be to add OCaml code to complete the functionality
described in `lab1.ml`.
Skeleton code is provided, and you will need to fill in the body of several
functions. Each location where you need to replace a placeholder expression
with your own code is marked with a `TODO` comment.

## Task 1

In this part of the lab, we will revisit the list-processing functions
discussed in class. The functional programming paradigm makes heavy use of
these (higher-order) functions, such as `map` (for transforming a list into
a new list), `reduce` (for performing a computation over the list), etc.

In later labs, we will use OCaml's built-in versions of these functions,
but for now, we will consider how to *implement* these functions on our own,
using nothing but the simple functional language (subset of OCaml)
discussed in class. The two key ingredients we need are
*recursive higher-order functions* and *pattern matching*.

- Edit `lab1.ml` at the locations indicated by `TODO` comments, and
  complete the list functions as described in the comments.
- Add at least 5 new *non-trivial* unit tests per function.

## Task 2

In this part of the lab, we will revisit our discussion of algebraic data
types (ADTs) and using these to encode binary trees. We will write some
functions that apply to *arbitrary* binary trees, and we will then turn
our attention to *binary search trees*, a special form of binary trees.

Binary search trees are binary trees which satisfy a key property:
**for any node, all elements in its left subtree are less than that node,
and all elements of its right subtree are greater than that node**
(note that in this case, we do not allow duplicate values to be stored
in the binary search tree). As its name implies, binary search trees are
good for fast lookups (we can get log(n) performance if the tree is
properly balanced).

In this part of the lab, you will write functions to manipulate
binary search trees.

- Edit `lab1.ml` at the locations indicated by `TODO` comments, and
  complete the tree functions as described in the comments.
- Add at least 5 new *non-trivial* unit tests per function.
