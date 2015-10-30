#!/bin/bash
ocamlbuild -use-menhir -tag thread -use-ocamlfind -pkg core -I src -r  lan_test.native
./lan_test.native test ./test-codegen/ --code-gen
gcc ./assembly-output/simple-expression-to-generate4.k.s -o ./assembly-output/simple_expression_to_generate4
./assembly-output/simple_expression_to_generate4
