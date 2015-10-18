open Ast
open AstUtils


(*let fileToAstMap = Hashtbl.create ~hashable:String.hashable ()
let createTable  = 
   Hashtbl.add fileToAstMap ~key:"exp1.k" ~data:[Plus (Int 3, Int 4)]*)

type file_info = {
ast: Ast.program;
formatString: string;
}

let fileToAstMap = Hashtbl.create 500
let createTable  = 
   Hashtbl.add fileToAstMap "exp1.k" {ast = [Plus (Int 3, Int 4)]; formatString = "3+4 should be parsed correctly as Plus(Int 3, Int 4): ";};
   Hashtbl.add fileToAstMap "exp2.k" {ast = [Plus (Times (Int 21,Int 5), Int 7)] ;formatString ="21*5+7 should be parsed corectly Plus (Times (Int 21,Int 5), Int 7):" ;};
   Hashtbl.add fileToAstMap "exp3.k" {ast =[Minus(Plus (Times (Int 21, Int 2),Int 5),Times(Int 3,Int 4))] ;formatString ="21*2+5-3*4 should be parsed corectly Minus(Plus (Times (Int 21,Int 2),Int 5),Times(Int 3,Int 4)):" ;};
   Hashtbl.add fileToAstMap "exp4.k" {ast = [IdExp (Id "id")]  ;formatString = "id should be parsed correctly IdExp (Id id):" ;};
   Hashtbl.add fileToAstMap "exp5.k" {ast = [Plus(IdExp(Id "id"), IdExp (Id "id"))]  ;formatString = "id + id should be parsed correctly Plus (IdExp (Id\"id\"), IdExp (Id \"id\")):" ;};
   Hashtbl.add fileToAstMap "exp6.k" {ast = [Write (IdExp (Id"id"))]  ;formatString = "print id should be parsed correctly Write (IdExp (Id \"id\")):";};
   Hashtbl.add fileToAstMap "exp7.k" {ast = [Read (Id "id")]   ;formatString = "read id should be parsed correctly Read (Id (Id \"id\")):";};
   Hashtbl.add fileToAstMap "exp8.k" {ast = [Assign (Id "id", Minus(Plus(Int 4, Int 5),Int 3))]  ;formatString = "id = 4+5-3 should be parsed correctly  Assign (Id \"id\", Minus(Plus(Int 4, Int 5),Int 3)):";};
   Hashtbl.add fileToAstMap "exp9.k" {ast = [Int 4; Plus(Int 5, Int 3);IdExp (Id "id")]  ;formatString = "4;5+3;id should be parsed correctly [Int 4, Plus(Int 5, Int 3),IdExp (Id \"id\")]:";};
    Hashtbl.add fileToAstMap "exp10.k" {ast = [Assign(Id "x",Minus(Plus(Write (IdExp (Id "z")),Int 13),Plus(Plus(Times(Int 25,Int 6),Read (Id "q")),Write (Int 5))))]  ;formatString = "x =print z + 13 - 25*6 + read q + print 5 should be parsed Assign(Id \"x\",Minus(Plus(Write (IdExp (Id \"z\")),Int 13),Plus(Plus(Times(Int 25,Int 6),Read (Id \"q\")),Write (Int 5)))):";};
    Hashtbl.add fileToAstMap "exp11.k" {ast = []   ;formatString = "empty file should be parsed correctly into empty list:";};
    Hashtbl.add fileToAstMap "exp12.k" {ast = []   ;formatString = "last expresion in the list:4; terminating with semicolon should cause a parsing error:";};
    Hashtbl.add fileToAstMap "exp13.k" {ast = []   ;formatString = "last expresion in the list:3;5+2;var; terminating with semicolon should cause a parsing error:";};
    Hashtbl.add fileToAstMap "exp14.k" {ast = []   ;formatString = "incorrect token in assignment: x==3 should cause parse error:";};
    Hashtbl.add fileToAstMap "exp15.k" {ast = []   ;formatString = "incorrect token in assignment: 3=3 should cause parse error:";};
    Hashtbl.add fileToAstMap "exp16.k" {ast = []   ;formatString = "trying to read an integer in read 3 should cause parse error:";};
    Hashtbl.add fileToAstMap "exp17.k" {ast = []   ;formatString = "duplicated + symbols should cause an error:";};
   

