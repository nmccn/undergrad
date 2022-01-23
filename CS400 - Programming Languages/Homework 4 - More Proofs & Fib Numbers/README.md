# CSCI-400 Homework #5

## Setting up the Repository
- **READ THIS FIRST!!**
- **DO NOT CLONE THIS REPO!!!**
- This README and accompanying files are contained in
  the read-only *assignment* repository --
  you will be able to pull from here, but not push.
- To get started on the assignment, first go to your
  *personal/team* repository for this assignment, and
  carefully follow the `INSTRUCTIONS.md` file there.
- The basic idea is: you will first clone your personal/team
  repository (**not** this assignment repo), and then add a
  (read only) remote to pull
  the skeleton code from this assignment repository.

## Basic Instructions

- Complete each of the following Tasks.
- Submit your answers in one of the following
  formats: Markdown (`answers.md`),
  text (`answers.txt`), or LaTeX+PDF
  (`answers.tex` and `answers.pdf`).
- Note that if you choose to use LaTeX, you
  **must** submit both the TeX source `answers.tex`
  and the generated PDF `answers.pdf`.
- If you submit your solution as `answer.md`,
  one option is to use the [CodeCogs equation editor](https://www.codecogs.com/latex/eqneditor.php)
  to make nicely-formatted images such as the one below
  for any needed mathematical notation.

## Rubric

- The total score is out of 100 points.
- Please make your answers clear and concise.

| Item                                        | Points |
|---------------------------------------------|--------|
| Task 1: Big-step semantics                  | 30     |
| Task 2: Using `program_t` ADT, part I       | 20     |
| Task 3: Writing functions in JavaScript     | 30     |
| Task 4: Using `program_t` ADT, part II      | 20     |

## Task 1

In lecture, we introduced big-step operational semantics for our simple
subset of JavaScript, and we saw how to use the semantics to show that
the JavaScript expression `1 + 2 + 3` evaluates to the value `6`.

<img alt="\frac{\frac{\frac{.}{E \vdash 1 \Downarrow 1}EvalVal \quad\quad \frac{.}{E \vdash 2 \Downarrow 2}EvalVal \quad\quad 3 = 1+2}{E \vdash (1+2) \Downarrow 3}EvalArith \quad\quad \frac{.}{E \vdash 3 \Downarrow 3}EvalVal \quad\quad 6 = 3+3}{E \vdash (1+2)+3 \Downarrow 6} EvalArith" src="https://latex.codecogs.com/png.latex?%5Cdpi%7B150%7D%20%5Cbg_white%20%5Cfrac%7B%5Cfrac%7B%5Cfrac%7B.%7D%7BE%20%5Cvdash%201%20%5CDownarrow%201%7DEvalVal%20%5Cquad%5Cquad%20%5Cfrac%7B.%7D%7BE%20%5Cvdash%202%20%5CDownarrow%202%7DEvalVal%20%5Cquad%5Cquad%203%20%3D%201&plus;2%7D%7BE%20%5Cvdash%20%281&plus;2%29%20%5CDownarrow%203%7DEvalArith%20%5Cquad%5Cquad%20%5Cfrac%7B.%7D%7BE%20%5Cvdash%203%20%5CDownarrow%203%7DEvalVal%20%5Cquad%5Cquad%206%20%3D%203&plus;3%7D%7BE%20%5Cvdash%20%281&plus;2%29&plus;3%20%5CDownarrow%206%7D%20EvalArith" width="971" />

Your task: use our big-step operational semantics to show that the
JavaScript expression `const x = 1 + 2; x + 3`
also evaluates to the value `6`.

## Task 2

Consider the Lab 3 JavaScript subset, with added support for
*recursive functions*:

- **program** *p* ::= *e* | `const` *x* `=` *e* `;` *p*

- **block** *bl* ::= `return` *e* | `const` *x* `=` *e* `;` *bl*

- **expression** *e* ::= *x* | *v* | *uop* *e* | *e* *bop* *e*
                | *e* `?` *e* `:` *e* | `console.log` `(` *e* `)` | *e* `(` *e* `)`

- **value** *v* ::= *n* | *b* | *s* | `undefined` | `function` *x* `(` *x* `)` `{` *bl* `}`

- **unary operator** *uop* ::= `-` | `!`

- **binary operator** *bop* ::= `+` | `-` | `*` | `/` | `===` | `!==` | `<` | `<=` | `>` | `>=` | `&&` | `||`

- **identifier** *x*

- **number (float)** *n*

- **boolean** *b* ::= `true` | `false`

- **string** *s*

We can write the following recursive function (and subsequent
function call) in the above subset of JavaScript:

```
// computes 6 + 5 + 4 + 3 + 2 + 1 + 0 = 21
(function dec(x) {
    return x > 0 ? x + dec(x-1) : 0
})(6)
```

Your task is to use the `program_t` data type
defined in `javascript_ast.ml`
to properly encode the above JavaScript expression.
Your code should be added to the end of `javascript_ast.ml`,
at the location marked by a `TODO` comment.

To check your work, do:
```
make run_ast
```
(equivalently, `ocaml str.cma javascript_ast.ml`),
and ensure that the pretty-printed output matches what
you expect.

## Task 3

Using the above recursive JavaScript function as a basic guide,
write a recursive JavaScript function (and subsequent function
call) to compute the 30th Fibonacci number. Your JavaScript
code is limited to the above subset of JavaScript.
Add your JavaScript code to the `fib.js` file.

You can test your code by doing
```
make run_fib
```
(equivalently, `nodejs fib.js`), and checking that the
output matches what you expect.

## Task 4

Encode your Task 3 JavaScript code using the `program_t`
data type.
Your code should be added at the appropriate location
marked with a `TODO` comment in `javascript_ast.ml`.

You can check your work using the same approach listed
in Task 2.
