open Ast
open AstUtils


let rec fold_const_exp e = match e with
| Int n -> Int n
| IdExp x -> IdExp x
| Plus(Int n, Int m) -> Int (n+m) 
| Plus (e1,e2) -> Plus (fold_const_exp e1, fold_const_exp e2)
| Minus (Int n, Int m) -> Int (n-m)
| Minus (e1,e2) -> Minus (fold_const_exp e1, fold_const_exp  e2)
| Times (Int n, Int m) -> Int(n*m) 
| Times (e1,e2) -> Times (fold_const_exp e1, fold_const_exp  e2)
| Div (Int n, Int m) -> Int(n/m)
| Div(e1,e2) -> Div (fold_const_exp e1, fold_const_exp e2)
| Mod (e1,e2) -> Mod (fold_const_exp e1, fold_const_exp e2)
| And (e1,e2) -> And (fold_const_exp e1, fold_const_exp e2)
| Or (e1,e2) -> Or (fold_const_exp e1, fold_const_exp e2)
| Gt (e1,e2) -> Gt (fold_const_exp e1, fold_const_exp e2)
| Lt (e1,e2) -> Lt (fold_const_exp e1, fold_const_exp e2)
| Eq (e1,e2) -> Eq (fold_const_exp e1, fold_const_exp e2)
| Not e1 -> Not (fold_const_exp e1)
| IfThenElse (e1,e2,e3) -> IfThenElse(fold_const_exp e1, fold_const_exp e2, fold_const_exp e3)
| Apply (id,es) -> Apply(id,fold_const_expls es)
| Lambda (id,e1) -> Lambda(id, fold_const_exp e1)
| Assign (id,e1) -> Assign(id, fold_const_exp e1)
| Read id -> Read id
| Write e1 -> Write (fold_const_exp e1)
| x -> x
and
fold_const_expls expls = match expls with
| hd::tl -> fold_const_exp hd :: fold_const_expls tl
| [] -> []

let rec fold_const_decs decs = match decs with
| Dec((Id id), e)::tl -> Dec((Id id), (fold_const_exp e)) :: fold_const_decs tl
| [] -> []

let fold_const_func f = match f with
| Function (x,argls,decs,expls) -> Function(x,argls,fold_const_decs decs,fold_const_expls expls)

let rec fold_const_function_list ast = match ast with
| hd::tl -> fold_const_func hd :: fold_const_function_list tl
| [] -> []

let rec fold_const ast  = let ast' = fold_const_function_list ast in
                      if ast' = ast then ast' else fold_const ast'

