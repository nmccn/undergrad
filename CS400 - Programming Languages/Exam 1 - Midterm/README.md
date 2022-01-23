# CSCI-400 Exam 1

## Setting up the Repository

- **READ THIS FIRST!!**
- **DO NOT CLONE THIS REPO!!!**
- This README is contained in a read-only instructor repository --
  you will be able to pull from here, but not push.
- To get started on the exam, first go to your
  *personal* repository for the exam, and
  carefully follow the `INSTRUCTIONS.md` file there.
- The basic idea is: you will first clone your personal
  repository (**not** this instructor repo), and then add a (read only)
  remote to pull the exam README from this instructor repository.

## Instructions

- This is a take-home exam.
- There will be no lecture on the exam date.
- Just like an in-class exam, the Midterm is designed to take a maximum of 75 minutes
  (one class period) to complete.
- The exam will be posted to GitHub by 8:00am Mountain Time on the exam date.
- You will have 24 hours to complete the exam -- the deadline for submission is 8:00am
  Mountain Time on the day following the exam date.
- The exam is open-book, open-notes. You may use an internet search engine, but
  you should *not* find a need for this, and doing so may hurt your exam performance
  (the internet abounds with wrong answers to a wide variety of questions).
- You should insert your answers into the indicated places in the exam text file,
  commit, and push to GitHub. You can push as many times as needed, up until the
  deadline. We will gather your completed exam for grading by cloning your personal
  repository after the deadline.
- Do not add any additional files. Do not add any content except for text in the
  exam file. Do not remove any of the existing content in the text file.
- You are responsible for ensuring that your completed exam has been pushed to GitHub
  properly! You can easily do this by logging into GitHub and confirming that you see
  the correct file contents there.

## Honor Pledge

You must type your name below, to indicate that you agree to the following statements.
Failure to agree to the following conditions will equate to a grade of zero on the exam.
1. "I will not discuss this exam with anyone else until after the submission deadline, and
   I will not obtain/share answers from/with anyone else."
2. "I understand that all submitted exams will be scanned by plagiarism detection software,
   just like other class assignments."
3. "I understand that if I am found to have plagiarised any content on this exam, I will
   receive the maximum possible penalty available to the instructors."

Type your name: Nicholas McClellan


## Part 1 -- Functional Programming (17 points)

- **Question 1**: What are three key differences between functional programming and
  imperative programming?
- **Answer**: Three differences between functional programming and imperative programming are the following:
              1. Loop structures of imperative programming are replaced by recursion in functional programming. 
              2. Functions in functional programming are treated as values, I do not believe this is the case (generally) in imperative programming. 
              3. I think that functional programming is mostly immutable, such that a variable binds to a single value, but in imperative programming these variables may be redfined. 


- **Question 2**: Describe one key advantage, and one key disadvantage of functional
  programming, versus imperative programming.
- **Answer**: A key advantage of functional program is that it may be easier to validate, such that it can be easier to prove that the code will behave in a 'proper' way for a given input. A key disadvantage of functional programming would be the required use of recursion, as it may not be as intuitive as something like imperative programming in terms of loop structures and things like that. 
      If key here means something that is objectively true, I suppose the disadvantage would be that recursion may be more computationally expensive if done incorrectly/not optimally. 


- **Question 3**: When writing a functional program (say, in OCaml), how does one
  ensure that no stack overflow will occur?
- **Answer**: - I think in general a few things can be done to ensure no stack overflow will occur. I think that OCaml, and other statically typed languages, combat that atleast a little bit with typechecking before runtime. However, the individual programmer can also ensure no stack overflow by avoiding circular recursion and maybe including catch all cases where necessary. 


- **Question 4**: Describe how to do list reversal in a functional style. Do not
  simply paste code -- you must describe each step of your approach.
- **Answer**: I will provide a code snippet and outline what each line does
        let rec reverse = fun l -> match l with     # recursive function called reverse that operate on a list, l. 
          | [] -> l                                 # empty list reversed is simply empty list
          | [_] -> l                                # similarly, list of 1 element reversed is just single elemenet.
          | a::more -> reverse(more) @ [a]         
          # For list length > 1, we take off the first letter, denoted here 'a'. we recursively call reverse on the remainder of the list, and attach a to the end of the result. 



