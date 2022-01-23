open Testing

(**************************************)
(** Binary Search Tree functionality **)
(**************************************)

type data = int
type binary_tree =
| Empty
| Node of binary_tree * data * binary_tree

let make_leaf = fun d -> Node(Empty,d,Empty)

(* in-order traversal of binary tree *)
let rec traverse = fun t -> match t with
| Empty -> []
| Node(l, d, r) -> (traverse l) @ [d] @ (traverse r)

(* replace all nodes equal to x in tree t with subtree s *)
let rec replace = fun ((t:binary_tree),(x:data),(s:binary_tree)) -> match t with
  | Empty -> Empty
  | Node(l,d,r) ->
    (* if the data is the target data, we replace *)
    if d = x then s
    (* otherwise, we recurse down the left and right subtrees *)
    else Node(replace(l, x, s), d, replace(r, x, s))

let replace_tests = ("Replace", replace, [
  (Some("leaf swap"), (Node(Empty,100,Empty),100,make_leaf 200), Node(Empty,200,Empty));
  (Some("Empty Tree"), (Empty, 10, make_leaf 100), Empty);
  (Some("Tree with h = 1, found"), (Node(Empty, 10, Empty),10, Node(Empty, 20, Empty)), Node(Empty, 20, Empty));
  (Some("Tree with h = 1, not found"), (Node(Empty, 10, Empty),15, Node(Empty, 20, Empty)), Node(Empty, 10, Empty));
  (Some("Tree with h = 2, not found"), (Node(Node(Empty,5,Empty),10,Node(Empty,15,Empty)), 20, Node(Empty, 10, Empty)),(Node(Node(Empty,5,Empty),10,Node(Empty,15,Empty))));
  (Some("Tree with h = 2, found"), (Node(Node(Empty,5,Empty),7,Node(Empty,15,Empty)), 15, Node(Empty, 10, Empty)),(Node(Node(Empty,5,Empty),7,Node(Empty,10,Empty))));
])

(* NOTE - you can run your own tests like this: *)
(* let _ = run_tests replace_tests *)

(* remove all nodes equal to x from tree t *)
let rec remove = fun (t,x) ->
  replace (t,x,Empty)

(* get the maximum of two elements *)
let max = fun (x,y) -> match y with
| None -> x
| Some(z) -> if z > x then z else x

(* get the minimum of two elements *)
let min = fun (x,y) -> match y with
| None -> x
| Some(z) -> if z < x then z else x

(* get the maximum element in the tree *)
let rec get_max = fun t -> match t with
  | Empty -> None
  | Node(l,d,r) -> 
    (* hold the RHS and LHS max vals *)
    let rmax = get_max(r) in
    let lmax = get_max(l) in
    (* Finds the max of both the right, left, and node in question *)
    Some(max(max(d,lmax),rmax))
    (* Why does something like the following not work? *)
    (* Some(max(max(d, get_max(l), get_max(r)))) *)

let get_max_tests = ("Get Max", get_max, [
  (Some("simple tree"), Node(Empty,10,Node(Node(Empty,30,Empty),20,Empty)), Some(30));
  (Some("Empty Tree"), Empty, None);
  (Some("simple tree1"), Node(Empty,20,Node(Node(Empty,40,Empty),30,Empty)), Some(40));
  (Some("simple tree2"), Node(Empty,1,Node(Node(Empty,3,Empty),2,Empty)), Some(3));
  (Some("simple tree3"), Node(Empty,10,Node(Node(Empty,30,Empty),20,Empty)), Some(30));
  (Some("simple tree4"), Node(Empty,100,Node(Node(Empty,300,Empty),200,Empty)), Some(300));
])

(* get the minimum element in the tree *)
let rec get_min = fun t -> match t with
  | Empty -> None
  | Node(l,d,r) -> 
    (* hold the RHS and LHS min vals *)
    let rmin = get_min(r) in
    let lmin = get_min(l) in
    (* Finds the min of both the right, left, and node in question *)
    Some(min(min(d,lmin),rmin))

