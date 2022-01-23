type token =
  | EOF
  | BLOCK_1_1 of (char)
  | EXPR1_11_1 of (char)
  | EXPR1_14_1 of (char)
  | EXPR1_14_3 of (char)
  | EXPR1_16_1 of (char)
  | EXPR1_17_1 of (char)
  | EXPR1_2_0 of (char)
  | EXPR1_3_0 of (char)
  | EXPR1_4_1 of (char)
  | EXPR1_5_1 of (char)
  | EXPR1_6_1 of (char)
  | EXPR1_9_1 of (char)
  | IDENT_LIST_1_1_0_0_0 of (char)
  | LAMBDA1_0_4 of (char)
  | LAMBDA1_0_5 of (char)
  | LAMBDA1_0_7 of (char)
  | STMT_2_1 of (char)
  | NUMBER of (float)
  | EXPR1_10_1 of (string)
  | EXPR1_12_1 of (string)
  | EXPR1_13_1 of (string)
  | EXPR1_15_0 of (string)
  | EXPR1_15_2 of (string)
  | EXPR1_8_1 of (string)
  | IDENT1 of (string)
  | STRING of (string)
  | BLANKS
  | CONST_KW
  | FALSE_KW
  | FUNC_KW
  | LET_KW
  | MULTI_LINE_COMMENT
  | RET_KW
  | SINGLE_LINE_COMMENT
  | TRUE_KW
  | UNDEF_KW

open Parsing;;
let _ = parse_error;;
# 9 "javascript_parser.mly"
   open Javascript_ast;;
   open Javascript_utils;;

# 47 "javascript_parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  283 (* BLANKS *);
  284 (* CONST_KW *);
  285 (* FALSE_KW *);
  286 (* FUNC_KW *);
  287 (* LET_KW *);
  288 (* MULTI_LINE_COMMENT *);
  289 (* RET_KW *);
  290 (* SINGLE_LINE_COMMENT *);
  291 (* TRUE_KW *);
  292 (* UNDEF_KW *);
    0|]