## Part 2 -- The OCaml Programming Language (17 points)

- **Question 5**: Describe what the following OCaml expression means: `(f g)`.
- **Answer**: As far as I know, this could be read as something like, the function f applied to g. 


- **Question 6**: Consider the following OCaml expression, where `...` represents an
  unknown expression:
  `let f = ... in let g = 123 in (f g)+1`.
  What is the *type* of `f`?
  Also, what is the *type* of `(f g)`? Explain your answers.
- **Answer**: I think the type of everything here is uniform, such that everything would be an integer. The reasoning behind my answer is pretty simple, we are given g = 123, which is certainly an int. Further, (f g) + 1 involves another integer operation. I think this is due to the fact that in OCaml functions are just values, which can be typed, but I am not certain on this. Also, being statically typed may play a role in this behavior. 


- **Question 7**: Recall that in the assignments, we have written function definitions
  using the form: `fun x -> e`. Using this single-argument function format, how can
  we pass multiple items into the function?
- **Answer**: Again, slightly thrown off by the question. Most simply, a tuple could be used such as 'fun (x,y) -> e', but I am not certain that is what is being asked. 


- **Question 8**: How does OCaml's approach to typechecking differ from that of scripting
  languages such as JavaScript or Python?
- **Answer**: OCaml typechecks before runtime where languages like JavaScript or Python are typechecked at runtime. This is called statically typed. 


## Part 3 -- Algebraic Data Types (17 points)

- **Question 9**: What are three use-cases for algebraic data types (ADTs)?
- **Answer**: Three use-cases are the following:
              1. Enumeration for typing, such as:
                  type year = 1996 | 1997 | 1998 | 1999
              2. Allow for optional data type, none versus some, when making these structures (?). 
              3. Creation of more the data structures that programmers might be more familiar with, such as lists or trees. 


- **Question 10**: What is one major advantage of OCaml ADTs versus *classes* in Java or C++?
- **Answer**: An advantage to me would be the lack of memory management or pointers involved, and instead pattern matching. To implement thinks like linked lists or trees, there would need to be some kind of management by the programmer in a language like Java or C++, but in OCaml its actually a little bit easier. 


- **Question 11**: Recall the binary tree ADT seen in class. In an expression such
  as `Node(a, data, b)`, how does our program know that `a` is the *left* subtree, and
  `b` is the *right* subtree?
- **Answer**: I am a bit confused by the question, but as far as I know, we are just going by convention here. More specifically, we read the parameter from left to right as we would the tree, so there is no reason to change the order. I don't think it was explicitly stated to be left/right but more so that we built that convention, and can make sure that the properties of a binary tree hold for this convention. 


- **Question 12**: For the above expression `Node(a, data, b)`, describe how to *extract*
  the data from this node using OCaml.
- **Answer**: I am a bit confused by what exactly 'extract' means in this context. Is it simply printing to console the value of data, or are we doing that recursively? In general, to extract the data in OCaml you would develop some kind of pattern matching. Below is how I would implement, in pseudo code:
          let rec extract_data = fun n -> match n with
          | Empty -> print nothing
          | Node(a, data, b) -> print data


## Part 4 -- Syntax of Programming Languages (17 points)

- **Question 13**: What does *syntax* mean in the context of programming languages?
- **Answer**: In the context of programming languages, syntax is what 'valid' code looks like. In other words, the syntax of a language describes what different code 'structures' are allowed. Similar, but not quite the same as what we consider grammar.


- **Question 14**: Context-free grammars are used for describing languages. Can they
  be used to describe *any* language? Why or why not?
- **Answer**: No, context-free grammars cannot be used to describe all languages. I think this is because not all languages have a finite number of states, but the theory here goes a little beyond me to be frank. 


- **Question 15**: Consider the following grammar:
  - *sentence* ::= *subject* *verb* *object*
  - *subject*  ::= **I** | **you** | **Joan** | **John**
  - *verb*     ::= **ate** | **ran** | **typed** | **exhausted**
  - *object*   ::= **food** | **email** | **marathon**

  Is the following a valid sentence with respect to the grammar?
  If so, describe what its *derivation* would look like.
  `marathon exhausted John`
