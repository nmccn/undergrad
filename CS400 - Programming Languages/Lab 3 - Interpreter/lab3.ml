open Javascript_ast
open Javascript_main

(*
 * Check javascript_ast.ml for the following useful functionality:
 * - str_float               -- convert a float to a string
 * - to_num, to_bool, to_str -- do the JavaScript automatic type conversion
 * - read_environment        -- look up a variable's value in the environment
 * - push_environment        -- add a variable binding to the environment
 * - empty_env               -- the empty environment
 *)

(* basic tests to show how the value conversion functions work (do not modify) *)
let simple_to_num_tests = ("Simple ToNum Conversions", to_num, (fun n1 n2 -> eq_float (n1,n2)), Some(str_value,str_float), [
  (None, NumVal(123.0), 123.0);
  (None, BoolVal(true), 1.0);
  (None, StrVal(""),    0.0);
])
let simple_to_bool_tests = ("Simple ToBool Conversions", to_bool, (=), Some(str_value,string_of_bool), [
  (None, BoolVal(true),  true);
  (None, NumVal(1.0),    true);
  (None, StrVal("true"), true);
])
let simple_to_str_tests = ("Simple ToStr Conversions", to_str, (=), Some(str_value,(fun x -> x)), [
  (None, StrVal("hello"), "hello");
  (None, BoolVal(true),   "true");
  (None, NumVal(1.234),   "1.234");
  (None, NumVal(1.000),   "1");
  (None, NumVal(0.00),    "0");
  (None, NumVal(100.01),  "100.01");
])

(*
 * (eval p) should reduce a program in initial environment env to a *value*
 * (if Node.js produces a *value* for an example JavaScript program,
 * your evaluator should produce that same value).
 *)

(* evaluate a program *)
let rec eval = fun (env, p) -> match p with
(* If just an expression, evaluate, otherwise, we must take into consideration prior variable declarations, etc.*)
| ExprProgram(_,e) -> eval_expr(env, e)
| StmtProgram(_,s,p2) -> eval(eval_stmt(env, s), p2) 

(* evaluate a statement *)
and eval_stmt = fun (env,s) -> match s with
(* Update the environment with the mapping of the evaulated expression and its assosciated variable  *)
| ConstStmt(_,x,e) -> push_environment(env, x, eval_expr(env, e))
| _ -> raise (UnimplementedStmt(s))

(* evaluate an expression *)
and eval_expr = fun (env,e) -> match e with
(* If the expression is already a value, grab the value *)
| ValExpr(p,v) -> v
(* If the expression is stored in a variable, read the env to get its value *)
| VarExpr(p,x) -> (match read_environment(env, x) with
  | Some(v) -> v
  | None -> UndefVal
)
(* AND / OR according to big-step semantics *)
| BopExpr(_,e1,AndBop,e2) -> (match to_bool(eval_expr(env,e1)) with
  | true -> eval_expr(env,e2)
  | false -> eval_expr(env,e1)
)
| BopExpr(_,e1,OrBop,e2) -> (match to_bool(eval_expr(env,e1)) with
  | false -> eval_expr(env,e2)
  | true -> eval_expr(env,e1)
)
(* ARITH operations according to big-step semantics *)
(* -also includes String functionality after Task 2 *)
| BopExpr(_,e1,PlusBop,e2) -> (match (eval_expr(env,e1), eval_expr(env,e2)) with
  | StrVal(s1),StrVal(s2) -> let s = s1^s2 in StrVal(s)
  | _ -> NumVal(to_num(eval_expr(env,e1)) +. to_num(eval_expr(env,e2)))
)

| BopExpr(_,e1,MinusBop,e2) -> NumVal(to_num(eval_expr(env,e1)) -. to_num(eval_expr(env,e2)))
| BopExpr(_,e1,TimesBop,e2) -> NumVal(to_num(eval_expr(env,e1)) *. to_num(eval_expr(env,e2)))
| BopExpr(_,e1,DivBop,e2) -> NumVal(to_num(eval_expr(env,e1)) /. to_num(eval_expr(env,e2)))
(* Similarly, INEQ operations according to big-step semantics *)
(* -also includes String functionality after Task 2 *)
| BopExpr(_,e1,LteBop,e2) -> (match (eval_expr(env,e1), eval_expr(env,e2)) with
  | StrVal(s1),StrVal(s2) -> BoolVal(s1 <= s2)
  | n1,n2 -> BoolVal(to_num(n1) <= to_num(n2))
)
| BopExpr(_,e1,LtBop,e2) -> (match (eval_expr(env,e1), eval_expr(env,e2)) with
  | StrVal(s1),StrVal(s2) -> BoolVal(s1 < s2)
  | n1,n2 -> BoolVal(to_num(n1) < to_num(n2))
)
| BopExpr(_,e1,GteBop,e2) -> (match (eval_expr(env,e1), eval_expr(env,e2)) with
  | StrVal(s1),StrVal(s2) -> BoolVal(s1 >= s2)
  | n1,n2 -> BoolVal(to_num(n1) >= to_num(n2))
)
| BopExpr(_,e1,GtBop,e2) -> (match (eval_expr(env,e1), eval_expr(env,e2)) with
  | StrVal(s1),StrVal(s2) -> BoolVal(s1 > s2)
  | n1,n2 -> BoolVal(to_num(n1) > to_num(n2))
)
(* EQ and NEQ according to big-step semantics, these check type by comparing the values directly. '3' <> 3, etc. *)
| BopExpr(_,e1,EqBop,e2) -> BoolVal(eval_expr(env, e1) = eval_expr(env, e2))
| BopExpr(_,e1,NeqBop,e2) -> BoolVal(eval_expr(env, e1) <> eval_expr(env, e2))
(* NEG and NOT according to big-step semantics *)
| UopExpr(_,NegUop,e) -> NumVal(-. to_num(eval_expr(env, e)))
| UopExpr(_,NotUop,e) -> (match to_bool(eval_expr(env, e)) with
  | true -> BoolVal(false)
  | false -> BoolVal(true)
)
(* In-line if statements and Console.log() from Task 1 *)
| IfExpr(p,e1,e2,e3) -> if(to_bool(eval_expr(env, e1))) then eval_expr(env, e2) else eval_expr(env, e3)
| PrintExpr(p,e) -> (
  (* Evaluate e and then print the results *)
  let _ = (Printf.printf "%s\n" (to_str(eval_expr(env, e)))) in
  UndefVal
)
(* other expression types unimplemented *)
| _ -> raise (UnimplementedExpr(e))

