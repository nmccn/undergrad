# CSCI-400 Exam 2

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
- All questions are **short answer**. No more than a few sentences should be needed
  for any given answer.
- You should insert your answers into the indicated places in the exam text file,
  commit, and push to GitHub. You can push as many times as needed, up until the
  deadline. We will gather your completed exam for grading by cloning your personal
  repository after the deadline.
- Do not add any additional files. Do not add any content except for text in the
  exam file. Do not remove any of the existing content in the text file.
- **You are responsible for ensuring that your completed exam has been pushed to GitHub
  properly! You can easily do this by logging into GitHub and confirming that you see
  the correct file contents there.**

## Honor Pledge

You must type your name below, to indicate that you agree to the following statements.
Failure to agree to the following conditions will equate to a grade of zero on the exam.
1. "I will not discuss this exam with anyone else until after the submission deadline, and
   I will not obtain/share answers from/with anyone else."
2. "I understand that all submitted exams will be scanned by plagiarism detection software,
   just like other class assignments."
3. "I understand that if I am found to have plagiarized any content on this exam, I will
   receive the maximum possible penalty available to the instructors."

**Type your name below this line**:

Nicholas McClellan

**Type your Mines CWID (student ID) below this line**:

10682679

## Question 1 -- Recursive Higher-Order Functions (17 points)

- **Part A**: True higher-order functions are not natively
  supported in many languages, such as C. What is the key
  mechanism needed for supporting higher-order functions?
  Briefly describe how this mechanism works.
- **Type Answer below this line. Please be clear and concise.**:
  
  I am not sure I understand exactly what this question is looking for, but I will do my best. The mechanism needed to support higher-order functions is a way to keep track of 'context information' such that when the function is called the necessary varialbes can be looked up in the proper context. More specifically, we used closures to accomplish this. Closures in general are just way to keep track of variable scope/state, providing a persistent reference. A closure combines a function with references to the surrounding state (variables in its local scope) such that a nested function still has access to all this data even after the calling function has returned. 

- **Part B**: What is the key difference between evaluating a
  *recursive* function and evaluating a *non-recursive* function?
  (Hint: think about our big-step semantics).
- **Type Answer below this line. Please be clear and concise.**:

  The key difference between evaluating a non-recursive and recursive function is that the recursive calls may also need to utilize the previously established environment (?). In our big-step semantics, there is a rule for Call and for CallRec. Further, the only difference, other than the structure of the function, is that the evaluation of CallRec has an environment for each function call. Intuitively this makes sense to me as recursive calls often rely on the previous calls data, where a non-recursive call will often only utilize information within that call itself because there are no subsequence calls needed to dermine the result.  

  * I think I did a pretty terrible job explaining this.

## Question 2 -- Static/Dynamic Scoping (17 points)

- **Part A**: Functional languages such as OCaml implement *static
  scope*. Why is *dynamic scope* considered problematic from
  the perspective of languages like OCaml?
- **Type Answer below this line. Please be clear and concise.**:

  Dynamic scoping is problematic because variables may be overwritten inadvertently. The example in the slides has a variable 'x' being overwritten prior to the function being called and the incorrect result being returned. I assume this is the issue with dynamic scoping in OCaml as well. Also, I think in general searching through nested functions might be ineffecient. 

- **Part B**: In our big-step interpreter, we implemented
  *dynamic scope*, because it's more straightforward. If we wanted
  to extend our interpreter to support *static scope*, what would
  we need to do?
- **Type Answer below this line. Please be clear and concise.**:

  If we wanted to support static scope the programmer must know and maintain both the define-time environment and the call-time environment. In lecture and during the labs we used closures to track define-time environments. More generally though I think we could say that we need to store more information during function definition. 

## Question 3 -- Closures (17 points)

- **Part A**: Conceptually, a *closure* is a map storing
  information about the variables present at the time a
  function was defined. In our examination of closures, we
  moved to a new strategy, where we essentially split the
  environment into two maps -- one map *M* which goes from
  variable names to IDs, and another map *D* which goes from
  IDs to values, and we store the map *M* in the closure.
  What problem(s) would arise if we instead simply continued
  to view the environment as a single map *E* from variable
  names to values, and store that in the closure?
