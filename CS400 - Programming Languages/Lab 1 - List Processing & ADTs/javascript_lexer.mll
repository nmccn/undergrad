(*
 * THIS IS AN AUTO-GENERATED FILE PRODUCED BY URUZ!
 * DO NOT EDIT THIS FILE, since any changes will be
 * lost when the build is reset via "make clean".
 * This file is based on a user-specified EBNF
 * grammar, which can be edited as desired.
 *)
{
   open Javascript_parser;;
   open Javascript_ast;;
   open Javascript_utils;;

  let tokens = ((Hashtbl.create 100) : ((string,token) Hashtbl.t)) ;;
  let add_token str vl =
    try let _ = Hashtbl.find tokens str in
      (parse_error ("token "^str^" already exists"))
    with _ -> Hashtbl.replace tokens str vl
  ;;
  let lookup_keyword str =
     try (let x = Hashtbl.find tokens str in x)
     with _ -> IDENT1 str
  ;;
  add_token "false" FALSE_KW ;;
  add_token "true" TRUE_KW ;;
  add_token "undefined" UNDEF_KW ;;
  add_token "return" RET_KW ;;
  add_token "function" FUNC_KW ;;
  add_token "let" LET_KW ;;
  add_token "const" CONST_KW ;;
}

(* The type "token" is defined in Javascript_parser.mli *)
rule token = parse
| "/*" { entry_multilinecomment 0 "" lexbuf }
| ("//" ([^ '\n'])*) as x {ignore x; (let _ = count_newlines x lexbuf in (); token lexbuf)} (* SingleLineComment : ~ (len = 2) (kw = false) *)
| (('"') ((('\\') (('\\') | ('"') | ('\'') | (['n' 't' 'b' 'r']) | ('\n') | (['0'-'9' 'a'-'f' 'A'-'F']) (['0'-'9' 'a'-'f' 'A'-'F']))) | ([^ '\\' '"']))* ('"')) as x {ignore x; (let _ = count_newlines x lexbuf in STRING(my_unescaped (fst (strip_quotes x))))} (* String : string (len = 2) (kw = false) *)
| ((['0'-'9'])* (('.') (['0'-'9'])+)?) as x {ignore x; NUMBER((float_of_string x))} (* Number : float (len = 2) (kw = false) *)
| ((',')) as x {ignore x; IDENT_LIST_1_1_0_0_0(x)} (* IdentList_1_1_0_0_0 : char (len = 1) (kw = false) *)
| ((';')) as x {ignore x; BLOCK_1_1(x)} (* Block_1_1 : char (len = 1) (kw = false) *)
| (('}')) as x {ignore x; LAMBDA1_0_7(x)} (* Lambda1_0_7 : char (len = 1) (kw = false) *)
| (('{')) as x {ignore x; LAMBDA1_0_5(x)} (* Lambda1_0_5 : char (len = 1) (kw = false) *)
| ((')')) as x {ignore x; LAMBDA1_0_4(x)} (* Lambda1_0_4 : char (len = 1) (kw = false) *)
| (('.')) as x {ignore x; EXPR1_17_1(x)} (* Expr1_17_1 : char (len = 1) (kw = false) *)
| (('(')) as x {ignore x; EXPR1_16_1(x)} (* Expr1_16_1 : char (len = 1) (kw = false) *)
| ("log") as x {ignore x; EXPR1_15_2(x)} (* Expr1_15_2 : string (len = 2) (kw = false) *)
| ("console") as x {ignore x; EXPR1_15_0(x)} (* Expr1_15_0 : string (len = 2) (kw = false) *)
| ((':')) as x {ignore x; EXPR1_14_3(x)} (* Expr1_14_3 : char (len = 1) (kw = false) *)
| (('?')) as x {ignore x; EXPR1_14_1(x)} (* Expr1_14_1 : char (len = 1) (kw = false) *)
| ("!==") as x {ignore x; EXPR1_13_1(x)} (* Expr1_13_1 : string (len = 2) (kw = false) *)
| ("===") as x {ignore x; EXPR1_12_1(x)} (* Expr1_12_1 : string (len = 2) (kw = false) *)
| (('>')) as x {ignore x; EXPR1_11_1(x)} (* Expr1_11_1 : char (len = 1) (kw = false) *)
| (">=") as x {ignore x; EXPR1_10_1(x)} (* Expr1_10_1 : string (len = 2) (kw = false) *)
| (('<')) as x {ignore x; EXPR1_9_1(x)} (* Expr1_9_1 : char (len = 1) (kw = false) *)
| ("<=") as x {ignore x; EXPR1_8_1(x)} (* Expr1_8_1 : string (len = 2) (kw = false) *)
| (('+')) as x {ignore x; EXPR1_6_1(x)} (* Expr1_6_1 : char (len = 1) (kw = false) *)
| (('/')) as x {ignore x; EXPR1_5_1(x)} (* Expr1_5_1 : char (len = 1) (kw = false) *)
| (('*')) as x {ignore x; EXPR1_4_1(x)} (* Expr1_4_1 : char (len = 1) (kw = false) *)
| (('!')) as x {ignore x; EXPR1_3_0(x)} (* Expr1_3_0 : char (len = 1) (kw = false) *)
| (('-')) as x {ignore x; EXPR1_2_0(x)} (* Expr1_2_0 : char (len = 1) (kw = false) *)
| (('=')) as x {ignore x; STMT_2_1(x)} (* Stmt_2_1 : char (len = 1) (kw = false) *)
| ((['\r' '\n' '\t' ' '])+) as x {ignore x; (let _ = count_newlines x lexbuf in (); token lexbuf)} (* Blanks : ~ (len = 2) (kw = false) *)
| ((['a'-'z' 'A'-'Z' '_']) (['0'-'9' 'a'-'z' 'A'-'Z' '_'])*) as x {ignore x; (try lookup_keyword x with _ -> IDENT1(x))} (* Ident1 : string (len = 2) (kw = true) *)
| eof { EOF }
| _ { lex_error "lexing error" lexbuf }
and entry_multilinecomment n x = parse
| "/*" { entry_multilinecomment (n+1) (x^"/*") lexbuf }
| "*/" { if (n=0) then ((); token lexbuf) else entry_multilinecomment (n-1) (x^"*/") lexbuf }
| _ as c { if c='\n' then do_newline lexbuf;
              entry_multilinecomment n (Printf.sprintf "%s%c" x c) lexbuf }
