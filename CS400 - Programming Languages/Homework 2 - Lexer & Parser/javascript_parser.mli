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

val start :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Javascript_ast.program_t