let get_min_tests = ("Get Min", get_min, [
  (Some("simple tree"), Node(Empty,10,Node(Node(Empty,30,Empty),20,Empty)), Some(10));
  (Some("Empty Tree"), Empty, None);
  (Some("simple tree1"), Node(Empty,20,Node(Node(Empty,40,Empty),30,Empty)), Some(20));
  (Some("simple tree2"), Node(Empty,1,Node(Node(Empty,3,Empty),2,Empty)), Some(1));
  (Some("simple tree3"), Node(Empty,10,Node(Node(Empty,30,Empty),20,Empty)), Some(10));
  (Some("simple tree4"), Node(Empty,100,Node(Node(Empty,300,Empty),200,Empty)), Some(100));
])

(* THIS FUNCTION GAVE ME SO MUCH TROUBLE I ACTUALLY CANNOT *)
(* check if t is a binary search tree *)
let rec is_bst = fun t -> match t with
  | Empty -> true
  | Node(l,d,r) -> 
    let lbst = is_bst(l) in
    let rbst = is_bst(r) in
    if get_max(l) < Some(d)  then lbst && rbst
    else if get_min(r) > Some(d) then lbst && rbst
    else false

let is_bst_tests = ("Is BST", is_bst, [
  (Some("simple non-BST h = 2"), Node(Empty,10,Node(Node(Empty,30,Empty),20,Empty)), false);
  (Some("simple non-BST h = 2"), Node(Empty,20,Node(Node(Empty,60,Empty),40,Empty)), false);
  (Some("simple non-BST h = 2"), Node(Empty,1,Node(Node(Empty,3,Empty),2,Empty)), false);
  (Some("simple non-BST h = 2"), Node(Empty,100,Node(Node(Empty,300,Empty),200,Empty)), false);
  (Some("simple non-BST h = 2 "), Node(Empty,10,Node(Node(Empty,30,Empty),20,Empty)), false);
  (Some("simple BST h = 1"), Node(Empty, 2,Empty), true);
  (Some("Simple BST h = 2"), Node(Empty,10,Node(Node(Empty,20,Empty),30,Empty)), true);
  (Some("Empty List"), Empty, true);
])

(* insert element x into binary search tree t *)
let rec insert_bst = fun (t,x) -> match t with
  (* if empty, we want to create a new leaf node *)
  | Empty -> Node(Empty, x, Empty)
  | Node(l, d, r) -> 
  (* Deciding where to insert based on x & d *)
    if x < d then Node(insert_bst(l,x), d, r)
    else if x > d then Node(l, d, insert_bst(r,x))
    else t

let insert_bst_tests = ("Insert BST", insert_bst, [
  (Some("simple BST"), (Node(Empty,10,Node(Node(Empty,15,Empty),20,Empty)), 30), Node(Empty,10,Node(Node(Empty,15,Empty),20,Node(Empty,30,Empty))));
  (Some("Empty Tree"), (Empty, 10), Node(Empty,10,Empty));
  (Some("Tree with h = 1, add to left"), (Node(Empty, 10, Empty), 5), (Node(Node(Empty,5,Empty), 10, Empty)));
  (Some("Tree with h = 1, add to right"), (Node(Empty, 10, Empty), 15), Node(Empty, 10, Node(Empty, 15,Empty)));
  (Some("Tree with h = 2, add duplicate value"), (Node(Node(Empty,5,Empty),10,Node(Empty,15,Empty)), 5), (Node(Node(Empty,5,Empty),10,Node(Empty,15,Empty))));
  (Some("Tree with h = 2, add unique value"), (Node(Node(Empty,5,Empty),10,Node(Empty,15,Empty)), 20), (Node(Node(Empty,5,Empty),10,Node(Empty,15,Node(Empty,20,Empty)))));
])

(* check if element x is contained in binary search tree t *)
let rec search_bst = fun (t, x) -> match t with
  (* Empty list cant possibly contain the element *)
  | Empty -> false
  | Node(l,d,r) -> 
  (* If the starting node contains x, then true *)
    if d = x then true
  (* Otherwise, recurse and search the left or right subtrees *)
    else if (x < d) then search_bst(l,x)
    else search_bst(r,x) 

