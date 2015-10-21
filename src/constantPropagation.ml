open Ast
open AstUtils

let rec propagate_constant_int id n e = match e with
| Int n -> Int n
| IdExp x -> if x=id then Int n else IdExp x
| Plus (e1,e2) -> Plus (propagate_constant_int id n e1, propagate_constant_int id n e2)
| Minus (e1,e2) -> Minus (propagate_constant_int id n e1, propagate_constant_int id n  e2)
| Times (e1,e2) -> Times (propagate_constant_int id n e1, propagate_constant_int id n  e2)
| Div(e1,e2) -> Div (propagate_constant_int id n e1, propagate_constant_int id n e2)
| Mod (e1,e2) -> Mod (propagate_constant_int id n e1, propagate_constant_int id n e2)
| And (e1,e2) -> And (propagate_constant_int id n e1, propagate_constant_int id n e2)
| Or (e1,e2) -> Or (propagate_constant_int id n e1, propagate_constant_int id n e2)
| Gt (e1,e2) -> Gt (propagate_constant_int id n e1, propagate_constant_int id n e2)
| Lt (e1,e2) -> Lt (propagate_constant_int id n e1, propagate_constant_int id n e2)
| Eq (e1,e2) -> Eq (propagate_constant_int id n e1, propagate_constant_int id n e2)
| Not e1 -> Not (propagate_constant_int id n e1)
| IfThenElse (e1,e2,e3) -> IfThenElse(propagate_constant_int id n e1, propagate_constant_int id n e2, propagate_constant_int id n e3)
| Apply (e1,e2) -> Apply(propagate_constant_int id n e1, propagate_constant_int id n e2)
| Lambda (id',e1) -> if id'=id then Lambda(id',e1) else Lambda(id',propagate_constant_int id n e1)
| Assign (id',e1,e2) -> if id'=id then Assign(id',e1,e2) else Assign(id' ,propagate_constant_int id n e1, propagate_constant_int id n e2) 
| Read id' -> Read id'
| Write e1 -> Write (propagate_constant_int id n e1)


(*
let propagate_if_constant id e1 e2 = match e1 with 
| Int n -> propagate_constant_int id n e2  
| x -> e2
*)

let rec const_prop_exp exp = match exp with
| Int n -> Int (n)
| IdExp x -> IdExp x
| Plus (e1,e2) -> Plus (const_prop_exp e1, const_prop_exp e2)
| Minus (e1,e2) -> Minus (const_prop_exp e1, const_prop_exp e2)
| Times (e1,e2) -> Times (const_prop_exp e1, const_prop_exp e2)
| Div(e1,e2) -> Div (const_prop_exp e1, const_prop_exp e2)
| Mod (e1,e2) -> Mod (const_prop_exp e1, const_prop_exp e2)
| And (e1,e2) -> And (const_prop_exp e1, const_prop_exp e2)
| Or (e1,e2) -> Or (const_prop_exp e1, const_prop_exp e2)
| Gt (e1,e2) -> Gt (const_prop_exp e1, const_prop_exp e2)
| Lt (e1,e2) -> Lt (const_prop_exp e1, const_prop_exp e2)
| Eq (e1,e2) -> Eq (const_prop_exp e1, const_prop_exp e2)
| Not e1 -> Not (const_prop_exp e1)
| IfThenElse (e1,e2,e3) -> IfThenElse(const_prop_exp e1, const_prop_exp e2, const_prop_exp e3)
| Apply (e1,e2) -> Apply(const_prop_exp e1, const_prop_exp e2)
| Lambda (id,e2) -> Lambda(id, const_prop_exp e2)
| Assign (id,Int n,e2) -> propagate_constant_int id n e2
| Assign (id,e1,e2) -> (*think about that*)Assign(id,const_prop_exp e1, const_prop_exp e2)
| Read id -> Read id
| Write e1 -> Write (const_prop_exp e1)

let rec const_prop_expls expls = match expls with
| hd::tl -> const_prop_exp hd :: const_prop_expls tl
| [] -> []


let const_prop_func f = match f with
| Function (x,argls,expls) -> Function(x,argls, const_prop_expls expls)

let rec const_prop_function_list ast = match ast with
| hd::tl -> const_prop_func hd :: const_prop_function_list tl
| [] -> []

let const_prop = const_prop_function_list

