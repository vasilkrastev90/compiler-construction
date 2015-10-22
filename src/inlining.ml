open Ast
open AstUtils

let rec inline_function_int id lambda_function e = match e with
| Int n -> Int n
| IdExp x -> IdExp x
| Plus (e1,e2) -> Plus (inline_function_int id lambda_function e1, inline_function_int id lambda_function e2)
| Minus (e1,e2) -> Minus (inline_function_int id lambda_function e1, inline_function_int id lambda_function  e2)
| Times (e1,e2) -> Times (inline_function_int id lambda_function e1, inline_function_int id lambda_function  e2)
| Div(e1,e2) -> Div (inline_function_int id lambda_function e1, inline_function_int id lambda_function e2)
| Mod (e1,e2) -> Mod (inline_function_int id lambda_function e1, inline_function_int id lambda_function e2)
| And (e1,e2) -> And (inline_function_int id lambda_function e1, inline_function_int id lambda_function e2)
| Or (e1,e2) -> Or (inline_function_int id lambda_function e1, inline_function_int id lambda_function e2)
| Gt (e1,e2) -> Gt (inline_function_int id lambda_function e1, inline_function_int id lambda_function e2)
| Lt (e1,e2) -> Lt (inline_function_int id lambda_function e1, inline_function_int id lambda_function e2)
| Eq (e1,e2) -> Eq (inline_function_int id lambda_function e1, inline_function_int id lambda_function e2)
| Not e1 -> Not (inline_function_int id lambda_function e1)
| IfThenElse (e1,e2,e3) -> IfThenElse(inline_function_int id lambda_function e1, inline_function_int id lambda_function e2, inline_function_int id lambda_function e3)
| Apply (IdExp x, e) -> if x = id then Apply (lambda_function, e) else Apply(IdExp x, e)
| Apply (e1,e2) -> Apply(inline_function_int id lambda_function e1, inline_function_int id lambda_function e2)
| Lambda (id',e1) -> if id'=id then Lambda(id',e1) else Lambda(id',inline_function_int id lambda_function e1)
| Assign (id',e1,e2) -> if id'=id then Assign(id',e1,e2) else Assign(id' ,inline_function_int id lambda_function e1, inline_function_int id lambda_function e2) 
| Read id' -> Read id'
| Write e1 -> Write (inline_function_int id lambda_function e1)


let rec used_once id exp n = match exp with
| Int n -> n
| IdExp x -> if x = id then n+1 else n
| Plus (e1,e2) -> used_once id e1 n + used_once id e2 n
| Minus (e1,e2) -> used_once id e1 n + used_once id e2 n
| Times (e1,e2) -> used_once id e1 n + used_once id e2 n
| Div(e1,e2) ->  used_once id e1 n + used_once id e2 n
| Mod (e1,e2) ->  used_once id e1 n + used_once id e2 n
| And (e1,e2) -> used_once id e1 n + used_once id e2 n
| Or (e1,e2) -> used_once id e1 n + used_once id e2 n
| Gt (e1,e2) -> used_once id e1 n + used_once id e2 n
| Lt (e1,e2) -> used_once id e1 n + used_once id e2 n
| Eq (e1,e2) -> used_once id e1 n + used_once id e2 n
| Not e1 -> used_once id e1 n 
| IfThenElse (e1,e2,e3) ->used_once id e1 n + used_once id e2 n  + used_once id e3 n
| Apply (IdExp x, e) -> if x = id then n+1 else used_once id e n
| Apply (e,IdExp x) -> if x = id then  n+1 else used_once id e n 
| Apply (e1,e2) -> used_once id e1 n + used_once id e2 n
| Lambda (id',e1) -> if id'=id then n else used_once id e1 n
| Assign (id',e1,e2) -> if id'=id then used_once id e1 n else used_once id e1 n + used_once id e2 n 
| Read id' -> n
| Write e1 -> used_once id e1 n



let rec inline_exp exp = match exp with
| Int n -> Int (n)
| IdExp x -> IdExp x
| Plus (e1,e2) -> Plus (inline_exp e1, inline_exp e2)
| Minus (e1,e2) -> Minus (inline_exp e1, inline_exp e2)
| Times (e1,e2) -> Times (inline_exp e1, inline_exp e2)
| Div(e1,e2) -> Div (inline_exp e1, inline_exp e2)
| Mod (e1,e2) -> Mod (inline_exp e1, inline_exp e2)
| And (e1,e2) -> And (inline_exp e1, inline_exp e2)
| Or (e1,e2) -> Or (inline_exp e1, inline_exp e2)
| Gt (e1,e2) -> Gt (inline_exp e1, inline_exp e2)
| Lt (e1,e2) -> Lt (inline_exp e1, inline_exp e2)
| Eq (e1,e2) -> Eq (inline_exp e1, inline_exp e2)
| Not e1 -> Not (inline_exp e1)
| IfThenElse (e1,e2,e3) -> IfThenElse(inline_exp e1, inline_exp e2, inline_exp e3)
| Apply (Lambda (id,e1), Lambda(id',e2)) -> if used_once id e1 0 = 1 then inline_function_int id (Lambda (id', e2)) e1 |> inline_exp
                                            else Apply(Lambda(id,e1),Lambda(id',e2))
| Apply (e1,e2) -> Apply(inline_exp e1, inline_exp e2)
| Lambda (id,e2) -> Lambda(id, inline_exp e2)
| Assign (id,Lambda(id',e1),e2) -> if used_once id e2 0 = 1 then inline_function_int id (Lambda(id',e1)) e2 |> inline_exp
                                   else Assign(id,Lambda(id',e1),inline_exp e2)
| Assign (id,e1,e2) ->Assign(id,inline_exp e1, inline_exp e2)
| Read id -> Read id
| Write e1 -> Write (inline_exp e1)

let rec inline_expls expls = match expls with
| hd::tl -> inline_exp hd :: inline_expls tl
| [] -> []


let inline_func f = match f with
| Function (x,argls,expls) -> Function(x,argls, inline_expls expls)

let rec inline_function_list ast = match ast with
| hd::tl -> inline_func hd :: inline_function_list tl
| [] -> []

let inline = inline_function_list