let yytransl_block = [|
  257 (* BLOCK_1_1 *);
  258 (* EXPR1_11_1 *);
  259 (* EXPR1_14_1 *);
  260 (* EXPR1_14_3 *);
  261 (* EXPR1_16_1 *);
  262 (* EXPR1_17_1 *);
  263 (* EXPR1_2_0 *);
  264 (* EXPR1_3_0 *);
  265 (* EXPR1_4_1 *);
  266 (* EXPR1_5_1 *);
  267 (* EXPR1_6_1 *);
  268 (* EXPR1_9_1 *);
  269 (* IDENT_LIST_1_1_0_0_0 *);
  270 (* LAMBDA1_0_4 *);
  271 (* LAMBDA1_0_5 *);
  272 (* LAMBDA1_0_7 *);
  273 (* STMT_2_1 *);
  274 (* NUMBER *);
  275 (* EXPR1_10_1 *);
  276 (* EXPR1_12_1 *);
  277 (* EXPR1_13_1 *);
  278 (* EXPR1_15_0 *);
  279 (* EXPR1_15_2 *);
  280 (* EXPR1_8_1 *);
  281 (* IDENT1 *);
  282 (* STRING *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\004\000\004\000\006\000\007\000\007\000\
\007\000\005\000\008\000\008\000\008\000\008\000\008\000\008\000\
\008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
\008\000\008\000\008\000\008\000\008\000\009\000\012\000\012\000\
\012\000\012\000\012\000\014\000\015\000\016\000\019\000\019\000\
\018\000\021\000\021\000\011\000\022\000\022\000\024\000\025\000\
\025\000\026\000\027\000\010\000\028\000\028\000\029\000\030\000\
\030\000\031\000\032\000\017\000\033\000\033\000\034\000\035\000\
\035\000\036\000\037\000\023\000\038\000\013\000\039\000\039\000\
\020\000\000\000"

let yylen = "\002\000\
\001\000\002\000\001\000\001\000\003\000\001\000\004\000\004\000\
\003\000\001\000\001\000\001\000\002\000\002\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\005\000\006\000\004\000\003\000\003\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\008\000\001\000\001\000\001\000\
\001\000\002\000\003\000\001\000\001\000\002\000\001\000\001\000\
\002\000\001\000\002\000\001\000\001\000\002\000\001\000\001\000\
\002\000\001\000\002\000\001\000\001\000\002\000\001\000\001\000\
\002\000\001\000\002\000\001\000\003\000\001\000\001\000\001\000\
\000\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\031\000\000\000\011\000\
\033\000\000\000\072\000\000\000\000\000\071\000\034\000\074\000\
\001\000\000\000\003\000\000\000\000\000\006\000\000\000\012\000\
\030\000\032\000\035\000\036\000\070\000\000\000\000\000\000\000\
\000\000\045\000\044\000\073\000\068\000\000\000\000\000\040\000\
\000\000\038\000\039\000\000\000\002\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\029\000\048\000\046\000\
\000\000\000\000\000\000\000\000\000\000\009\000\005\000\000\000\
\000\000\073\000\000\000\053\000\052\000\028\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\069\000\
\000\000\049\000\050\000\000\000\007\000\073\000\000\000\061\000\
\060\000\008\000\000\000\056\000\054\000\000\000\027\000\051\000\
\000\000\064\000\062\000\000\000\000\000\000\000\000\000\057\000\
\058\000\026\000\000\000\065\000\066\000\000\000\059\000\067\000\
\000\000\000\000\000\000\000\000\041\000\042\000\000\000\037\000\
\043\000"

let yydgoto = "\002\000\
\016\000\017\000\018\000\019\000\020\000\021\000\022\000\023\000\
\024\000\075\000\033\000\025\000\026\000\027\000\028\000\041\000\
\095\000\124\000\042\000\034\000\125\000\035\000\036\000\064\000\
\065\000\090\000\091\000\077\000\101\000\102\000\112\000\113\000\
\097\000\107\000\108\000\116\000\117\000\037\000\029\000"

let yysindex = "\004\000\
\054\255\000\000\087\255\087\255\245\254\000\000\011\255\000\000\
\000\000\249\254\000\000\250\254\251\254\000\000\000\000\000\000\
\000\000\022\000\000\000\007\255\030\255\000\000\170\255\000\000\
\000\000\000\000\000\000\000\000\000\000\002\255\002\255\028\255\
\019\255\000\000\000\000\000\000\000\000\017\255\029\255\000\000\
\040\255\000\000\000\000\033\255\000\000\087\255\054\255\087\255\
\087\255\087\255\045\255\087\255\087\255\087\255\087\255\087\255\
\087\255\087\255\087\255\087\255\087\255\000\000\000\000\000\000\
\061\255\070\255\087\255\052\255\087\255\000\000\000\000\201\255\
\122\255\000\000\074\255\000\000\000\000\000\000\002\255\006\255\
\006\255\058\255\201\255\201\255\190\255\190\255\201\255\000\000\
\245\254\000\000\000\000\087\255\000\000\000\000\078\255\000\000\
\000\000\000\000\087\255\000\000\000\000\080\255\000\000\000\000\
\146\255\000\000\000\000\083\255\084\255\170\255\087\255\000\000\
\000\000\000\000\075\255\000\000\000\000\008\255\000\000\000\000\
\087\255\007\255\100\255\088\255\000\000\000\000\008\255\000\000\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\090\255\000\000\000\000\000\000\
\000\000\000\000\000\000\098\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\107\000\000\000\000\000\114\000\000\000\
\000\000\000\000\000\000\000\000\000\000\001\000\025\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\094\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\095\255\000\000\000\000\094\255\000\000\000\000\000\000\145\000\
\000\000\000\000\000\000\000\000\000\000\000\000\049\000\073\000\
\097\000\121\000\169\000\193\000\239\000\006\001\217\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\096\255\000\000\000\000\
\000\000\000\000\000\000\101\255\000\000\231\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\071\000\216\255\138\255\000\000\255\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\248\255\249\255\000\000\030\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yytablesize = 539
let yytable = "\123\000\
\013\000\030\000\031\000\043\000\001\000\070\000\050\000\051\000\
\123\000\074\000\050\000\051\000\052\000\032\000\003\000\004\000\
\038\000\039\000\040\000\044\000\088\000\045\000\005\000\046\000\
\014\000\006\000\093\000\063\000\098\000\007\000\047\000\061\000\
\008\000\009\000\062\000\010\000\011\000\012\000\013\000\066\000\
\121\000\076\000\014\000\015\000\068\000\067\000\072\000\073\000\
\018\000\069\000\079\000\080\000\081\000\082\000\083\000\084\000\
\085\000\086\000\087\000\096\000\003\000\004\000\050\000\051\000\
\052\000\100\000\053\000\054\000\005\000\078\000\119\000\006\000\
\015\000\089\000\092\000\007\000\094\000\122\000\008\000\009\000\
\126\000\010\000\011\000\012\000\013\000\106\000\122\000\103\000\
\014\000\015\000\105\000\109\000\111\000\003\000\004\000\115\000\
\016\000\110\000\118\000\120\000\127\000\005\000\073\000\128\000\
\006\000\073\000\004\000\073\000\007\000\055\000\047\000\008\000\
\009\000\010\000\063\000\011\000\012\000\071\000\104\000\129\000\
\017\000\014\000\015\000\048\000\049\000\099\000\050\000\051\000\
\052\000\000\000\053\000\054\000\055\000\056\000\000\000\000\000\
\000\000\000\000\000\000\000\000\057\000\058\000\059\000\000\000\
\022\000\060\000\000\000\048\000\049\000\000\000\050\000\051\000\
\052\000\000\000\053\000\054\000\055\000\056\000\000\000\114\000\
\000\000\000\000\000\000\000\000\057\000\058\000\059\000\000\000\
\020\000\060\000\000\000\048\000\049\000\000\000\050\000\051\000\
\052\000\000\000\053\000\054\000\055\000\056\000\000\000\000\000\
\000\000\000\000\000\000\000\000\057\000\058\000\059\000\048\000\
\021\000\060\000\050\000\051\000\052\000\000\000\053\000\054\000\
\055\000\056\000\000\000\000\000\000\000\050\000\051\000\052\000\
\057\000\053\000\054\000\055\000\000\000\060\000\000\000\000\000\
\019\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\025\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\023\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\013\000\013\000\013\000\013\000\024\000\000\000\000\000\
\000\000\013\000\013\000\013\000\013\000\013\000\013\000\000\000\
\013\000\013\000\000\000\013\000\013\000\013\000\000\000\000\000\
\013\000\014\000\014\000\014\000\014\000\000\000\000\000\000\000\
\000\000\014\000\014\000\014\000\014\000\014\000\014\000\000\000\
\014\000\014\000\000\000\014\000\014\000\014\000\000\000\000\000\
\014\000\018\000\018\000\018\000\018\000\000\000\000\000\000\000\
\000\000\018\000\018\000\018\000\018\000\018\000\018\000\000\000\
\018\000\018\000\000\000\018\000\018\000\018\000\000\000\000\000\
\018\000\015\000\015\000\015\000\015\000\000\000\000\000\000\000\
\000\000\015\000\015\000\015\000\015\000\015\000\015\000\000\000\
\015\000\015\000\000\000\015\000\015\000\015\000\000\000\000\000\
\015\000\016\000\016\000\016\000\016\000\000\000\000\000\000\000\
\000\000\016\000\016\000\016\000\016\000\016\000\016\000\000\000\
\016\000\016\000\010\000\016\000\016\000\016\000\000\000\000\000\
\016\000\017\000\017\000\017\000\017\000\000\000\010\000\010\000\
\000\000\010\000\010\000\017\000\017\000\017\000\017\000\000\000\
\017\000\017\000\000\000\017\000\017\000\017\000\000\000\000\000\
\017\000\022\000\022\000\022\000\022\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\022\000\022\000\022\000\000\000\
\022\000\022\000\000\000\022\000\022\000\022\000\000\000\000\000\
\022\000\020\000\020\000\020\000\020\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\020\000\020\000\020\000\000\000\
\020\000\020\000\000\000\020\000\020\000\020\000\000\000\000\000\
\020\000\021\000\021\000\021\000\021\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\021\000\021\000\021\000\000\000\
\021\000\021\000\000\000\021\000\021\000\021\000\000\000\000\000\
\021\000\019\000\019\000\019\000\019\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\019\000\019\000\019\000\025\000\
\019\000\019\000\025\000\019\000\019\000\019\000\000\000\023\000\
\019\000\023\000\023\000\025\000\025\000\000\000\025\000\025\000\
\000\000\000\000\000\000\023\000\023\000\000\000\023\000\023\000\
\000\000\000\000\023\000\023\000\000\000\000\000\024\000\000\000\
\024\000\024\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\024\000\024\000\000\000\024\000\024\000\000\000\
\000\000\024\000\024\000"

let yycheck = "\118\000\
\000\000\003\000\004\000\012\000\001\000\046\000\005\001\006\001\
\127\000\050\000\005\001\006\001\007\001\025\001\007\001\008\001\
\006\001\025\001\025\001\025\001\061\000\000\000\015\001\017\001\
\000\000\018\001\067\000\036\000\069\000\022\001\001\001\004\001\
\025\001\026\001\016\001\028\001\029\001\030\001\031\001\023\001\
\033\001\050\000\035\001\036\001\005\001\017\001\048\000\049\000\
\000\000\017\001\052\000\053\000\054\000\055\000\056\000\057\000\
\058\000\059\000\060\000\068\000\007\001\008\001\005\001\006\001\
\007\001\074\000\009\001\010\001\015\001\025\001\111\000\018\001\
\000\000\013\001\005\001\022\001\025\001\118\000\025\001\026\001\
\121\000\028\001\029\001\030\001\031\001\094\000\127\000\014\001\
\035\001\036\001\092\000\014\001\013\001\007\001\008\001\013\001\
\000\000\099\000\015\001\025\001\001\001\015\001\005\001\016\001\
\018\001\016\001\000\000\014\001\022\001\014\001\016\001\025\001\
\026\001\000\000\014\001\029\001\030\001\047\000\089\000\127\000\
\000\000\035\001\036\001\002\001\003\001\004\001\005\001\006\001\
\007\001\255\255\009\001\010\001\011\001\012\001\255\255\255\255\
\255\255\255\255\255\255\255\255\019\001\020\001\021\001\255\255\
\000\000\024\001\255\255\002\001\003\001\255\255\005\001\006\001\
\007\001\255\255\009\001\010\001\011\001\012\001\255\255\014\001\
\255\255\255\255\255\255\255\255\019\001\020\001\021\001\255\255\
\000\000\024\001\255\255\002\001\003\001\255\255\005\001\006\001\
\007\001\255\255\009\001\010\001\011\001\012\001\255\255\255\255\
\255\255\255\255\255\255\255\255\019\001\020\001\021\001\002\001\
\000\000\024\001\005\001\006\001\007\001\255\255\009\001\010\001\
\011\001\012\001\255\255\255\255\255\255\005\001\006\001\007\001\
\019\001\009\001\010\001\011\001\255\255\024\001\255\255\255\255\
\000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\000\000\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\000\000\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\001\001\002\001\003\001\004\001\000\000\255\255\255\255\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\255\255\255\255\
\024\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\255\255\255\255\
\024\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\255\255\255\255\
\024\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\255\255\255\255\
\024\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\255\255\
\016\001\017\001\001\001\019\001\020\001\021\001\255\255\255\255\
\024\001\001\001\002\001\003\001\004\001\255\255\013\001\014\001\
\255\255\016\001\017\001\011\001\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\255\255\255\255\
\024\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\255\255\255\255\
\024\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\255\255\255\255\
\024\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\255\255\255\255\
\024\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\012\001\013\001\014\001\001\001\
\016\001\017\001\004\001\019\001\020\001\021\001\255\255\001\001\
\024\001\003\001\004\001\013\001\014\001\255\255\016\001\017\001\
\255\255\255\255\255\255\013\001\014\001\255\255\016\001\017\001\
\255\255\255\255\020\001\021\001\255\255\255\255\001\001\255\255\
\003\001\004\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\013\001\014\001\255\255\016\001\017\001\255\255\
\255\255\020\001\021\001"

let yynames_const = "\
  EOF\000\
  BLANKS\000\
  CONST_KW\000\
  FALSE_KW\000\
  FUNC_KW\000\
  LET_KW\000\
  MULTI_LINE_COMMENT\000\
  RET_KW\000\
  SINGLE_LINE_COMMENT\000\
  TRUE_KW\000\
  UNDEF_KW\000\
  "

let yynames_block = "\
  BLOCK_1_1\000\
  EXPR1_11_1\000\
  EXPR1_14_1\000\
  EXPR1_14_3\000\
  EXPR1_16_1\000\
  EXPR1_17_1\000\
  EXPR1_2_0\000\
  EXPR1_3_0\000\
  EXPR1_4_1\000\
  EXPR1_5_1\000\
  EXPR1_6_1\000\
  EXPR1_9_1\000\
  IDENT_LIST_1_1_0_0_0\000\
  LAMBDA1_0_4\000\
  LAMBDA1_0_5\000\
  LAMBDA1_0_7\000\
  STMT_2_1\000\
  NUMBER\000\
  EXPR1_10_1\000\
  EXPR1_12_1\000\
  EXPR1_13_1\000\
  EXPR1_15_0\000\
  EXPR1_15_2\000\
  EXPR1_8_1\000\
  IDENT1\000\
  STRING\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'startAux) in
    Obj.repr(
# 34 "javascript_parser.mly"
           (let x = _1 in ignore x; (x))
# 377 "javascript_parser.ml"
               : Javascript_ast.program_t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'program) in
    Obj.repr(
# 38 "javascript_parser.mly"
              ( _1 )
# 384 "javascript_parser.ml"
               : 'startAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'programAux) in
    Obj.repr(
# 42 "javascript_parser.mly"
             (let x = _1 in ignore x; (x))
# 391 "javascript_parser.ml"
               : 'program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 46 "javascript_parser.mly"
        (let x = (_1) in ignore x; ((let (x_1) = x in ExprProgram(get_current_pos (),x_1))))
# 398 "javascript_parser.ml"
               : 'programAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'programAux) in
    Obj.repr(
# 47 "javascript_parser.mly"
                            (let x = (_1,_3) in ignore x; ((let (x_1,x_3) = x in StmtProgram(get_current_pos (),x_1,x_3))))
# 407 "javascript_parser.ml"
               : 'programAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'stmtAux) in
    Obj.repr(
# 51 "javascript_parser.mly"
          (let x = _1 in ignore x; (x))
# 414 "javascript_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 55 "javascript_parser.mly"
                                 ( ConstStmt(get_current_pos (), _2, _4) )
# 423 "javascript_parser.ml"
               : 'stmtAux))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 56 "javascript_parser.mly"
                               ( LetStmt(get_current_pos (), _2, _4) )
# 432 "javascript_parser.ml"
               : 'stmtAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 57 "javascript_parser.mly"
                       (let x = (_1,_3) in ignore x; ((let (x_1,x_3) = x in AssignStmt(get_current_pos (),x_1,x_3))))
# 441 "javascript_parser.ml"
               : 'stmtAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 61 "javascript_parser.mly"
           (let x = _1 in ignore x; (x))
# 448 "javascript_parser.ml"
               : 'expr1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 65 "javascript_parser.mly"
         ( VarExpr(get_current_pos (),_1) )
# 455 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'value1) in
    Obj.repr(
# 66 "javascript_parser.mly"
         ( ValExpr(get_current_pos (),_1) )
# 462 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 67 "javascript_parser.mly"
                     ( UopExpr(get_current_pos (),NegUop,_2) )
# 470 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 68 "javascript_parser.mly"
                     ( UopExpr(get_current_pos (),NotUop,_2) )
# 478 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 69 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,TimesBop,_3) )
# 487 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 70 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,DivBop,_3) )
# 496 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 71 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,PlusBop,_3) )
# 505 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 72 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,MinusBop,_3) )
# 514 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 73 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,LteBop,_3) )
# 523 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 74 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,LtBop,_3) )
# 532 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 75 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,GteBop,_3) )
# 541 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 76 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,GtBop,_3) )
# 550 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 77 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,EqBop,_3) )
# 559 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 78 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,NeqBop,_3) )
# 568 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 3 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 79 "javascript_parser.mly"
                                                   ( IfExpr(get_current_pos (),_1,_3,_5) )
# 579 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : char) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'expr1Aux) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 80 "javascript_parser.mly"
                                                                   ( PrintExpr(get_current_pos (),_5) )
# 591 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr_list) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 81 "javascript_parser.mly"
                                            ( CallExpr(get_current_pos (), _1,_3) )
# 601 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 82 "javascript_parser.mly"
                             ( FieldExpr(get_current_pos (),_1,_3) )
# 610 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'field_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 83 "javascript_parser.mly"
                                     ( ObjectExpr(get_current_pos (),_2) )
# 619 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'value1Aux) in
    Obj.repr(
# 87 "javascript_parser.mly"
            (let x = _1 in ignore x; (x))
# 626 "javascript_parser.ml"
               : 'value1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 91 "javascript_parser.mly"
         ( NumVal(_1) )
# 633 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'bool) in
    Obj.repr(
# 92 "javascript_parser.mly"
       ( BoolVal(_1) )
# 640 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 93 "javascript_parser.mly"
         ( StrVal(_1) )
# 647 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    Obj.repr(
# 94 "javascript_parser.mly"
           ( UndefVal )
# 653 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'lambda1) in
    Obj.repr(
# 95 "javascript_parser.mly"
          ( ClosureVal(StringMap.empty, _1) )
# 660 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'lambda1Aux) in
    Obj.repr(
# 99 "javascript_parser.mly"
             (let x = _1 in ignore x; (x))
# 667 "javascript_parser.ml"
               : 'lambda1))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'lambda1_0_1) in
    let _3 = (Parsing.peek_val __caml_parser_env 5 : char) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'ident_list) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : char) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : char) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : 'block) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 103 "javascript_parser.mly"
                                                                                      ( (_2, List.map (fun v -> (v,None)) _4, _7, None) )
# 680 "javascript_parser.ml"
               : 'lambda1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'lambda1_0_1Aux) in
    Obj.repr(
# 107 "javascript_parser.mly"
                 (let x = _1 in ignore x; (x))
# 687 "javascript_parser.ml"
               : 'lambda1_0_1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 111 "javascript_parser.mly"
        (None)
# 694 "javascript_parser.ml"
               : 'lambda1_0_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 112 "javascript_parser.mly"
         (Some(_1))
# 701 "javascript_parser.ml"
               : 'lambda1_0_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'blockAux) in
    Obj.repr(
# 116 "javascript_parser.mly"
           (let x = _1 in ignore x; (x))
# 708 "javascript_parser.ml"
               : 'block))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 120 "javascript_parser.mly"
               (let x = (_2) in ignore x; ((let (x_2) = x in ReturnBlock(get_current_pos (),x_2))))
# 715 "javascript_parser.ml"
               : 'blockAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'blockAux) in
    Obj.repr(
# 121 "javascript_parser.mly"
                          (let x = (_1,_3) in ignore x; ((let (x_1,x_3) = x in StmtBlock(get_current_pos (),x_1,x_3))))
# 724 "javascript_parser.ml"
               : 'blockAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'field_listAux) in
    Obj.repr(
# 125 "javascript_parser.mly"
                (let x = _1 in ignore x; (x))
# 731 "javascript_parser.ml"
               : 'field_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 129 "javascript_parser.mly"
        ( [] )
# 738 "javascript_parser.ml"
               : 'field_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'field) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'field_list_1_1) in
    Obj.repr(
# 130 "javascript_parser.mly"
                       ( _1::_2 )
# 746 "javascript_parser.ml"
               : 'field_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'field_list_1_1Aux) in
    Obj.repr(
# 134 "javascript_parser.mly"
                    (let x = _1 in ignore x; (List.rev x))
# 753 "javascript_parser.ml"
               : 'field_list_1_1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 138 "javascript_parser.mly"
        ([])
# 760 "javascript_parser.ml"
               : 'field_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'field_list_1_1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'field_list_1_1_0) in
    Obj.repr(
# 139 "javascript_parser.mly"
                                     (let x = _2 in (x)::_1)
# 768 "javascript_parser.ml"
               : 'field_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'field_list_1_1_0Aux) in
    Obj.repr(
# 143 "javascript_parser.mly"
                      (let x = _1 in ignore x; (x))
# 775 "javascript_parser.ml"
               : 'field_list_1_1_0))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'field) in
    Obj.repr(
# 147 "javascript_parser.mly"
                             ( _2 )
# 783 "javascript_parser.ml"
               : 'field_list_1_1_0Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr_listAux) in
    Obj.repr(
# 151 "javascript_parser.mly"
               (let x = _1 in ignore x; (x))
# 790 "javascript_parser.ml"
               : 'expr_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 155 "javascript_parser.mly"
        ( [] )
# 797 "javascript_parser.ml"
               : 'expr_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr1) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr_list_1_1) in
    Obj.repr(
# 156 "javascript_parser.mly"
                      ( _1::_2 )
# 805 "javascript_parser.ml"
               : 'expr_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr_list_1_1Aux) in
    Obj.repr(
# 160 "javascript_parser.mly"
                   (let x = _1 in ignore x; (List.rev x))
# 812 "javascript_parser.ml"
               : 'expr_list_1_1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 164 "javascript_parser.mly"
        ([])
# 819 "javascript_parser.ml"
               : 'expr_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr_list_1_1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr_list_1_1_0) in
    Obj.repr(
# 165 "javascript_parser.mly"
                                   (let x = _2 in (x)::_1)
# 827 "javascript_parser.ml"
               : 'expr_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr_list_1_1_0Aux) in
    Obj.repr(
# 169 "javascript_parser.mly"
                     (let x = _1 in ignore x; (x))
# 834 "javascript_parser.ml"
               : 'expr_list_1_1_0))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 173 "javascript_parser.mly"
                             ( _2 )
# 842 "javascript_parser.ml"
               : 'expr_list_1_1_0Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ident_listAux) in
    Obj.repr(
# 177 "javascript_parser.mly"
                (let x = _1 in ignore x; (x))
# 849 "javascript_parser.ml"
               : 'ident_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 181 "javascript_parser.mly"
        ( [] )
# 856 "javascript_parser.ml"
               : 'ident_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ident_list_1_1) in
    Obj.repr(
# 182 "javascript_parser.mly"
                        ( _1::_2 )
# 864 "javascript_parser.ml"
               : 'ident_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ident_list_1_1Aux) in
    Obj.repr(
# 186 "javascript_parser.mly"
                    (let x = _1 in ignore x; (List.rev x))
# 871 "javascript_parser.ml"
               : 'ident_list_1_1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 190 "javascript_parser.mly"
        ([])
# 878 "javascript_parser.ml"
               : 'ident_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'ident_list_1_1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ident_list_1_1_0) in
    Obj.repr(
# 191 "javascript_parser.mly"
                                     (let x = _2 in (x)::_1)
# 886 "javascript_parser.ml"
               : 'ident_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ident_list_1_1_0Aux) in
    Obj.repr(
# 195 "javascript_parser.mly"
                      (let x = _1 in ignore x; (x))
# 893 "javascript_parser.ml"
               : 'ident_list_1_1_0))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 199 "javascript_parser.mly"
                              ( _2 )
# 901 "javascript_parser.ml"
               : 'ident_list_1_1_0Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'fieldAux) in
    Obj.repr(
# 203 "javascript_parser.mly"
           (let x = _1 in ignore x; (x))
# 908 "javascript_parser.ml"
               : 'field))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 207 "javascript_parser.mly"
                          ( (_1, _3) )
# 917 "javascript_parser.ml"
               : 'fieldAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boolAux) in
    Obj.repr(
# 211 "javascript_parser.mly"
          (let x = _1 in ignore x; (x))
# 924 "javascript_parser.ml"
               : 'bool))
; (fun __caml_parser_env ->
    Obj.repr(
# 215 "javascript_parser.mly"
          ( true )
# 930 "javascript_parser.ml"
               : 'boolAux))
; (fun __caml_parser_env ->
    Obj.repr(
# 216 "javascript_parser.mly"
           ( false )
# 936 "javascript_parser.ml"
               : 'boolAux))
; (fun __caml_parser_env ->
    Obj.repr(
# 220 "javascript_parser.mly"
  ()
# 942 "javascript_parser.ml"
               : 'Empty))
(* Entry start *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let start (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Javascript_ast.program_t)
;;
# 224 "javascript_parser.mly"
(* footer code *)
# 969 "javascript_parser.ml"