- **Answer**: No, this is not a valid sentence.


- **Question 16**: Is the following a valid sentence with respect to the above grammar?
  If so, describe what its *derivation* would look like.
  `I typed food`
- **Answer**: Yes, this is a valid sentence. I am a bit unsure of the exact format to write this 'derivation' but alas here it goes:
        *sentence* ->
        *subject* *verb* *object* ->
        I *verb* *object* ->
        I typed *object* ->
        I typed food


## Part 5 -- Lexing and Parsing (17 points)

- **Question 17**: What is the purpose of a lexer?
- **Answer**: The purpose of a lexer is to split up a sequence of characters into a corresponding sequence of tokens. These tokens are simply groupings of characters that match a sub-set of the 'grammar'. For example, using the grammar provided in Q19, '1 + 2 * 3' would be split into the tokens (1)(+)(2)(*)(3). 


- **Question 18**: What is the purpose of a parser?
- **Answer**: The purpose of the parser is to take the tokens created by the lexer and derive some meaning or an expression from them. The parser generates a tree to describe the series of tokens. There are different approaches on how to go about matching the tokens to the grammer, ie. bottom up or top down parsing, but in general they will just provide a definitive meaning to the string of tokens. 

For example, using the tokens from Q17, the resulting tree would denote that the result is not simply a left to right simplification, but more along the lines of [1 + (2*3)] or [(1+2) * 3].


- **Question 19**: Consider the following grammar:
  - *e* ::= *n* | *uop* *e* | *e* *bop* *e*
  - *uop* ::= `−`
  - *bop* ::= `+` | `−` | `∗` | `/`

  How many parse trees exist for the following expression,
  and why?
  `1 + 2 * 3`
- **Answer**: If I am understanding the question, there would be two 'valid' parse trees, such that the resulting expression would be evaluated as shown in Q18, [1 + (2*3)] or [(1+2) * 3]. 


- **Question 20**: What does it mean when there are more than one
  parse trees for some expression? Can we ensure that there is at most
  one parse tree for all input expressions? If so, how?
- **Answer**: Yes, we can ensure that there is at most one parse tree for all input expressions. Otherwise, inputing something like the above may produce different results at different times, 7 versus 9. To avoid such a scenario, ambiguities need to be resolved and there needs to be an order of precedence set by the implementation. I think in class the term used was 'determinize'. For example, chosing left/right recursion. 


## Part 6 -- Big-Step Operational Semantics (15 points)

- **Question 21**: What does *semantics* mean in the context of programming languages?
- **Answer**: In the context of programming languages, semantics is 'the meaning of the program'. More specifically, I think  this is more in line with what a block of code does or how a program behaves. 


- **Question 22**: What is the purpose of big-step operational semantics?
- **Answer**: In general, big-step operational semantics seek to explain how a program is executed in a single step. More specifically, big-step operational semantics uses the various mathematical represenations of expressions to prove/validate how more complex expressions would be evaluated. 

I think it would be more clear if I could draw an example, but I am trying to describe the proof trees we built to describe the validity of a program. 


- **Question 23**: According to our JavaScript operational semantics, what value is
  produced when we evaluate the expression `! ! 42`, and why?
- **Answer**: If I understand correctly, the provided expression would evaluate to 'true'. As to why, I think the expression would look something like !(!(42)). Further, the definition of expression e shows uop e or e bop e, and considering only 1 value, it matches with uop e, twice in fact. Therefore, we would consider something like !(!(toBool(42))), where toBool(n) where n>=1 will return true. !True =  False, and again !False = True. 


- **Question 24**: Describe how to use the operational semantics rules to show that
  `! ! 42` evaluates to the value you have written above.
- **Answer**: I kind of alluded to it in the previous answer, but I will try to explain more thoroughly here. Instead of breaking the expression into components and evaluating them according to known JS functionality, the use of operational semantics allows for the mathematical proof that (! ! 42) does indeed evaluate to True. In specific, a proof tree could be constructed using big-step operational semantics such that the expression is at the bottom and each of the components is broken down into their respective operational semantic expression(s). 

Again, drawing a picture would make this significantly easier to portray, but primarily the rule for NOT would be used to prove the above statement results in true.  