- **Type Answer below this line. Please be clear and concise.**:

  I think with the single map implementation we run into the problem of reassignment / mutability again. To elaborate, I think that if we had a variable 'x' and it was set to some value like given in the slides (6), if that same variable name, 'x', was defined again before a call to said function, it would be reassigned in the map. I think this is part of the reason that we used the double map approach, as a function can maintain the ID of the variable when it was defined. 

- **Part B**: What is one disadvantage of using closures?
  How could we deal with this issue?
- **Type Answer below this line. Please be clear and concise.**:

  Similar to the previous problem, I think the issue here is simply mutability / mutable variables. Further, we deal with this issue in the manner given above, there exists a stack of mappings and each functional call pushes to the stack and each return will pop from the stack to ensure we are accessing the correct mappings.  

## Question 4 -- Small-Step Semantics (17 points)

- **Part A**: Describe one advantage of small-step semantics
  versus big-step semantics. Additionally, describe one disadvantage.
- **Type Answer below this line. Please be clear and concise.**:

  To begin with the disadvantage, small-step semantics is more complex and requires more complicated proof trees. For an advantage, small-step handles mutable variables and big-step does not. 

- **Part B**: How would a *small-step* evaluator differ
  from a *big-step* evaluator?
- **Type Answer below this line. Please be clear and concise.**:

  A small-step evaluator would differ from a big-step evaluator in the sense that it allows for mutability. Further, small-step evaluator would quite literally take smaller steps, and maintain the corresponding environment at each step. In the lecture notes, it also mentions being a bit easier to debug because of these same reasons. 

## Question 5 -- Mutability and Objects/References (17 points)

- **Part A**: Why do we need both a stack and a heap?
- **Type Answer below this line. Please be clear and concise.**:

  The stack and heap generally store different 'types' of variables. To be a bit more specific, the stack holds temporary variables within functions. However, heap allocation is used for things that remain across function calls. For example, objects are stored on the heap to be accessible to the caller of the function. 

- **Part B**: When an object such as `{ field:123 }` is
  encountered in a JavaScript program, what actions should an
  interpreter take? Hint: think about the small-step semantics.
- **Type Answer below this line. Please be clear and concise.**:

  I am again a bit confused here, but I guess the interpreter would do something along the lines of create the object. The corresponding small-step semantics would be things like DoObject or DoAssignField. However, I think that maybe a bit more would be done. I think that this might be alluding to the concept of garbage collection. More specifically, if an object is encountered maybe it is marked as used and copied to the new heap, or something like this, in some type of GC Algorithm.

## Question 6 -- Garbage Collection (15 points)

- **Part A**: Does our big-step JavaScript interpreter allow memory
  leaks to occur? Why or why not? Would an interpreter based on
  the small-step semantics allow heap corruption to occur?
  Why or why not?
- **Type Answer below this line. Please be clear and concise.**:

  If I understand this right, garbage collection in general would ideally get rid of both of these things, so the question becomes whether or not big or small step semantics can properly implement a garbage collector. In my mind a big-step interpreter cannot do this, as the environment is not updated incrementally, but I am not certain. With that in mind, I would say that a big-step interpreter does allow for memory leaks but a small step interpreter does not allow for heap corruption, following the opposite train of thought (small-step modifies the environment each time?).

- **Part B**: Garbage collection algorithms typically involve
  traversing the "graph" formed by references to objects on the
  heap. If we wanted to implement a garbage collector in our
  interpreter, how could we find the "roots" of this graph,
  i.e., the edges where traversal would start?
- **Type Answer below this line. Please be clear and concise.**:

  The roots of the graph are simply references on the stack. How we would go about actually finding them is a bit odd to me, is this just as easy as inspecting each reference and seeing if the object being pointed to is being used still? Each iteration then removes the references on the stack that are not necessary? Or is that push/pop from the stack handled directly by the function call/return. Or is that something that depends on implementation. 
  
  * I am a bit lost here. 


