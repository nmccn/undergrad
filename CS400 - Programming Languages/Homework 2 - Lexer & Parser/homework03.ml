open Javascript_ast

(* convert string to number (float) *)
let string_to_num s = float_of_string s

(* check if a character is a numeric digit *)
let is_digit = fun d -> match d with
| '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' -> true
| _ -> false

(* convert character to string *)
let char_to_string = fun c -> (String.make 1 c)

(* get the first character of a string *)
let string_head = fun s -> s.[0]
(* get remaining characters after first character *)
let string_tail = fun s -> String.sub s 1 ((String.length s) - 1)

(* convert list of characters to string *)
let rec char_list_to_string = fun stream -> match stream with
| [] -> ""
| a::more -> ((String.make 1 a)^(char_list_to_string more))

(* convert string to list of characters *)
let rec string_to_char_list = fun st -> match st with
| "" -> []
| _ -> (string_head st)::(string_to_char_list (string_tail st))

(* extract characters c from beginning of stream until (f c) becomes false *)
let extract = fun (stream,f) ->
  let rec helper = fun (st,active) ->
    match st with
    | [] -> ([],[])
    | a::more ->
      let b = (f a) && active in
      let (x,y) = helper (more,b) in
      if b then ((a::x),y) else (x,(a::y))
    in
  helper (stream,true)

(* examples of extracting from int list *)
let extract_tests_int = ("Extract (Int)", extract, [
  (None, ([],fun x -> x=0), ([],[]));
  (None, ([1;2;3;4;5;6],fun x -> false), ([],[1;2;3;4;5;6]));
  (None, ([1;2;3;4;5;6],fun x -> true), ([1;2;3;4;5;6],[]));
  (None, ([1;2;3;4;5],fun x -> x<4), ([1;2;3],[4;5]));
  (None, ([1;2;3;4;5],fun x -> x<5), ([1;2;3;4],[5]))
])
(* examples of extracting from char list *)
let extract_tests_char = ("Extract (Char)", extract, [
  (None, (['a';'b';'c'],fun x -> false), ([],['a';'b';'c']))
])

(*************************************************************)
(** Lexer functionality                                     **)
(*************************************************************)

(* type for tokens *)
type token =
| KeywordToken of string
| OpToken of string
| NumToken of string
| StrToken of string

exception LexingError of char

(* input:  list of characters
 * output: list of tokens
 *)
let rec lexer = fun stream -> match stream with
| [] -> []
| 't'::'r'::'u'::'e'::more -> KeywordToken("true")::(lexer more)
| 'f'::'a'::'l'::'s'::'e'::more -> KeywordToken("false")::(lexer more)
| '&'::'&'::more -> OpToken("&&")::(lexer more)
| '|'::'|'::more -> OpToken("||")::(lexer more)
| '+'::more -> OpToken("+")::(lexer more)
| '-'::more -> OpToken("-")::(lexer more)
| '*'::more -> OpToken("*")::(lexer more)
| '/'::more -> OpToken("/")::(lexer more)
| '!'::more -> OpToken("!")::(lexer more)
| ' '::more -> (lexer more)
| '\t'::more -> (lexer more)
| '\r'::more -> (lexer more)
| '\n'::more -> (lexer more)
| '"'::more ->
  let (x,y) = extract (more,fun x -> x<>'"') in
  StrToken(char_list_to_string x)::(match y with [] -> [] | _::more -> lexer more)
  (* Similar approach to the string code provided, but given that a is a digit, we must also add that on the the front of the token using ::
      Also, we do not need to recursively lex more as we instead want to lex whatever is not caught in the numtoken *)
| a::more when is_digit(a) ->  
  let (x,y) = extract (more, fun x -> x='.' || is_digit(x)) in
  NumToken(char_list_to_string(a::x))::(match y with [] -> [] | _::more -> lexer y)
| _ -> []