(* basic tests for the evaluator (do not modify) *)
let simple_expr_eval_tests = ("Simple Expression Evaluation", (fun p -> eval (empty_env,p)), eq_value, Some(str_program,str_value), [
  (None, parse_string "1 + true",                    NumVal(2.0));
  (None, parse_string "false + true",                NumVal(1.0));
  (None, parse_string "100 || 200",                  NumVal(100.0));
  (None, parse_string "-false",                      NumVal(0.0));
  (None, parse_string "1 + 1",                       NumVal(2.0));
  (None, parse_string "3 + (4 + 5)",                 NumVal(12.0));
  (None, parse_string "3 * (4 + 5)",                 NumVal(27.0));
  (None, parse_string "-6 * 90 - 8",                 NumVal(-548.0));
  (None, parse_string "-100 + 50",                   NumVal(-50.0));
  (None, parse_string "true && (false || true)",     BoolVal(true));
  (None, parse_string "true && (false || !true)",    BoolVal(false));
  (None, parse_string "1 < 2",                       BoolVal(true));
  (None, parse_string "100 === 100",                 BoolVal(true));
  (None, parse_string "100 === 101",                 BoolVal(false));
  (None, parse_string "100 !== 200",                 BoolVal(true));
  (None, parse_string "true === true",               BoolVal(true));
])

let simple_print_eval_tests = ("Simple Print Evaluation", (fun p -> eval (empty_env,p)), eq_value, Some(str_program,str_value), [
  (None, parse_string "console.log(\"\")",           UndefVal);
])

let simple_cond_eval_tests = ("Simple Conditional Evaluation", (fun p -> eval (empty_env,p)), eq_value, Some(str_program,str_value), [
  (None, parse_string "(1 < 2) ? 123 : 124",         NumVal(123.0));
])

let simple_str_eval_tests = ("Simple String Evaluation", (fun p -> eval (empty_env,p)), eq_value, Some(str_program,str_value), [
  (None, parse_string "\"aaa\" < \"aaaa\"",          BoolVal(true));
  (None, parse_string "\"bbb\" < \"aaa\"",           BoolVal(false));
  (None, parse_string "\"hello\"+\" \"+\"world\"",   StrVal("hello world"));
])

let simple_var_eval_tests = ("Simple Variable Evaluation", (fun p -> eval (empty_env,p)), eq_value, Some(str_program,str_value), [
  (None, parse_string "const x = 1; x+1",            NumVal(2.0));
  (None, parse_string "const x=1; const y=2; x+y",   NumVal(3.0));
  (None, parse_string "const x=3; const y=x*2+1; y", NumVal(7.0));
])

(* note - you can use the following to print a program for debugging *)
(* let _ = Printf.printf "RESULT = %s\n" (str_program (parse_string "const x = 1 + 1; x * 2")) *)
(* Tests we wrote:  *) 
let cond_eval_tests = ("Conditional Evaluation", (fun p -> eval (empty_env,p)), eq_value, Some(str_program,str_value), [
  (* A few tests for the conditional functionality (inline if)  *)
  (Some("Conditional test #1 (string T)"), parse_string "(\"a\" <\"b\") ? true : false", BoolVal(true));
  (Some("Conditional test #2 (string F)"), parse_string "(\"a\" >\"b\") ? true : false", BoolVal(false)); 
  (Some("Conditional test #3 (number >0)"), parse_string "(1) ? true : false", BoolVal(true));
  (Some("Conditional test #4 (number >=0"), parse_string "(0) ? true : false", BoolVal(false));
])

let str_eval_tests = ("String Evaluation", (fun p -> eval (empty_env,p)), eq_value, Some(str_program,str_value), [
  (* A few tests for the string functionality *)
  (Some("String test #1 (+)"), parse_string "\"abc\" + \"def\" + \"ghi\"", StrVal("abcdefghi"));
  (Some("String test #2 (<=)"), parse_string "\"abc\" <= \"abc\"", BoolVal(true));
  (Some("String test #3 (>)"), parse_string "\"def\" > \"abc\"", BoolVal(true));
  (Some("String test #4 (>="), parse_string "\"zzzzzzz\" >= \"aaaaaaaaaaaaaaa\"", BoolVal(true));
])

let var_eval_tests = ("Variable Evaluation", (fun p -> eval (empty_env,p)), eq_value, Some(str_program,str_value), [
  (* The test described in the instructions for task 3 *)
  (Some("Test given in instructions (T3)"), parse_string "const x = 1; const x = 2; x", NumVal(2.0));
  (* A few other tests, mainly for the other types. *)
  (Some("Extra Test #1 (numbers)"), parse_string "const a = 1; const b = 2; const c = 2*a*b; const b = 1; b+c", NumVal(5.0));
  (Some("Extra Test #2 (strings)"), parse_string "const x = testforstrings; x", UndefVal);
  (Some("Extra Test #3 (booleans)"), parse_string "const x = false; x", BoolVal(false));
])
