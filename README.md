# compiler-construction

#Language Description 

This is a parser for a toy programming language designed for a university commitment.The grammar at the moment is very simple and the language consists of semicolon seperated list of expressions.The Dragon book convention is used for specifying terminals and non-terminals (lower-case and upper-case respecitvely) 

S -> empty | E;
ID -> id
E -> int | E + E | E * E | E - E | ID | ID = E | write E | read ID

The plan is:
 Assignment  will be semantically treated as an expression in which the RHS value is stored in the location on the LHS.
 Write will semantically take an expression as input and writes its value to the standard output.
 Read will semantically take an identifier as input and reads a line from the standard input. Then the value read is stored in the location specified 
 by the identifier
 The type of variable introduction, assignment, read and write could be unit or void in the type system. There could be a unit constant introduced but currently I can't see a need for one. May be the solution will be refined.

#Building Instructions

The build command that is used to build the parser is: ocamlbuild -use-menhir -tag thread -use-ocamlfind -pkg core lan\_test.native

The Core standard library is required.

In order to run the test suite type ./lan\_test.native test

In order to run the parser in interactive mode where expressions can be provided to the standard input and then parsed type ./lan\_test.native

#Data Structure Used

The AST that the parser outputs can be found in the file ast.ml and a print utility function can be found in astUtils.ml.
