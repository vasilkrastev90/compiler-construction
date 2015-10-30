# compiler-construction

#Language Description 

This is a parser for a toy programming language designed for a university commitment.The grammar at the moment is very simple and the language consists of semicolon seperated list of expressions.The Dragon book convention is used for specifying terminals and non-terminals (lower-case and upper-case respecitvely) 

```
S -> empty | FunList;
FunList -> empty | Fun FunList
Fun -> let argList = begin Elist end
Elist -> empty | E EList
ID -> id
E -> int | E + E | E * E | E - E | E div E | E mod E |E && E | E '||' E | !E | E < E | E > E | E==E  | ID | let ID = E in E | write E | read ID | if E then E else E | apply E E | \ID -> E | (E)
```

The plan is:
 * Assignment  will be semantically treated as an expression in which the RHS value is stored in the location on the LHS.
 * Write will semantically take an expression as input and writes its value to the standard output.
 * Read will semantically take an identifier as input and reads a line from the standard input. Then the value read is stored in the location 
   specified by the identifier
 * The type of variable introduction, assignment, read and write could be unit or void in the type system. There could be a unit constant introduced
   but currently I can't see a need for one. May be the solution will be refined.

#Building Instructions

The build command that is used to build the parser is: 
```
ocamlbuild -use-menhir -tag thread -use-ocamlfind -pkg core -I src -r  lan_test.native
```

The Core standard library is required.

In order to run the test suite type 
```
./lan_test.native test <test-directory> 
```

```
./lan_test.native test ./test-optimisation/ 
```

or if you want to run the tests and compare them against the fe-optimisations

```
./lan_test.native test ./test-optimisation/ --fe-opt
```

In order to generate assembly files and test run their runtime tests run the following.

```
./lan_test.native test ./test-codegen/ --code-gen`
```

In order to run the parser in interactive mode where expressions can be provided to the standard input and then parsed type 
```
./lan_test.native interact
```

In order to run the parser on a single file and get output on the parsed input type
```
./lan_test.native interact --directory <dirname> --filename <filename> <--fe-opt>
```
#Frontend Optimisations
The compiler currently supports the following frontend optimisations:
*Constant Folding

*Constant Propagation

*Function Inlining
-function inlining is used in the case when we have an assignment to a function or a lambda abstraction and the function, or variable in the lambda abstraction is used only once in the rest of the code. then we know it is safe to inline.

i.e. apply (\x -> apply x 3) (\b -> b+1)
     would be optimised to apply (\b->b+1) 3
      
     let f = (\x -> x +1 ) in
     apply f 4
     would be optimised to
     apply (\x -> x + 1) 4
     which would be constant folded to:
     5
    

#Code Generation
Currently code is generated for AMD64 instruction set and has been tested on Ubuntu 14.04.

Currently expressions of the basic arithmetic operators are handled, and runtime tests are supported. The runtime tests use the return value of the system command that executes the assebmly file. The results of the rexpression is stored in the rax register, and then we could read it in the our ocaml program.

Alghough suboptimal this way of testing allows for the test of infinite amount of expressions.

#Benchmarking
The execution time of the programs was compared against the execution time of interpreted ocaml code.

Currently when code generation is tested the time taken to execute the system call which executes the assembly file is measured. This allows for benchmarking to some extent, but there will be a necessity for improvements in the future as this is not completely accurate.

However, the framework available for testing is quite powerful and would allow for easily adding tweaks in the future.


#Data Structure Used

The AST that the parser outputs can be found in the file ast.ml and a print utility function can be found in astUtils.ml.