(* basic tests for the lexer (do not modify) *)
let simple_lexer_tests = ("Simple Lexer", lexer, [
  (None, string_to_char_list "1.234truefalse  \"one two\"123", [NumToken("1.234"); KeywordToken("true"); KeywordToken("false"); StrToken("one two"); NumToken("123")]);
  (None, string_to_char_list "1.234 + 2 + 6 +0+1", [NumToken("1.234"); OpToken("+"); NumToken("2"); OpToken("+"); NumToken("6"); OpToken("+"); NumToken("0"); OpToken("+"); NumToken("1")]);
  (None, string_to_char_list "1", [NumToken("1")]);
  (None, string_to_char_list "\"string\"", [StrToken("string")]);
  (None, string_to_char_list "\"one\"\"two\"", [StrToken("one");StrToken("two")])
])

let lexer_tests = ("Lexer", lexer, [
  (Some("Test 1: Empty"), string_to_char_list "", []);
  (Some("Test 2: Number and Operator"), string_to_char_list "34 ! 56", [NumToken("34"); OpToken("!"); NumToken("56")]);
  (Some("Test 3: Whitespace"), string_to_char_list " \t \r \n", []);
  (Some("Test 4: Missing Cases"), string_to_char_list "|| - * / ", [OpToken("||"); OpToken("-"); OpToken("*"); OpToken("/")]);
  (Some("Test 5: Invalid Token?"), string_to_char_list "...\#@", []);

])

(*************************************************************)
(** Parser functionality                                    **)
(*************************************************************)

(* Parser should recognize the following grammar, using a
 * top-down (recursive descent) strategy.
 * Note that parse_expr handles the "expr" nonterminal,
 * parse_times_expr handles the "times_expr" nonterminal, etc.:
 *
 *       expr       ::= times_exp | times_expr plus_op expr
 *       times_expr ::= unary_exp | unary_expr times_op times_expr
 *       unary_expr ::= const | unary_op const
 *       plus_op    ::= "+" | "-" | "||"
 *       times_op   ::= "*" | "/" | "&&"
 *       unary_op   ::= "!" | "-"
 *       const      ::= "true" | "false" | number | string
 *)
let rec parser = fun stream ->
  parse_expr stream

(* Parse expressions according to the provided subset of Javascript_ast *)
and parse_expr = fun stream -> match (parse_expr1 stream) with
| (Some(e),more) -> (Some(e),more)
| _ -> parse_times_expr stream

(* Expression Helper *)
and parse_expr1 = fun stream ->
match (parse_times_expr stream) with
| (Some(e1),st2) -> (match (parse_plus_op st2) with
  | (Some(op),st3) -> (match (parse_expr st3) with
    | (Some(e2),st4) -> (Some(BopExpr(NoPos,e1,op,e2)),st4)
    | _ -> (None,stream)
  )
  | _ -> (None,stream)
)
| _ -> (None,stream)

(* Parse 'times' expressions according to the provided subset of Javascript_ast *)
and parse_times_expr = fun stream -> match (parse_times_expr1 stream) with 
|  (Some(e),more) -> (Some(e),more)
|   _ -> parse_unary_expr stream
  
(* Times Helper *)
and parse_times_expr1 = fun stream ->
match (parse_unary_expr stream) with
| (Some(e1),st2) -> (match (parse_times_op st2) with
  | (Some(op),st3) -> (match (parse_times_expr st3) with
    | (Some(e2),st4) -> (Some(BopExpr(NoPos,e1,op,e2)),st4)
    | _ -> (None,stream)
  )
  | _ -> (None,stream)
)
| _ -> (None,stream)
  
(* Parse unary (single operand?) expressions according to the provided subset of Javascript_ast *)
and parse_unary_expr = fun stream -> match (parse_unary_expr1 stream) with 
| (Some(e),more) -> (Some(e),more)
| _ -> parse_constant stream

(* Unary Helper *)
(* Loses 1 layer, e1 -> op, op -> e2 *)
and parse_unary_expr1 = fun stream ->
match (parse_unary_op stream) with
| (Some(op),st2) -> (match (parse_constant st2) with
  | (Some(e2),st4) -> (Some(UopExpr(NoPos,op,e2)),st4)
  | _ -> (None,stream)
)
| _ -> (None,stream)
  
(* Parse addition/subtraction operations according to the provided subset of Javascript_ast *)
and parse_plus_op = fun stream -> match stream with
| OpToken("+")::more -> (Some(PlusBop),more)
| OpToken("-")::more -> (Some(MinusBop),more)
| OpToken("||")::more -> (Some(OrBop),more)
| _ -> (None,stream)

