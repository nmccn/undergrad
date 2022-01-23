type token =
  | EOF
  | BLOCK_1_1 of (char)
  | EXPR1_11_1 of (char)
  | EXPR1_16_1 of (char)
  | EXPR1_16_3 of (char)
  | EXPR1_18_1 of (char)
  | EXPR1_19_1 of (char)
  | EXPR1_3_0 of (char)
  | EXPR1_4_1 of (char)
  | EXPR1_5_1 of (char)
  | EXPR1_6_1 of (char)
  | EXPR1_7_1 of (char)
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
  | EXPR1_14_1 of (string)
  | EXPR1_15_1 of (string)
  | EXPR1_17_0 of (string)
  | EXPR1_17_2 of (string)
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

# 49 "javascript_parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  285 (* BLANKS *);
  286 (* CONST_KW *);
  287 (* FALSE_KW *);
  288 (* FUNC_KW *);
  289 (* LET_KW *);
  290 (* MULTI_LINE_COMMENT *);
  291 (* RET_KW *);
  292 (* SINGLE_LINE_COMMENT *);
  293 (* TRUE_KW *);
  294 (* UNDEF_KW *);
    0|]

let yytransl_block = [|
  257 (* BLOCK_1_1 *);
  258 (* EXPR1_11_1 *);
  259 (* EXPR1_16_1 *);
  260 (* EXPR1_16_3 *);
  261 (* EXPR1_18_1 *);
  262 (* EXPR1_19_1 *);
  263 (* EXPR1_3_0 *);
  264 (* EXPR1_4_1 *);
  265 (* EXPR1_5_1 *);
  266 (* EXPR1_6_1 *);
  267 (* EXPR1_7_1 *);
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
  278 (* EXPR1_14_1 *);
  279 (* EXPR1_15_1 *);
  280 (* EXPR1_17_0 *);
  281 (* EXPR1_17_2 *);
  282 (* EXPR1_8_1 *);
  283 (* IDENT1 *);
  284 (* STRING *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\004\000\004\000\006\000\007\000\007\000\
\007\000\005\000\008\000\008\000\008\000\008\000\008\000\008\000\
\008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
\008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
\009\000\012\000\012\000\012\000\012\000\012\000\014\000\015\000\
\016\000\019\000\019\000\018\000\021\000\021\000\011\000\022\000\
\022\000\024\000\025\000\025\000\026\000\027\000\010\000\028\000\
\028\000\029\000\030\000\030\000\031\000\032\000\017\000\033\000\
\033\000\034\000\035\000\035\000\036\000\037\000\023\000\038\000\
\013\000\039\000\039\000\020\000\000\000"

let yylen = "\002\000\
\001\000\002\000\001\000\001\000\003\000\001\000\004\000\004\000\
\003\000\001\000\001\000\001\000\002\000\002\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\005\000\006\000\004\000\003\000\003\000\003\000\
\001\000\001\000\001\000\001\000\001\000\001\000\001\000\008\000\
\001\000\001\000\001\000\001\000\002\000\003\000\001\000\001\000\
\002\000\001\000\001\000\002\000\001\000\002\000\001\000\001\000\
\002\000\001\000\001\000\002\000\001\000\002\000\001\000\001\000\
\002\000\001\000\001\000\002\000\001\000\002\000\001\000\003\000\
\001\000\001\000\001\000\000\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\034\000\000\000\
\011\000\036\000\000\000\075\000\000\000\000\000\074\000\037\000\
\077\000\001\000\000\000\003\000\000\000\000\000\006\000\000\000\
\012\000\033\000\035\000\038\000\039\000\073\000\000\000\000\000\
\000\000\000\000\000\000\048\000\047\000\076\000\071\000\000\000\
\000\000\043\000\000\000\041\000\042\000\000\000\002\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\032\000\000\000\031\000\051\000\049\000\000\000\000\000\000\000\
\000\000\000\000\009\000\005\000\000\000\000\000\076\000\000\000\
\056\000\055\000\030\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\072\000\000\000\
\052\000\053\000\000\000\007\000\076\000\000\000\064\000\063\000\
\008\000\000\000\059\000\057\000\000\000\029\000\054\000\000\000\
\067\000\065\000\000\000\000\000\000\000\000\000\060\000\061\000\
\028\000\000\000\068\000\069\000\000\000\062\000\070\000\000\000\
\000\000\000\000\000\000\044\000\045\000\000\000\040\000\046\000"

let yydgoto = "\002\000\
\017\000\018\000\019\000\020\000\021\000\022\000\023\000\024\000\
\025\000\080\000\035\000\026\000\027\000\028\000\029\000\043\000\
\102\000\131\000\044\000\036\000\132\000\037\000\038\000\069\000\
\070\000\097\000\098\000\082\000\108\000\109\000\119\000\120\000\
\104\000\114\000\115\000\123\000\124\000\039\000\030\000"

let yysindex = "\255\255\
\014\255\000\000\118\255\118\255\118\255\234\254\000\000\000\255\
\000\000\000\000\241\254\000\000\243\254\244\254\000\000\000\000\
\000\000\000\000\016\000\000\000\001\255\019\255\000\000\119\001\
\000\000\000\000\000\000\000\000\000\000\000\000\156\255\254\254\
\254\254\018\255\007\255\000\000\000\000\000\000\000\000\255\254\
\009\255\000\000\023\255\000\000\000\000\013\255\000\000\118\255\
\014\255\118\255\118\255\118\255\006\255\118\255\118\255\118\255\
\118\255\118\255\118\255\118\255\118\255\118\255\118\255\118\255\
\000\000\118\255\000\000\000\000\000\000\021\255\031\255\118\255\
\016\255\118\255\000\000\000\000\129\255\182\255\000\000\026\255\
\000\000\000\000\000\000\254\254\254\254\066\255\066\255\129\255\
\129\255\076\255\076\255\141\001\231\255\129\255\000\000\234\254\
\000\000\000\000\118\255\000\000\000\000\034\255\000\000\000\000\
\000\000\118\255\000\000\000\000\037\255\000\000\000\000\208\255\
\000\000\000\000\043\255\042\255\119\001\118\255\000\000\000\000\
\000\000\046\255\000\000\000\000\089\255\000\000\000\000\118\255\
\001\255\068\255\061\255\000\000\000\000\089\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\064\255\000\000\000\000\
\000\000\000\000\000\000\000\000\084\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\091\000\000\000\000\000\103\001\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\
\027\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\078\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\081\255\000\000\000\000\
\078\255\000\000\000\000\000\000\157\000\000\000\000\000\000\000\
\000\000\000\000\000\000\053\000\079\000\105\000\131\000\183\000\
\209\000\006\001\032\001\058\001\084\001\235\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\087\255\000\000\000\000\000\000\
\000\000\000\000\092\255\000\000\078\001\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\059\000\221\255\133\255\000\000\004\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\253\255\233\255\000\000\013\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yytablesize = 679
let yytable = "\001\000\
\014\000\130\000\052\000\053\000\034\000\040\000\031\000\032\000\
\033\000\045\000\130\000\041\000\075\000\042\000\046\000\047\000\
\079\000\048\000\003\000\049\000\004\000\066\000\067\000\071\000\
\005\000\072\000\013\000\073\000\006\000\074\000\095\000\007\000\
\083\000\096\000\068\000\099\000\100\000\008\000\105\000\110\000\
\009\000\010\000\101\000\011\000\012\000\013\000\014\000\116\000\
\081\000\118\000\015\000\016\000\015\000\077\000\078\000\122\000\
\125\000\084\000\085\000\086\000\087\000\088\000\089\000\090\000\
\091\000\092\000\093\000\094\000\134\000\103\000\052\000\053\000\
\127\000\054\000\055\000\107\000\135\000\050\000\016\000\076\000\
\052\000\053\000\126\000\054\000\055\000\056\000\057\000\058\000\
\076\000\129\000\004\000\076\000\133\000\003\000\059\000\004\000\
\050\000\113\000\129\000\005\000\058\000\064\000\112\000\006\000\
\017\000\066\000\007\000\076\000\111\000\117\000\136\000\000\000\
\008\000\000\000\000\000\009\000\010\000\000\000\011\000\012\000\
\013\000\014\000\003\000\128\000\004\000\015\000\016\000\000\000\
\005\000\000\000\018\000\000\000\006\000\052\000\053\000\007\000\
\054\000\055\000\056\000\057\000\000\000\008\000\000\000\000\000\
\009\000\010\000\000\000\000\000\012\000\013\000\000\000\000\000\
\000\000\000\000\015\000\016\000\022\000\050\000\051\000\000\000\
\052\000\053\000\000\000\054\000\055\000\056\000\057\000\058\000\
\000\000\065\000\000\000\000\000\000\000\000\000\059\000\060\000\
\061\000\062\000\063\000\000\000\000\000\064\000\020\000\050\000\
\051\000\106\000\052\000\053\000\000\000\054\000\055\000\056\000\
\057\000\058\000\000\000\000\000\000\000\000\000\000\000\000\000\
\059\000\060\000\061\000\062\000\063\000\000\000\000\000\064\000\
\021\000\050\000\051\000\000\000\052\000\053\000\000\000\054\000\
\055\000\056\000\057\000\058\000\000\000\121\000\000\000\000\000\
\000\000\000\000\059\000\060\000\061\000\062\000\063\000\000\000\
\050\000\064\000\019\000\052\000\053\000\000\000\054\000\055\000\
\056\000\057\000\058\000\000\000\000\000\000\000\000\000\000\000\
\000\000\059\000\060\000\061\000\062\000\000\000\000\000\000\000\
\064\000\014\000\014\000\014\000\014\000\023\000\000\000\000\000\
\014\000\014\000\014\000\014\000\014\000\014\000\014\000\000\000\
\014\000\014\000\000\000\014\000\014\000\014\000\014\000\014\000\
\000\000\000\000\014\000\013\000\013\000\013\000\013\000\024\000\
\000\000\000\000\013\000\013\000\013\000\013\000\013\000\013\000\
\013\000\000\000\013\000\013\000\000\000\013\000\013\000\013\000\
\013\000\013\000\000\000\000\000\013\000\015\000\015\000\015\000\
\015\000\025\000\000\000\000\000\015\000\015\000\015\000\015\000\
\015\000\015\000\015\000\000\000\015\000\015\000\000\000\015\000\
\015\000\015\000\015\000\015\000\000\000\027\000\015\000\016\000\
\016\000\016\000\016\000\026\000\000\000\000\000\016\000\016\000\
\016\000\016\000\016\000\016\000\016\000\000\000\016\000\016\000\
\000\000\016\000\016\000\016\000\016\000\016\000\010\000\000\000\
\016\000\017\000\017\000\017\000\017\000\000\000\000\000\000\000\
\000\000\000\000\017\000\017\000\017\000\017\000\017\000\000\000\
\017\000\017\000\000\000\017\000\017\000\017\000\017\000\017\000\
\000\000\000\000\017\000\018\000\018\000\018\000\018\000\000\000\
\000\000\000\000\000\000\000\000\018\000\018\000\018\000\018\000\
\018\000\000\000\018\000\018\000\000\000\018\000\018\000\018\000\
\018\000\018\000\000\000\000\000\018\000\022\000\022\000\022\000\
\022\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\022\000\022\000\022\000\000\000\022\000\022\000\000\000\022\000\
\022\000\022\000\022\000\022\000\000\000\000\000\022\000\020\000\
\020\000\020\000\020\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\020\000\020\000\020\000\000\000\020\000\020\000\
\000\000\020\000\020\000\020\000\020\000\020\000\000\000\000\000\
\020\000\021\000\021\000\021\000\021\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\021\000\021\000\021\000\000\000\
\021\000\021\000\000\000\021\000\021\000\021\000\021\000\021\000\
\000\000\000\000\021\000\019\000\019\000\019\000\019\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\019\000\019\000\
\019\000\000\000\019\000\019\000\000\000\019\000\019\000\019\000\
\019\000\019\000\000\000\000\000\019\000\000\000\023\000\000\000\
\023\000\023\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\023\000\023\000\000\000\023\000\023\000\000\000\
\000\000\023\000\023\000\023\000\023\000\000\000\000\000\000\000\
\024\000\000\000\024\000\024\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\024\000\024\000\000\000\024\000\
\024\000\000\000\000\000\024\000\024\000\024\000\024\000\000\000\
\000\000\000\000\025\000\000\000\025\000\025\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\025\000\025\000\
\000\000\025\000\025\000\000\000\000\000\000\000\027\000\025\000\
\025\000\027\000\000\000\000\000\026\000\000\000\026\000\026\000\
\000\000\000\000\027\000\027\000\000\000\027\000\027\000\000\000\
\026\000\026\000\000\000\026\000\026\000\000\000\000\000\010\000\
\000\000\000\000\026\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\010\000\010\000\000\000\010\000\010\000\
\050\000\051\000\000\000\052\000\053\000\000\000\054\000\055\000\
\056\000\057\000\058\000\000\000\000\000\000\000\000\000\000\000\
\000\000\059\000\060\000\061\000\062\000\063\000\050\000\000\000\
\064\000\052\000\053\000\000\000\054\000\055\000\056\000\057\000\
\058\000\000\000\000\000\000\000\000\000\000\000\000\000\059\000\
\060\000\061\000\000\000\000\000\000\000\000\000\064\000"

let yycheck = "\001\000\
\000\000\125\000\005\001\006\001\027\001\006\001\003\000\004\000\
\005\000\013\000\134\000\027\001\048\000\027\001\027\001\000\000\
\052\000\017\001\005\001\001\001\007\001\004\001\016\001\025\001\
\011\001\017\001\000\000\005\001\015\001\017\001\066\000\018\001\
\027\001\013\001\038\000\005\001\072\000\024\001\074\000\014\001\
\027\001\028\001\027\001\030\001\031\001\032\001\033\001\014\001\
\052\000\013\001\037\001\038\001\000\000\050\000\051\000\013\001\
\015\001\054\000\055\000\056\000\057\000\058\000\059\000\060\000\
\061\000\062\000\063\000\064\000\001\001\073\000\005\001\006\001\
\027\001\008\001\009\001\079\000\016\001\002\001\000\000\016\001\
\005\001\006\001\118\000\008\001\009\001\010\001\011\001\012\001\
\005\001\125\000\000\000\014\001\128\000\005\001\019\001\007\001\
\016\001\101\000\134\000\011\001\014\001\026\001\099\000\015\001\
\000\000\014\001\018\001\049\000\096\000\106\000\134\000\255\255\
\024\001\255\255\255\255\027\001\028\001\255\255\030\001\031\001\
\032\001\033\001\005\001\035\001\007\001\037\001\038\001\255\255\
\011\001\255\255\000\000\255\255\015\001\005\001\006\001\018\001\
\008\001\009\001\010\001\011\001\255\255\024\001\255\255\255\255\
\027\001\028\001\255\255\255\255\031\001\032\001\255\255\255\255\
\255\255\255\255\037\001\038\001\000\000\002\001\003\001\255\255\
\005\001\006\001\255\255\008\001\009\001\010\001\011\001\012\001\
\255\255\014\001\255\255\255\255\255\255\255\255\019\001\020\001\
\021\001\022\001\023\001\255\255\255\255\026\001\000\000\002\001\
\003\001\004\001\005\001\006\001\255\255\008\001\009\001\010\001\
\011\001\012\001\255\255\255\255\255\255\255\255\255\255\255\255\
\019\001\020\001\021\001\022\001\023\001\255\255\255\255\026\001\
\000\000\002\001\003\001\255\255\005\001\006\001\255\255\008\001\
\009\001\010\001\011\001\012\001\255\255\014\001\255\255\255\255\
\255\255\255\255\019\001\020\001\021\001\022\001\023\001\255\255\
\002\001\026\001\000\000\005\001\006\001\255\255\008\001\009\001\
\010\001\011\001\012\001\255\255\255\255\255\255\255\255\255\255\
\255\255\019\001\020\001\021\001\022\001\255\255\255\255\255\255\
\026\001\001\001\002\001\003\001\004\001\000\000\255\255\255\255\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\022\001\023\001\
\255\255\255\255\026\001\001\001\002\001\003\001\004\001\000\000\
\255\255\255\255\008\001\009\001\010\001\011\001\012\001\013\001\
\014\001\255\255\016\001\017\001\255\255\019\001\020\001\021\001\
\022\001\023\001\255\255\255\255\026\001\001\001\002\001\003\001\
\004\001\000\000\255\255\255\255\008\001\009\001\010\001\011\001\
\012\001\013\001\014\001\255\255\016\001\017\001\255\255\019\001\
\020\001\021\001\022\001\023\001\255\255\000\000\026\001\001\001\
\002\001\003\001\004\001\000\000\255\255\255\255\008\001\009\001\
\010\001\011\001\012\001\013\001\014\001\255\255\016\001\017\001\
\255\255\019\001\020\001\021\001\022\001\023\001\000\000\255\255\
\026\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\255\255\010\001\011\001\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\022\001\023\001\
\255\255\255\255\026\001\001\001\002\001\003\001\004\001\255\255\
\255\255\255\255\255\255\255\255\010\001\011\001\012\001\013\001\
\014\001\255\255\016\001\017\001\255\255\019\001\020\001\021\001\
\022\001\023\001\255\255\255\255\026\001\001\001\002\001\003\001\
\004\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\012\001\013\001\014\001\255\255\016\001\017\001\255\255\019\001\
\020\001\021\001\022\001\023\001\255\255\255\255\026\001\001\001\
\002\001\003\001\004\001\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\012\001\013\001\014\001\255\255\016\001\017\001\
\255\255\019\001\020\001\021\001\022\001\023\001\255\255\255\255\
\026\001\001\001\002\001\003\001\004\001\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\012\001\013\001\014\001\255\255\
\016\001\017\001\255\255\019\001\020\001\021\001\022\001\023\001\
\255\255\255\255\026\001\001\001\002\001\003\001\004\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\012\001\013\001\
\014\001\255\255\016\001\017\001\255\255\019\001\020\001\021\001\
\022\001\023\001\255\255\255\255\026\001\255\255\001\001\255\255\
\003\001\004\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\013\001\014\001\255\255\016\001\017\001\255\255\
\255\255\020\001\021\001\022\001\023\001\255\255\255\255\255\255\
\001\001\255\255\003\001\004\001\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\013\001\014\001\255\255\016\001\
\017\001\255\255\255\255\020\001\021\001\022\001\023\001\255\255\
\255\255\255\255\001\001\255\255\003\001\004\001\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\013\001\014\001\
\255\255\016\001\017\001\255\255\255\255\255\255\001\001\022\001\
\023\001\004\001\255\255\255\255\001\001\255\255\003\001\004\001\
\255\255\255\255\013\001\014\001\255\255\016\001\017\001\255\255\
\013\001\014\001\255\255\016\001\017\001\255\255\255\255\001\001\
\255\255\255\255\023\001\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\013\001\014\001\255\255\016\001\017\001\
\002\001\003\001\255\255\005\001\006\001\255\255\008\001\009\001\
\010\001\011\001\012\001\255\255\255\255\255\255\255\255\255\255\
\255\255\019\001\020\001\021\001\022\001\023\001\002\001\255\255\
\026\001\005\001\006\001\255\255\008\001\009\001\010\001\011\001\
\012\001\255\255\255\255\255\255\255\255\255\255\255\255\019\001\
\020\001\021\001\255\255\255\255\255\255\255\255\026\001"

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
  EXPR1_16_1\000\
  EXPR1_16_3\000\
  EXPR1_18_1\000\
  EXPR1_19_1\000\
  EXPR1_3_0\000\
  EXPR1_4_1\000\
  EXPR1_5_1\000\
  EXPR1_6_1\000\
  EXPR1_7_1\000\
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
  EXPR1_14_1\000\
  EXPR1_15_1\000\
  EXPR1_17_0\000\
  EXPR1_17_2\000\
  EXPR1_8_1\000\
  IDENT1\000\
  STRING\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'startAux) in
    Obj.repr(
# 36 "javascript_parser.mly"
           (let x = _1 in ignore x; (x))
# 417 "javascript_parser.ml"
               : Javascript_ast.program_t))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'program) in
    Obj.repr(
# 40 "javascript_parser.mly"
              ( _1 )
# 424 "javascript_parser.ml"
               : 'startAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'programAux) in
    Obj.repr(
# 44 "javascript_parser.mly"
             (let x = _1 in ignore x; (x))
# 431 "javascript_parser.ml"
               : 'program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 48 "javascript_parser.mly"
        (let x = (_1) in ignore x; ((let (x_1) = x in ExprProgram(get_current_pos (),x_1))))
# 438 "javascript_parser.ml"
               : 'programAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'programAux) in
    Obj.repr(
# 49 "javascript_parser.mly"
                            (let x = (_1,_3) in ignore x; ((let (x_1,x_3) = x in StmtProgram(get_current_pos (),x_1,x_3))))
# 447 "javascript_parser.ml"
               : 'programAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'stmtAux) in
    Obj.repr(
# 53 "javascript_parser.mly"
          (let x = _1 in ignore x; (x))
# 454 "javascript_parser.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 57 "javascript_parser.mly"
                                 ( ConstStmt(get_current_pos (), _2, _4) )
# 463 "javascript_parser.ml"
               : 'stmtAux))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 58 "javascript_parser.mly"
                               ( LetStmt(get_current_pos (), _2, _4) )
# 472 "javascript_parser.ml"
               : 'stmtAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 59 "javascript_parser.mly"
                       (let x = (_1,_3) in ignore x; ((let (x_1,x_3) = x in AssignStmt(get_current_pos (),x_1,x_3))))
# 481 "javascript_parser.ml"
               : 'stmtAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 63 "javascript_parser.mly"
           (let x = _1 in ignore x; (x))
# 488 "javascript_parser.ml"
               : 'expr1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 67 "javascript_parser.mly"
         ( VarExpr(get_current_pos (),_1) )
# 495 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'value1) in
    Obj.repr(
# 68 "javascript_parser.mly"
         ( ValExpr(get_current_pos (),_1) )
# 502 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 69 "javascript_parser.mly"
                                       ( UopExpr(get_current_pos (),NegUop,_2) )
# 510 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 70 "javascript_parser.mly"
                     ( UopExpr(get_current_pos (),NotUop,_2) )
# 518 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 71 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,TimesBop,_3) )
# 527 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 72 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,DivBop,_3) )
# 536 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 73 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,PlusBop,_3) )
# 545 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 74 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,MinusBop,_3) )
# 554 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 75 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,LteBop,_3) )
# 563 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 76 "javascript_parser.mly"
                              ( BopExpr(get_current_pos (),_1,LtBop,_3) )
# 572 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 77 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,GteBop,_3) )
# 581 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 78 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,GtBop,_3) )
# 590 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 79 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,EqBop,_3) )
# 599 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 80 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,NeqBop,_3) )
# 608 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 81 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,AndBop,_3) )
# 617 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 82 "javascript_parser.mly"
                               ( BopExpr(get_current_pos (),_1,OrBop,_3) )
# 626 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 3 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'expr1Aux) in
    Obj.repr(
# 83 "javascript_parser.mly"
                                                   ( IfExpr(get_current_pos (),_1,_3,_5) )
# 637 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : char) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'expr1Aux) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 84 "javascript_parser.mly"
                                                                   ( PrintExpr(get_current_pos (),_5) )
# 649 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expr_list) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 85 "javascript_parser.mly"
                                            ( CallExpr(get_current_pos (), _1,_3) )
# 659 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 86 "javascript_parser.mly"
                             ( FieldExpr(get_current_pos (),_1,_3) )
# 668 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'field_list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 87 "javascript_parser.mly"
                                     ( ObjectExpr(get_current_pos (),_2) )
# 677 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr1Aux) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : char) in
    Obj.repr(
# 88 "javascript_parser.mly"
                                  ( _2 )
# 686 "javascript_parser.ml"
               : 'expr1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'value1Aux) in
    Obj.repr(
# 92 "javascript_parser.mly"
            (let x = _1 in ignore x; (x))
# 693 "javascript_parser.ml"
               : 'value1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 96 "javascript_parser.mly"
         ( NumVal(_1) )
# 700 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'bool) in
    Obj.repr(
# 97 "javascript_parser.mly"
       ( BoolVal(_1) )
# 707 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 98 "javascript_parser.mly"
         ( StrVal(_1) )
# 714 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    Obj.repr(
# 99 "javascript_parser.mly"
           ( UndefVal )
# 720 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'lambda1) in
    Obj.repr(
# 100 "javascript_parser.mly"
          ( ClosureVal(StringMap.empty, _1) )
# 727 "javascript_parser.ml"
               : 'value1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'lambda1Aux) in
    Obj.repr(
# 104 "javascript_parser.mly"
             (let x = _1 in ignore x; (x))
# 734 "javascript_parser.ml"
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
# 108 "javascript_parser.mly"
                                                                                      ( (_2, List.map (fun v -> (v,None)) _4, _7, None) )
# 747 "javascript_parser.ml"
               : 'lambda1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'lambda1_0_1Aux) in
    Obj.repr(
# 112 "javascript_parser.mly"
                 (let x = _1 in ignore x; (x))
# 754 "javascript_parser.ml"
               : 'lambda1_0_1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 116 "javascript_parser.mly"
        (None)
# 761 "javascript_parser.ml"
               : 'lambda1_0_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 117 "javascript_parser.mly"
         (Some(_1))
# 768 "javascript_parser.ml"
               : 'lambda1_0_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'blockAux) in
    Obj.repr(
# 121 "javascript_parser.mly"
           (let x = _1 in ignore x; (x))
# 775 "javascript_parser.ml"
               : 'block))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 125 "javascript_parser.mly"
               (let x = (_2) in ignore x; ((let (x_2) = x in ReturnBlock(get_current_pos (),x_2))))
# 782 "javascript_parser.ml"
               : 'blockAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'blockAux) in
    Obj.repr(
# 126 "javascript_parser.mly"
                          (let x = (_1,_3) in ignore x; ((let (x_1,x_3) = x in StmtBlock(get_current_pos (),x_1,x_3))))
# 791 "javascript_parser.ml"
               : 'blockAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'field_listAux) in
    Obj.repr(
# 130 "javascript_parser.mly"
                (let x = _1 in ignore x; (x))
# 798 "javascript_parser.ml"
               : 'field_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 134 "javascript_parser.mly"
        ( [] )
# 805 "javascript_parser.ml"
               : 'field_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'field) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'field_list_1_1) in
    Obj.repr(
# 135 "javascript_parser.mly"
                       ( _1::_2 )
# 813 "javascript_parser.ml"
               : 'field_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'field_list_1_1Aux) in
    Obj.repr(
# 139 "javascript_parser.mly"
                    (let x = _1 in ignore x; (List.rev x))
# 820 "javascript_parser.ml"
               : 'field_list_1_1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 143 "javascript_parser.mly"
        ([])
# 827 "javascript_parser.ml"
               : 'field_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'field_list_1_1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'field_list_1_1_0) in
    Obj.repr(
# 144 "javascript_parser.mly"
                                     (let x = _2 in (x)::_1)
# 835 "javascript_parser.ml"
               : 'field_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'field_list_1_1_0Aux) in
    Obj.repr(
# 148 "javascript_parser.mly"
                      (let x = _1 in ignore x; (x))
# 842 "javascript_parser.ml"
               : 'field_list_1_1_0))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'field) in
    Obj.repr(
# 152 "javascript_parser.mly"
                             ( _2 )
# 850 "javascript_parser.ml"
               : 'field_list_1_1_0Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr_listAux) in
    Obj.repr(
# 156 "javascript_parser.mly"
               (let x = _1 in ignore x; (x))
# 857 "javascript_parser.ml"
               : 'expr_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 160 "javascript_parser.mly"
        ( [] )
# 864 "javascript_parser.ml"
               : 'expr_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr1) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr_list_1_1) in
    Obj.repr(
# 161 "javascript_parser.mly"
                      ( _1::_2 )
# 872 "javascript_parser.ml"
               : 'expr_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr_list_1_1Aux) in
    Obj.repr(
# 165 "javascript_parser.mly"
                   (let x = _1 in ignore x; (List.rev x))
# 879 "javascript_parser.ml"
               : 'expr_list_1_1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 169 "javascript_parser.mly"
        ([])
# 886 "javascript_parser.ml"
               : 'expr_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr_list_1_1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr_list_1_1_0) in
    Obj.repr(
# 170 "javascript_parser.mly"
                                   (let x = _2 in (x)::_1)
# 894 "javascript_parser.ml"
               : 'expr_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr_list_1_1_0Aux) in
    Obj.repr(
# 174 "javascript_parser.mly"
                     (let x = _1 in ignore x; (x))
# 901 "javascript_parser.ml"
               : 'expr_list_1_1_0))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 178 "javascript_parser.mly"
                             ( _2 )
# 909 "javascript_parser.ml"
               : 'expr_list_1_1_0Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ident_listAux) in
    Obj.repr(
# 182 "javascript_parser.mly"
                (let x = _1 in ignore x; (x))
# 916 "javascript_parser.ml"
               : 'ident_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 186 "javascript_parser.mly"
        ( [] )
# 923 "javascript_parser.ml"
               : 'ident_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ident_list_1_1) in
    Obj.repr(
# 187 "javascript_parser.mly"
                        ( _1::_2 )
# 931 "javascript_parser.ml"
               : 'ident_listAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ident_list_1_1Aux) in
    Obj.repr(
# 191 "javascript_parser.mly"
                    (let x = _1 in ignore x; (List.rev x))
# 938 "javascript_parser.ml"
               : 'ident_list_1_1))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Empty) in
    Obj.repr(
# 195 "javascript_parser.mly"
        ([])
# 945 "javascript_parser.ml"
               : 'ident_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'ident_list_1_1Aux) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ident_list_1_1_0) in
    Obj.repr(
# 196 "javascript_parser.mly"
                                     (let x = _2 in (x)::_1)
# 953 "javascript_parser.ml"
               : 'ident_list_1_1Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ident_list_1_1_0Aux) in
    Obj.repr(
# 200 "javascript_parser.mly"
                      (let x = _1 in ignore x; (x))
# 960 "javascript_parser.ml"
               : 'ident_list_1_1_0))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 204 "javascript_parser.mly"
                              ( _2 )
# 968 "javascript_parser.ml"
               : 'ident_list_1_1_0Aux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'fieldAux) in
    Obj.repr(
# 208 "javascript_parser.mly"
           (let x = _1 in ignore x; (x))
# 975 "javascript_parser.ml"
               : 'field))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : char) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr1) in
    Obj.repr(
# 212 "javascript_parser.mly"
                          ( (_1, _3) )
# 984 "javascript_parser.ml"
               : 'fieldAux))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boolAux) in
    Obj.repr(
# 216 "javascript_parser.mly"
          (let x = _1 in ignore x; (x))
# 991 "javascript_parser.ml"
               : 'bool))
; (fun __caml_parser_env ->
    Obj.repr(
# 220 "javascript_parser.mly"
          ( true )
# 997 "javascript_parser.ml"
               : 'boolAux))
; (fun __caml_parser_env ->
    Obj.repr(
# 221 "javascript_parser.mly"
           ( false )
# 1003 "javascript_parser.ml"
               : 'boolAux))
; (fun __caml_parser_env ->
    Obj.repr(
# 225 "javascript_parser.mly"
  ()
# 1009 "javascript_parser.ml"
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
# 229 "javascript_parser.mly"
(* footer code *)
# 1036 "javascript_parser.ml"
