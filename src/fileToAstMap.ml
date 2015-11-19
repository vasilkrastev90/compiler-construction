open Ast
open AstUtils


(*let fileToAstMap = Hashtbl.create ~hashable:String.hashable ()
let createTable  = 
   Hashtbl.add fileToAstMap ~key:"exp1.k" ~data:[Plus (Int 3, Int 4)]*)

type file_info = {
ast: Ast.program;
}

let fileToAstMap = Hashtbl.create 500
let createTable  = 
   Hashtbl.add fileToAstMap "exp1.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b"))])];};
   Hashtbl.add fileToAstMap "exp1.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5])];};
      Hashtbl.add fileToAstMap "exp2.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b")); Assign (Id "b", Int 7)])];};
         Hashtbl.add fileToAstMap "exp2.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5; Assign(Id "b", Int 7)])];};
      Hashtbl.add fileToAstMap "exp3.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b")); Assign (Id "b", Int 7)])];};
         Hashtbl.add fileToAstMap "exp3.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5; Assign(Id "b", Int 7)])];};
      Hashtbl.add fileToAstMap "exp4.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b")); Assign (Id "b", Int 7)])];};
         Hashtbl.add fileToAstMap "exp4.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5; Assign(Id "b", Int 7)])];};
      Hashtbl.add fileToAstMap "exp5.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b")); Assign (Id "b", Int 7)])];};
         Hashtbl.add fileToAstMap "exp5.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5; Assign(Id "b", Int 7)])];};
      Hashtbl.add fileToAstMap "exp6.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b")); Assign (Id "b", Int 7)])];};
         Hashtbl.add fileToAstMap "exp6.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5; Assign(Id "b", Int 7)])];};
      Hashtbl.add fileToAstMap "exp7.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b")); Assign (Id "b", Int 7)])];};
         Hashtbl.add fileToAstMap "exp7.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5; Assign(Id "b", Int 7)])];};
      Hashtbl.add fileToAstMap "exp8.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b")); Assign (Id "b", Int 7)])];};
         Hashtbl.add fileToAstMap "exp8.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5; Assign(Id "b", Int 7)])];};
      Hashtbl.add fileToAstMap "exp9.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b")); Assign (Id "b", Int 7)])];};
         Hashtbl.add fileToAstMap "exp9.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5; Assign(Id "b", Int 7)])];};
      Hashtbl.add fileToAstMap "exp0.k" {ast = [Function(Id "foo",[],[Dec(Id "a",Plus(Int 6,Int 3));Dec(Id "b",Plus (Int 4, Int 2))],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Plus(IdExp(Id "a"), IdExp(Id "b")); Assign (Id "b", Int 7)])];};
         Hashtbl.add fileToAstMap "exp0.k-opt" {ast = [Function(Id "foo",[],[Dec (Id "a",Int 9);Dec(Id "b",Int 6)],[Assign(Id "a", Int 3); Assign(Id "b",Int 2);Int 5; Assign(Id "b", Int 7)])];};
        Hashtbl.add fileToAstMap "expression-local-var.k" {ast = [];};
        Hashtbl.add fileToAstMap "expression-local-var.k-opt" {ast = [];};
        Hashtbl.add fileToAstMap "fun1.k" {ast = [];};
        Hashtbl.add fileToAstMap "fun1.k-opt" {ast = [];};
        Hashtbl.add fileToAstMap "fun2.k" {ast = [];};
        Hashtbl.add fileToAstMap "fun2.k-opt" {ast = [];};
