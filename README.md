# compiler-construction

#Language Description 

This is a parser for a toy programming language designed for a university commitment.The grammar at the moment is very simple and the language consists of semicolon seperated list of expressions.The Dragon book convention is used for specifying terminals and non-terminals (lower-case and upper-case respecitvely) 

```
S -> empty | FunList
FunList -> empty | Fun FunList
Fun -> let ArgList = decl DecList lced begin Elist end
ArgList -> empty | arg, argList
Arg -> ID
ArgEList -> empty | E, argEList
DecList -> empty | Dec; DecList
Elist -> empty | E; EList
Dec -> let ID = E
ID -> id
E -> int 
| E + E 
| E * E 
| E - E 
| E div E 
| E mod E 
| E && E 
| E '||' E 
| !E 
| E < E 
| E > E 
| E==E  
| ID 
| ID = E
| write E 
| read ID 
| if E then E else E 
| ID(ArgEList) | 
| (E)
|{ decl DecList lced Elist}
|while E do {decl DecList lced Elist}
|for E to E do {decl DecList lced Elist}
|repeat
|break
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

#Code Generation
Currently code is generated for AMD64 instruction set and has been tested on Ubuntu 14.04.

Currently expressions of the basic arithmetic operators are handled, and runtime tests are supported. The runtime tests use the return value of the system command that executes the assebmly file. The results of the rexpression is stored in the rax register, and then we could read it in the our ocaml program.

Alghough suboptimal this way of testing allows for the test of infinite amount of expressions.

#Benchmarking
The execution time of the programs was compared against the execution time of interpreted javascript code.

Currently when code generation is tested the time taken to execute the system call which executes the assembly file is measured. This allows for benchmarking to some extent, but there will be a necessity for improvements in the future as this is not completely accurate.

However, the framework available for testing is exntesible and would allow for easily adding tweaks in the future.

Also the time function can be used with the assembly file manually and then the overhead from using a system call will be eliminated

And finally for comparison here is how javascript deals with the benchmark expression: https://jsfiddle.net/pczhb2nw/

Comparison against javascript when testing local variables implementation: https://jsfiddle.net/3424bn7q/2/

Comparison against javascript when testing runtime functions implementation: https://jsfiddle.net/a8ncwekx/2/

Comparison against javascript when testing control for loops: http://jsfiddle.net/1oxv7nhr/

#Data Structure Used

The AST that the parser outputs can be found in the file ast.ml and a print utility function can be found in astUtils.ml.