let search_bst_tests = ("Search BST", search_bst, [
  (Some("simple BST not found"), (Node(Empty,10,Node(Node(Empty,15,Empty),20,Empty)), 30), false);
  (Some("simple BST found"), (Node(Empty,10,Node(Node(Empty,15,Empty),20,Empty)), 15), true);
  (Some("Empty Tree"), (Empty, 10), false);
  (Some("Tree with h = 1, found"), (Node(Empty, 10, Empty), 10), true);
  (Some("Tree with h = 1, not found"), (Node(Empty, 10, Empty), 15), false);
  (Some("Tree with h = 2, found"), (Node(Node(Empty,5,Empty),10,Node(Empty,15,Empty)), 5), true);
  (Some("Tree with h = 2, not found"), (Node(Node(Empty,5,Empty),10,Node(Empty,15,Empty)), 20), false);
  
])

(***********************************)
(** List Processing functionality **)
(***********************************)

(* implement list reversal.
 * Use only recursion and pattern matching - do NOT use any built-in OCaml libraries!
 * Example: reverse ([a;b;c;d;e]) --> [e;d;c;b;a]
 *)
let rec reverse = fun l -> match l with
  | [] -> l
  | [_] -> l
  | a::more -> reverse(more) @ [a]

let reverse_tests = ("Reverse", reverse, [
  (Some("simple list"), [1;2;3;4;5], [5;4;3;2;1]);
  (Some("Empty List"), [], []);
  (Some("List of Length 1"), [1], [1]);
  (Some("Even Length List"), [2;4;6;8], [8;6;4;2]);
  (Some("Odd Length List"), [1;3;5;7;9], [9;7;5;3;1]);
  (Some("Long List"), [1;2;3;4;5;6;7;8;9;10],[10;9;8;7;6;5;4;3;2;1]);
])

(* this function should implement selection sort (hint: use the
 * provided extractSmallest function).
 * Use only recursion and pattern matching - do NOT use any built-in OCaml libraries!
 * Example: (selectionSort [3;2;4;1;5]) --> [1;2;3;4;5]
 *)
let rec selection_sort = fun l -> 
  let rec extract_smallest = fun (x,l) -> (match l with
    | [] -> (x,[])
    | y::more ->
      let (m,l2) = extract_smallest (y,more) in
      if m < x then (m,(x::l2))
      else (x,(m::l2))
  ) in 
  (* Match list, calling extract_smallest *)
  (match l with
  | [] -> []
  (* The min value, and the rest of the list, more -> match the resulting tuple from extract_smallest *)
  | min::more -> match extract_smallest(min,more) with
  (* Now, pattern match the resulting tuple with a recursive call to selection sort *)
    |min, more -> min::selection_sort(more))
  
let sort_tests = ("Selection Sort", selection_sort, [
  (Some("simple list"), [3;2;4;1;5], [1;2;3;4;5]);
  (Some("Empty List"), [], []);
  (Some("List of Length 1"), [6], [6]);
  (Some("'Standard' List"), [10;9;8;7;6;5;4;3;2;1], [1;2;3;4;5;6;7;8;9;10]);
  (Some("Element is duplicated"), [5;4;3;3;2;1], [1;2;3;3;4;5]);
  (Some("All elements the same"), [7;7;7;7;7], [7;7;7;7;7]);
])

(* implement the "map" operation discussed in class.
 * Use only recursion and pattern matching - do NOT use any built-in OCaml libraries!
 * Example: map (f,[a;b;c;d;e]) --> [f(a);f(b);f(c);f(d);f(e)]
 *)
let rec map = fun (f,l) -> match l with
  | [] -> []
  | [a] -> [f(a)]
  | a::more -> f(a)::map(f, more)

let map_tests = ("Map", map, [
  (Some("simple list"), ((fun n -> n+1),[1;2;3;4;5]), [2;3;4;5;6]);
  (Some("Empty List"), ((fun n -> n*2),[]), []);
  (Some("List of Length 1"), ((fun n -> n*2),[1]), [2]);
  (Some("Do Nothing Function"), ((fun n -> n),[2;4;6;8]), [2;4;6;8]);
  (Some("Mutliply by 0 (clear the list?)"),((fun n -> n*0),[1;3;5;7;9]), [0;0;0;0;0]);
  (Some("Long List"), ((fun n -> n+1),[1;2;3;4;5;6;7;8;9;10]),[2;3;4;5;6;7;8;9;10;11]);
])

