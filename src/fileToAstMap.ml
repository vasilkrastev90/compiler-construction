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
   Hashtbl.add fileToAstMap "exp1.k" {ast = [];};
   Hashtbl.add fileToAstMap "exp1.k-opt" {ast = [];};
(* Hashtbl.add fileToAstMap "exp2.k" {ast = [Function(Id "foo", [],[Plus (Times (Int 21,Int 5), Int 7)])] ;};
   Hashtbl.add fileToAstMap "exp3.k" {ast =[Function(Id "foo",[],[Minus(Plus (Times (Int 21, Int 2),Int 5),Times(Int 3,Int 4))])];};
   Hashtbl.add fileToAstMap "exp4.k" {ast = [Function(Id "foo", [], [IdExp (Id "id")])];};
   Hashtbl.add fileToAstMap "exp5.k" {ast = [Function(Id "foo", [],[Plus(IdExp(Id "id/"), IdExp (Id "id"))])];};
   Hashtbl.add fileToAstMap "exp6.k" {ast = [Function(Id "foo",[],[Write (IdExp (Id"id"))])];};
   Hashtbl.add fileToAstMap "exp7.k" {ast = [Function(Id "foo" ,[], [Read (Id "id")])];};
   Hashtbl.add fileToAstMap "exp8.k" {ast = [Function(Id "foo",[], [Assign (Id "id", Minus(Plus(Int 4, Int 5),Int 3), IdExp(Id "id"))])];};
   Hashtbl.add fileToAstMap "exp9.k" {ast = [Function(Id "foo", [], [Int 4; Plus(Int 5, Int 3);IdExp (Id "id")])];};
   Hashtbl.add fileToAstMap "exp10.k" {ast = [Function(Id "foo", [], [Assign(Id "x",Plus(Plus(Minus(Plus(Write (IdExp (Id "z")),Int 13),Times(Int 25,Int 6)),Read (Id "q")),Write (Int 5)), IdExp(Id "x"))])] ;};
    Hashtbl.add fileToAstMap "exp18.k" {ast = [Function(Id "foo", [], [IfThenElse(Gt(And(And(Or(Or(IdExp (Id "a"), IdExp (Id "b")),IdExp(Id "c")),Not(IdExp(Id "d"))),IdExp(Id "f")),Int 3),Minus(Plus(IdExp (Id "b"),Times (IdExp(Id "c"),IdExp(Id "f"))), Int 4),Int 8)])];};
    Hashtbl.add fileToAstMap "exp19.k" {ast = [Function(Id "foo", [], [IfThenElse(Gt(Plus(IdExp (Id "a"),IdExp (Id "b")),Int 3),IdExp(Id ("m")),IdExp(Id ("n")))])];};
    Hashtbl.add fileToAstMap "exp11.k" {ast = [];};
    Hashtbl.add fileToAstMap "exp12.k" {ast = [];};
    Hashtbl.add fileToAstMap "exp13.k" {ast = [];};
    Hashtbl.add fileToAstMap "exp14.k" {ast = [];};
    Hashtbl.add fileToAstMap "exp15.k" {ast = [];};
    Hashtbl.add fileToAstMap "exp16.k" {ast = [];};
    Hashtbl.add fileToAstMap "exp17.k" {ast = [];};
    Hashtbl.add fileToAstMap "exp18.k" {ast = [];};
    Hashtbl.add fileToAstMap "exp20.k" {ast = [];};
    Hashtbl.add fileToAstMap "exp21.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda1.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda2.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda3.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda4.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda5.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda6.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda7.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda8.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda9.k" {ast = [];};
    Hashtbl.add fileToAstMap "lambda10.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun1.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun2.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun3.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun4.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun5.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun6.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun7.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun8.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun9.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun10.k" {ast = [];};
    Hashtbl.add fileToAstMap "fib.k" {ast = [];};
    Hashtbl.add fileToAstMap "fact.k" {ast = [];};
    Hashtbl.add fileToAstMap "bin_pow.k" {ast = [];};
    Hashtbl.add fileToAstMap "simple-expression1.k" {ast = [Function(Id "foo",[],[Assign(Id "a",Int 3,Plus(IdExp(Id "a"), IdExp(Id "a")))])];};
    Hashtbl.add fileToAstMap "simple-expression1.k-opt" {ast = [Function(Id "foo", [], [Int 6])];};
    Hashtbl.add fileToAstMap "simple-expression2.k" {ast = [Function(Id "foo",[] ,[Assign(Id "a", Int 3,Assign(Id "b", Int 4,Assign(Id "c", Int 7,Minus(Plus(IdExp(Id "a"),IdExp(Id "b")),Div(Times(IdExp (Id "c"), IdExp(Id "a")),IdExp(Id "b"))))))])];};
    Hashtbl.add fileToAstMap "simple-expression2.k-opt" {ast = [Function(Id "foo",[],[Int 2])];};
    Hashtbl.add fileToAstMap "simple-expression3.k" {ast = [Function(Id "foo",[],[Minus(Plus(Plus(Int 3, Times(Int 3, Int 2)),Div(Int 52, Int 4)),Int 6)])];};
    Hashtbl.add fileToAstMap "simple-expression3.k-opt" {ast = [Function(Id "foo",[],[Int 16])];};
    Hashtbl.add fileToAstMap "lambda-expression1.k" {ast = [Function(Id "foo",[],[Assign(Id "a",Int 5, Assign (Id "b",Plus (IdExp(Id "a"),Int 3),Apply (Lambda (Id "x", Apply(IdExp (Id "x"), IdExp (Id "a"))),Lambda(Id "a", Plus(IdExp (Id "a"), Int 8)))))])];};
    Hashtbl.add fileToAstMap "lambda-expression1.k-opt" {ast = [Function(Id "foo",[],[Int 13])];};
    Hashtbl.add fileToAstMap "lambda-expression2.k" {ast = [Function(Id "foo",[],[Assign(Id "a",Int 5, Assign (Id "b",Plus (IdExp(Id "a"),Int 3),Apply (Lambda (Id "x", Apply(IdExp (Id "x"), IdExp (Id "a"))),Lambda(Id "b",Assign ( Id "a", IdExp (Id "b"),Plus(IdExp (Id "a"), Int 2))))))])];};
    Hashtbl.add fileToAstMap "lambda-expression2.k-opt" {ast = [Function (Id "foo" ,[], [Int 7])];};
    Hashtbl.add fileToAstMap "lambda-expression3.k" {ast = [Function(Id "foo",[],[Assign(Id "a",Int 5, Assign (Id "b",Plus (IdExp(Id "a"),Int 3),Plus(Apply (Lambda (Id "x", Plus(IdExp (Id "x"), Int 7)), IdExp (Id "a")), Int 8)))])];};
    Hashtbl.add fileToAstMap "lambda-expression3.k-opt" {ast = [Function(Id "foo", [], [Int 20])];};
    Hashtbl.add fileToAstMap "lambda-expression4.k" {ast = [Function(Id "foo",[],[Apply(Lambda(Id "x",Apply(IdExp (Id "x"), IdExp (Id "a"))),Lambda (Id "b", Plus (IdExp (Id "b"), Int 1)))])];};
    Hashtbl.add fileToAstMap "lambda-expression4.k-opt" {ast = [Function(Id "foo",[],[Apply(Lambda(Id "b",Plus(IdExp(Id "b"),Int 1)),IdExp (Id "a"))])];};   
    Hashtbl.add fileToAstMap "lambda-expression5.k" {ast = [Function(Id "foo", [],[Assign(Id "x", Lambda(Id "a",Plus(IdExp (Id "a"), Int 2)),Apply(IdExp (Id "x"), IdExp (Id "y")))])];};
    Hashtbl.add fileToAstMap "lambda-expression5.k-opt" {ast = [Function(Id "foo",[], [Apply(Lambda (Id "a", Plus(IdExp (Id "a"),Int 2)), IdExp (Id "y"))])];};   
    Hashtbl.add fileToAstMap "lambda-expression6.k" {ast = [Function(Id "foo",[],[Assign(Id "x",Lambda(Id "a",Plus(IdExp(Id "a"),Int 2)),Plus(Apply(IdExp(Id "x"),IdExp(Id "y" )),Apply(IdExp(Id "x"),IdExp(Id "z"))))])];}; 
    Hashtbl.add fileToAstMap "lambda-expression6.k-opt" {ast = [Function(Id "foo",[],[Assign(Id "x",Lambda(Id "a",Plus(IdExp(Id "a"),Int 2)),Plus(Apply(IdExp(Id "x"),IdExp(Id "y" )),Apply(IdExp(Id "x"),IdExp(Id "z"))))])];};
    Hashtbl.add fileToAstMap "fun-args1.k" {ast = [];};
    Hashtbl.add fileToAstMap "fun-args1.k-opt" {ast = [];};
    Hashtbl.add fileToAstMap "simple-expression-to-generate1.k" {ast = [];};
    Hashtbl.add fileToAstMap "simple-expression-to-generate1.k-opt"{ast = [];};
    Hashtbl.add fileToAstMap "simple-expression-to-generate2.k" {ast = [];};
    Hashtbl.add fileToAstMap "simple-expression-to-generate2.k-opt"{ast = [];};
    Hashtbl.add fileToAstMap "simple-expression-to-generate3.k" {ast = [];};
    Hashtbl.add fileToAstMap "simple-expression-to-generate3.k-opt"{ast = [];};
    Hashtbl.add fileToAstMap "simple-expression-to-generate4.k" {ast = [];};
    Hashtbl.add fileToAstMap "simple-expression-to-generate4.k-opt"{ast = [];};
    Hashtbl.add fileToAstMap "expression1.k"{ast = [];};
*)
