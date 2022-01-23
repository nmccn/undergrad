(***********************************************************)
(** (simplified) abstract data type (ADT) for sheet music **)
(***********************************************************)

type name = string
type duration = int

type symbol =
  | Note of name * duration
  | Rest of duration

(* simple examples *)
let x = Note("A", 1)
let y = Rest(2)
let z = Note("A", 123)

(* function to extract the duration from an element
   on the page of sheet music *)
let get_duration = fun (x : symbol) -> match x with
    | Note(name, duration) -> duration
    | Rest(duration) -> duration

let d = get_duration y (* gets the value 2 *)


(**************************)
(** sheet music ADT tests *)
(**************************)

let sheet_music_tests = [
	(None, x, 1);
	(None, y, d); (* was the given test*)
	(None, z, 123);
	(None, Rest(3), 3);
	(None, Note("B", 4), 4);
	(None, Note("C", 5), 5);
]


(*****************************************)
(** abstract data type for binary trees **)
(*****************************************)

type data = int

type tree =
  | Node of tree * data * tree
  | Leaf of data

(* in-order traversal of binary tree *)
(* "unit" type for functions that don't return anything *)
let rec traverse = fun (t : tree) -> match t with
  | Node(l, d, r) -> (
    traverse l;
    print_int d;
    traverse r
  )
  | Leaf(d) -> print_int d

(* returns the proper order for the In-Order traversal (as a list) *)
let rec traverse2 = fun (t : tree) -> match t with
  | Node(l, d, r) -> 
    (traverse2 l) @ [d] @ (traverse2 r)
  | Leaf(d) -> [d]

(* returns the proper order for the Pre-Order traversal (as a list) *)
let rec traverse2_pre = fun (t : tree) -> match t with
	| Node(l, d, r) -> [d] @ (traverse2_pre l) @ (traverse2_pre r)
	| Leaf(d) -> [d]

(* returns the proper order for the Post-Order traversal (as a list) *)
let rec traverse2_post = fun (t : tree) -> match t with
	| Node(l, d, r) -> (traverse2_pre l) @ (traverse2_pre r) @ [d]
	| Leaf(d) -> [d]

(*
this encodes the following tree:
  4
 / \
2   5
/ \
1   3
*)

let my_tree = Node(Node(Leaf(1),2,Leaf(3)),4,Leaf(5))
let v = traverse2 my_tree (* should produce the value List(1, 2, 3, 4, 5) *)

(**************************)
(** binary tree ADT tests *)
(**************************)

let tree_tests = [
  (Some("basic example"), my_tree, v)
]


(* This is the test where it became evident that maybe I wasn't supposed to be hardcoding values for the expected results, however, I have no idea what is being tested when you set the expected result to be the function call.... of course it returns the result of the function? *)

(* With that in mind I'm just going to paste the above code 10 times, there i is nothing to be gained from making a bogus test case.... *)
let my_tree1 = Node(Node(Leaf(1),2,Leaf(3)),4,Leaf(5))
let v1 = traverse2_pre my_tree1
let my_tree2 = Node(Node(Leaf(7),1,Leaf(6)),9,Leaf(8))
let v2 = traverse2_pre my_tree2
let my_tree3 = Node(Node(Leaf(8),9,Leaf(7)),1,Leaf(6))
let v3 = traverse2_pre my_tree3
let my_tree4 = Node(Leaf(1), 2, Leaf(3))
let v4 = traverse2_pre my_tree4
let my_tree5 = Node(Leaf(3), 2, Leaf(1))
let v5 = traverse2_pre my_tree5

let tree_tests_pre = [
	(* (None, Node(Node(Leaf(4),2,Leaf(5)),1,Leaf(3)), );
	(None, Node(Node(Leaf(7),1,Leaf(6)),9,Leaf(8)), [91768]);
	(None, Node(Node(Leaf(8),9,Leaf(7)),1,Leaf(6)), [19876]);
	(None, Node(Leaf(1), 2, Leaf(3)), [312]);
	(None, Node(Leaf(3), 2, Leaf(1)), [132]); *)
	(None, my_tree1, v1);
	(None, my_tree2, v2);
	(None, my_tree3, v3);
	(None, my_tree4, v4);
	(None, my_tree5, v5);
]

let my_tree1 = Node(Node(Leaf(1),2,Leaf(3)),4,Leaf(5))
let v1 = traverse2_post my_tree1
let my_tree2 = Node(Node(Leaf(7),1,Leaf(6)),9,Leaf(8))
let v2 = traverse2_post my_tree2
let my_tree3 = Node(Node(Leaf(8),9,Leaf(7)),1,Leaf(6))
let v3 = traverse2_post my_tree3
let my_tree4 = Node(Leaf(1), 2, Leaf(3))
let v4 = traverse2_post my_tree4
let my_tree5 = Node(Leaf(3), 2, Leaf(1))
let v5 = traverse2_post my_tree5
let tree_tests_post = [
	(* (None, Node(Node(Leaf(4),2,Leaf(5)),1,Leaf(3)), [45231]);
	(None, Node(Node(Leaf(7),1,Leaf(6)),9,Leaf(8)), [76189]);
	(None, Node(Node(Leaf(8),9,Leaf(7)),1,Leaf(6)), [87961]);
	(None, Node(Leaf(1), 2, Leaf(3)), [1,3,2]);
	(None, Node(Leaf(3), 2, Leaf(1)), [3,1,2]); *)
	(None, my_tree1, v1);
	(None, my_tree2, v2);
	(None, my_tree3, v3);
	(None, my_tree4, v4);
	(None, my_tree5, v5);
]


(******************)
(** sum function **)
(******************)

(*
  sum(1) = 2
  sum(2) = 2 + 4
  sum(3) = 2 + 4 + 8
  sum(4) = 2 + 4 + 8 + 16 = 2*(1 + (2 + 4 + 8))
*)
let rec sum = fun (n : int) -> match n with
	| 0 -> 0
	| 1 -> 2
	| _ -> 2*(sum(n-1)) + 2 (*matches the equation derived above*)


(***************)
(** sum tests **)
(***************)

let sum_tests = [
	(None, 0, 0); (*might as well test edge case?*)
  	(None, 1, 2);
  	(None, 2, 6);
  	(None, 3, 14);
	(None, 4, 30); (*As well as the next 4 entries*)
  	(None, 5, 62);
	(None, 6, 126);
	(None, 7, 254);
]