(* implement the "fold left" operation discussed in class.
 * Use only recursion and pattern matching - do NOT use any built-in OCaml libraries!
 * Example: fold_left (f,i,[a;b;c;d;e]) --> (f (f (f (f (f (i,a), b), c), d), e))
 *)
let rec fold_left = fun (f,init,l) -> match l with
  | [] -> init
   (* Expression on the RHS was derived from the example above *)
  | a::more -> fold_left(f, f(init, a), more)

let fold_left_tests = ("Fold Left", fold_left, [
  (Some("simple list"), ((fun (acc,x) -> (acc^(string_of_int x))),"",[1;2;3;4;5]), "12345");
  (Some("Empty List"), ((fun (acc,x) -> (acc^(string_of_int x))),"3",[]), "3");
  (Some("List of Length 1"), ((fun (acc,x) -> (acc^(string_of_int x))),"3",[2]), "32");
  (Some("Adding a '+'"), ((fun (acc,x) -> (acc^(string_of_int x))),"+",[1;2;3;4;5]), "+12345");
  (Some("Adding a 't'"), ((fun (acc,x) -> (acc^(string_of_int x))),"t",[5;4;3;2;1]), "t54321");
  (Some("Testing a different function (fold to 1 number)"), ((fun (x,acc) -> x),"5",[7;7;7;7;7]), "5");
])

(* NOTE - OCaml requires all the tests in each list to have matching input/output types.
 * If you want to run additional tests having a different input/output type,
 * you can create a new group of tests like this:
 *)
(*
let fold_left_int_tests = ("Fold Left", fold_left, [
  (Some("simple list"), ((fun (x,y) -> x+y),100,[1;2;3;4;5]), 115)
])
let _ = run_tests fold_left_int_tests
*)

(* implement the "fold right" operation discussed in class.
 * Use only recursion and pattern matching - do NOT use any built-in OCaml libraries!
 * Example: fold_right (f,[a;b;c;d;e],i) --> (f (a, f (b, f (c, f (d, f (e, i))))))
 *)
let rec fold_right = fun (f,l,init) -> match l with 
  | [] -> init
  (* Expression on the RHS was derived from the example above *)
  | a::more ->  f(a,fold_right(f, more, init))

let fold_right_tests = ("Fold Right", fold_right, [
  (Some("simple list"), ((fun (x,acc) -> (acc^(string_of_int x))),[1;2;3;4;5],""), "54321");
  (Some("Empty List"), ((fun (x,acc) -> (acc^(string_of_int x))),[],"3"), "3");
  (Some("List of Length 1"), ((fun (x,acc) -> (acc^(string_of_int x))),[2],"3"), "32");
  (Some("Adding a '+'"), ((fun (x,acc) -> (acc^(string_of_int x))),[1;2;3;4;5],"+"), "+54321");
  (Some("Adding a 't'"), ((fun (x,acc) -> (acc^(string_of_int x))),[5;4;3;2;1],"t"), "t12345");
  (Some("Testing a different function (fold to 1 number)"), ((fun (x,acc) -> acc),[7;7;7;7;7],"5"), "5");
])

(* implement the "filter" operation discussed in class.
 * Use only recursion and pattern matching - do NOT use any built-in OCaml libraries!
 * Example: filter ((fun x -> (x > 3)),[1;4;2;5;3;6]) --> [4;5;6]
 *)
let rec filter = fun (f,l) -> match l with 
  | [] -> []
  (* Expression on the RHS was derived from the example above *)
  | a::more -> 
    if f(a) then a::filter(f, more)
    else filter(f, more)

let filter_tests = ("Filter", filter, [
  (Some("simple list"), ((fun x -> (x > 3)),[1;4;2;5;3;6]), [4;5;6]);
  (Some("Empty List"), ((fun x -> (x > 99)),[]), []);
  (Some("List of Length 1"), ((fun x -> (x < 7)),[6]), [6]);
  (Some("'Standard' List"), ((fun x -> (x = 3)),[1;2;3;3;2;1;1;2;3;4;5;6;7;8;9;0]), [3;3;3]);
  (Some("All elements pass"), ((fun x -> (x > 0)),[1;4;2;5;3;6]), [1;4;2;5;3;6]);
  (Some("All elements fail"), ((fun x -> (x < 1)),[1;4;2;5;3;6]), []);
])