(* Parse multiplication/division operations according to the provided subset of Javascript_ast *)
and parse_times_op = fun stream -> match stream with
| OpToken("*")::more -> (Some(TimesBop),more)
| OpToken("/")::more -> (Some(DivBop),more)
| OpToken("&&")::more -> (Some(AndBop),more)
| _ -> (None,stream)

(* Parse unary operations according to the provided subset of Javascript_ast *)
and parse_unary_op = fun stream -> match stream with
| OpToken("!")::more -> (Some(NotUop),more)
| OpToken("-")::more -> (Some(NegUop),more)
| _ -> (None,stream)

(* Parse constants according to the provided subset of Javascript_ast *)
and parse_constant = fun stream -> match stream with
| KeywordToken("false")::more -> (Some(ValExpr(NoPos,BoolVal(false))),more)
| KeywordToken("true")::more -> (Some(ValExpr(NoPos,BoolVal(true))),more)
| NumToken(a)::more -> (Some(ValExpr(NoPos,NumVal(string_to_num(a)))),more)
| StrToken(a)::more -> (Some(ValExpr(NoPos, StrVal(a))), more)
| _ -> (None,stream)

(* basic parser tests (do not modify) *)
let simple_parser_tests = ("Simple Parser", parser, [
  (None, [NumToken("123");OpToken("-");NumToken("23")], (Some(BopExpr(NoPos,ValExpr(NoPos,NumVal(123.0)),MinusBop,ValExpr(NoPos,NumVal(23.0)))),[]));
  (None, lexer (string_to_char_list "1 + 2 + 3 * 5 + 6"), (Some(BopExpr(NoPos,ValExpr(NoPos,NumVal(1.0)),PlusBop,BopExpr(NoPos,ValExpr(NoPos,NumVal(2.0)),PlusBop,BopExpr(NoPos,BopExpr(NoPos,ValExpr(NoPos,NumVal(3.0)),TimesBop,ValExpr(NoPos,NumVal(5.0))),PlusBop,ValExpr(NoPos,NumVal(6.0)))))),[]))
])

(* Parser should recognize the following grammar, using a
 * top-down (recursive descent) strategy.
 * Note that parse_expr handles the "expr" nonterminal,
 * parse_times_expr handles the "times_expr" nonterminal, etc.:
 *
 *       expr       ::= times_exp | times_expr plus_op expr
 *       times_expr ::= unary_exp | unary_expr times_op times_expr
 *       unary_expr ::= const | unary_op const
 *       plus_op    ::= "+" | "-" | "||"
 *       times_op   ::= "*" | "/" | "&&"
 *       unary_op   ::= "!" | "-"
 *       const      ::= "true" | "false" | number | string
 *)


(* Honestly, the edge cases I had in mind I had no idea how to implement here, as the syntax for the actual structures returned is a little confusing... *)
(* Namely, how to test empty, and illegal things, but alas here are 5 'tests' *)
let parser_tests = ("Parser", parser, [
  (Some("Test 1: String * Keyword"), [StrToken("Hello");OpToken("*");KeywordToken("true")], (Some(BopExpr(NoPos,ValExpr(NoPos,StrVal("Hello")),TimesBop,ValExpr(NoPos,BoolVal(true)))),[]));
  (Some("Test 2: Number + String"), [NumToken("55");OpToken("+");StrToken("stinkypete")], (Some(BopExpr(NoPos,ValExpr(NoPos,NumVal(55.0)),PlusBop,ValExpr(NoPos,StrVal("stinkypete")))),[]));
  (Some("Test 3: Number / Keyword"), [NumToken("21");OpToken("/");KeywordToken("false")], (Some(BopExpr(NoPos,ValExpr(NoPos,NumVal(21.0)),DivBop,ValExpr(NoPos,BoolVal(false)))),[]));
  (Some("Test 4: String && String"), [StrToken("hello");OpToken("&&");StrToken("world")], (Some(BopExpr(NoPos,ValExpr(NoPos,StrVal("hello")),AndBop,ValExpr(NoPos,StrVal("world")))),[])); 
  (Some("Test 5: Constant only"), [KeywordToken("false")], (Some(ValExpr(NoPos, BoolVal(false))), []));
 
])
