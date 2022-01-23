open Javascript_utils
open Javascript_ast
open Javascript_main

(****************************************)
(** Expression Evaluator functionality **)
(****************************************)

(* exception indicating that a program is more
 * than just a single expression *)
exception NotExpr of program_t
(* exception indicating unimplemented input
 * expression *)
exception Unimplemented of expr_t 

(* add printer for above exceptions *)
let _ = Printexc.register_printer (fun ex -> match ex with
| NotExpr(p) -> Some(Printf.sprintf "NotExpr(%s)" (str_program p))
| Unimplemented(e) -> Some(Printf.sprintf "Unimplemented(%s)" (str_expr e))
| _ -> None)

(* extract expression from a single-expression program *)
let get_expr = fun p ->
  match p with
  | ExprProgram(_,e) -> e
  | _ -> raise (NotExpr(p))

(* parse input string as an expression *)
let parse_expr = fun s ->
  let p = parse_string s in
  get_expr p

(* (eval e) should convert input expression e into a *value* if e is
 * a well-formed expression (otherwise, UndefExpr should be returned). *)
	let rec eval = fun e -> match e with
	(* If the expression is simply some value *)
	| ValExpr(p,v) -> v 
	(* Logic for UnaryOperator on Boolean/Number *)
 | UopExpr(p,NotUop,ValExpr(_,BoolVal(v))) -> if v == true then BoolVal(false) else BoolVal(true)
	| UopExpr(p,NegUop,ValExpr(_,NumVal(v))) -> NumVal(-.v) 
	(* UnaryExpression with incorrect typing *)
	| UopExpr(p,uop,ValExpr(_,_)) -> UndefVal  
	(* UnaryOperator on an Expression *)
 | UopExpr(p,uop,e) ->
  let e2 = eval e in
  let k = UopExpr(p,uop,ValExpr(p,e2)) in
  eval k
	(* Cases for the various BopExpressions *)
	| BopExpr(p,ValExpr(_,NumVal(v1)),PlusBop,ValExpr(_,NumVal(v2))) -> NumVal(v1 +. v2)
	| BopExpr(p,ValExpr(_,NumVal(v1)),MinusBop,ValExpr(_,NumVal(v2))) -> NumVal(v1 -. v2)
	| BopExpr(p,ValExpr(_,NumVal(v1)),TimesBop,ValExpr(_,NumVal(v2))) -> NumVal(v1 *. v2)
	| BopExpr(p,ValExpr(_,NumVal(v1)),DivBop,ValExpr(_,NumVal(v2))) -> NumVal(v1 /. v2)
	| BopExpr(p,ValExpr(_,NumVal(v1)),EqBop,ValExpr(_,NumVal(v2))) ->  BoolVal(v1=v2)
	| BopExpr(p,ValExpr(_,NumVal(v1)),NeqBop,ValExpr(_,NumVal(v2))) -> BoolVal(v1!=v2)
	| BopExpr(p,ValExpr(_,NumVal(v1)),LtBop,ValExpr(_,NumVal(v2))) -> BoolVal(v1<v2)
	| BopExpr(p,ValExpr(_,NumVal(v1)),LteBop,ValExpr(_,NumVal(v2))) -> BoolVal(v1<=v2)
	| BopExpr(p,ValExpr(_,NumVal(v1)),GtBop,ValExpr(_,NumVal(v2))) -> BoolVal(v1>v2)
	| BopExpr(p,ValExpr(_,NumVal(v1)),GteBop,ValExpr(_,NumVal(v2))) -> BoolVal(v1>=v2)
	| BopExpr(p,ValExpr(_,BoolVal(v1)),AndBop,ValExpr(_,BoolVal(v2))) -> BoolVal(v1&&v2)
	| BopExpr(p,ValExpr(_,BoolVal(v1)),OrBop,ValExpr(_,BoolVal(v2))) -> BoolVal(v1||v2)
	| BopExpr(p,ValExpr(_,BoolVal(v1)),EqBop,ValExpr(_,BoolVal(v2))) ->  BoolVal(v1 == v2)
	| BopExpr(p,ValExpr(_,BoolVal(v1)),NeqBop,ValExpr(_,BoolVal(v2))) -> BoolVal(v1!=v2)
	(* If the types are mismatched or otherwise incorrect *)
 | BopExpr(p,ValExpr(_,v1),bop,ValExpr(_,v2)) -> UndefVal
	(* 'Compound' BopExpr, such that there is another expression on either (or both) sides of the operator. *)
 | BopExpr(p,e1,bop,e2) ->
  let a = eval e1 in
  let b = eval e2 in
  let k = BopExpr(p,ValExpr(p,a),bop,ValExpr(p,b)) in
  eval k
 (* other expression types unimplemented *)
 | _ -> raise (Unimplemented(e))

(* basic tests for the evaluator (do not modify) *)
let simple_eval_tests = ("Simple Evaluator", eval, eq_value, Some(str_expr,str_value), [
  (None, parse_expr "1 + true",                 UndefVal);
  (None, parse_expr "false + true",             UndefVal);
  (None, parse_expr "100 || 200",               UndefVal);
  (None, parse_expr "-false",                   UndefVal);
  (None, parse_expr "1 + 1",                    NumVal(2.0));
  (None, parse_expr "3 + (4 + 5)",              NumVal(12.0));
  (None, parse_expr "3 * (4 + 5)",              NumVal(27.0));
  (None, parse_expr "-100 + 50",                NumVal(-50.0));
  (None, parse_expr "true && (false || true)",  BoolVal(true));
  (None, parse_expr "true && (false || !true)", BoolVal(false));
  (None, parse_expr "1 < 2",                    BoolVal(true));
  (None, parse_expr "100 === 100",              BoolVal(true));
  (None, parse_expr "100 === 101",              BoolVal(false));
  (None, parse_expr "100 !== 200",              BoolVal(true));
  (None, parse_expr "true === true",            BoolVal(true));
])
(* note - you can use the following to print an expression for debugging *)
(* let _ = Printf.printf "RESULT = %s\n" (str_expr (parse_expr "1 + 1")) *)

