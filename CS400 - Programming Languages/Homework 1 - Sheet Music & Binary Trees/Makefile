OCAMLC = ocamlopt
CMO = cmx
CMA = cmxa

LIBS = str.$(CMA)

javascript:	flags.$(CMO) javascript_utils.$(CMO) javascript_ast.$(CMO) javascript_parser.$(CMO) javascript_lexer.$(CMO) homework02.$(CMO) javascript_main.$(CMO) main.$(CMO)
	$(OCAMLC) -o javascript $(LIBS) flags.$(CMO) javascript_utils.$(CMO) javascript_ast.$(CMO) javascript_parser.$(CMO) javascript_lexer.$(CMO) homework02.$(CMO) javascript_main.$(CMO) main.$(CMO)

main.$(CMO):	main.ml homework02.$(CMO) javascript_main.$(CMO) javascript_parser.$(CMO) javascript_lexer.$(CMO) javascript_ast.$(CMO) javascript_utils.$(CMO) flags.$(CMO)
	$(OCAMLC) -c main.ml

flags.$(CMO):	flags.ml
	$(OCAMLC) -c flags.ml

homework02.$(CMO):	homework02.ml
	$(OCAMLC) -c homework02.ml

hw02:	javascript
		./javascript -hw02

javascript_Makefile:	javascript.gra
	uruz2 javascript.gra

clean:	javascript_clean
	rm -rf *.o *.cm* *.mli javascript_parser.ml javascript_lexer.ml

-include javascript_Makefile