let eval_tests = ("Evaluator", eval, eq_value, Some(str_expr,str_value), [
	(* Most of these tests were used to make sure individual match cases were working.  *)
	(Some("Test Single number"), parse_expr "50", NumVal(50.0));
	(Some("Test Single boolean"), parse_expr "true", BoolVal(true));
	(Some("Test Single Unary Op. Bool"), parse_expr "!true", BoolVal(false));
	(Some("Test Single Unary Op. Number"), parse_expr "-43", NumVal(-43.0));
	(Some("Test Single BOP &&"), parse_expr "true && false", BoolVal(false));
	(Some("Test Single BOP ||"), parse_expr "true || false", BoolVal(true));
	(Some("Test Single BOP +"), parse_expr "1 + 2", NumVal(3.0));
	(Some("Test Single BOP -"), parse_expr "5 - 4", NumVal(1.0));
	(Some("Test Single BOP *"), parse_expr "3 * 2", NumVal(6.0));
	(Some("Test Single BOP /"), parse_expr "6 / 3", NumVal(2.0));
	(Some("Test Nested Unary Op. Number"), parse_expr "-(3+5)", NumVal(-8.0));
	(Some("Test Nested Unary Op. Bool"), parse_expr "!(true || false)", BoolVal(false));
	(Some("Compound Valid Input"), parse_expr "(6*2) <= (41*4)", BoolVal(true));
	(Some("Compound Invalid Input"), parse_expr "(6*2) && (41*4)", UndefVal);
])

(****************************************)
(** Typechecker functionality          **)
(****************************************)

(* (typecheck e) should typecheck expression e, and
 * return Some(t) if e is a well-formed expression having
 * type t (otherwise, None should be returned). *)
let rec typecheck = fun e -> match e with
(* If the expression consists of a single value, return that type *)
| ValExpr(p,NumVal(_)) -> Some(NumType)
| ValExpr(p,BoolVal(_)) -> Some(BoolType)
(* In the case of UnaryExpr, we determine the operator and check that the type is valid. (ie. Num for Neg, Bool for Not) *)
| UopExpr(p,uop,e) -> (match uop with
	| NotUop -> if (typecheck e == Some(BoolType)) then Some(BoolType) else None
	| NegUop -> if (typecheck e == Some(NumType)) then Some(NumType) else None
	)
(* Similar, in the case of a BopExpr, we determine the operator and check that the type is valid  *)
| BopExpr(p,e1,bop,e2) -> (match bop with
	(* Bop that result in Bool *)
	| AndBop -> if (typecheck e1 == Some(BoolType) && typecheck e2 == Some(BoolType)) then Some(BoolType) else None
	| OrBop -> if (typecheck e1 == Some(BoolType) && typecheck e2 == Some(BoolType)) then Some(BoolType) else None
	| LtBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(BoolType) else None
	| LteBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(BoolType) else None
	| GtBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(BoolType) else None
	| GteBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(BoolType) else None
	(* The following two cases are valid for both types, so long as the types match *)
	| EqBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(BoolType)
		else if (typecheck e1 == Some(BoolType) && typecheck e2 == Some(BoolType)) then Some(BoolType)
		else None
	| NeqBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(BoolType)
		else if (typecheck e1 == Some(BoolType) && typecheck e2 == Some(BoolType)) then Some(BoolType)
		else None
	(* Bop that result in Num *)
	| PlusBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(NumType) else None
	| MinusBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(NumType) else None
	| TimesBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(NumType) else None
	| DivBop -> if (typecheck e1 == Some(NumType) && typecheck e2 == Some(NumType)) then Some(NumType) else None
	)
(* other expression types unimplemented *)
| _ -> raise (Unimplemented(e))

(* basic tests for the typechecker (do not modify) *)
let simple_typecheck_tests = ("Simple Typechecker", typecheck, ((=) : typ_t option -> typ_t option -> bool), Some(str_expr,str_option str_typ), [
  (Some("malformed1"), parse_expr "3 + (true + 5)",       None);
  (Some("malformed2"), parse_expr "false < true",         None);
  (Some("simple add"), parse_expr "1 + 1",                Some(NumType));
  (Some("right add"),  parse_expr "3 + (4 + 5)",          Some(NumType));
  (Some("num equal"),  parse_expr "100 === 200",          Some(BoolType));
  (Some("bool equal"), parse_expr "true === true",        Some(BoolType));
  (Some("comparison"), parse_expr "false || (100 < 200)", Some(BoolType));
])

let typecheck_tests = ("Typechecker", typecheck, ((=) : typ_t option -> typ_t option -> bool), Some(str_expr,str_option str_typ), [
	(* No 'edge cases' were super obvious to me, so here are 5 non-trivial tests. *)
	(Some("Test Numbers->Bool"), parse_expr "(3<5) && (5>3)", Some(BoolType));
	(Some("Test long invalid"), parse_expr "((42+3) + (18-2) - (14+3)) || false",None);
	(Some("Test long valid bool"), parse_expr "((42+3) + (18-2) - (14+3)) < 81",Some(BoolType));
	(Some("Test long numeric valid"), parse_expr "(3 + 5 + 8 * 4 / 2 - 1)",Some(NumType));
	(Some("Test long boolean valid"), parse_expr "(true || false) && (true && true) || false",Some(BoolType));
])
