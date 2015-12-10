open Ast
open AstUtils


(*let addDecsToHash decs hashTable = match decs with
| Dec((Id id,Int n), Int n):: tl -> Hashtbl.add hashTable id n; addDecsToHash tl hashTable
| Dec::tl -> addDecsToHash tl
| [] -> () *)

let rec check_for_assignment hashTable (e:Ast.exp )= match e with
| Plus (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| Minus (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| Times (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| Div (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| Mod (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| And (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| Or (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| Gt (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| Lt (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| Eq (e1,e2) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2
| Not (e1) -> check_for_assignment hashTable e1
| IfThenElse (e1,e2,e3) -> check_for_assignment hashTable e1; check_for_assignment hashTable e2; check_for_assignment hashTable e3
| Apply (Id id, es) -> List.iter (check_for_assignment hashTable) es
| Assign (Id x,e1)  -> if Hashtbl.mem hashTable x then Hashtbl.remove hashTable x else () 
| Write e -> check_for_assignment hashTable e
| _ -> ()

let rec const_prop_exp hashTable exp = let const_prop_exp' = const_prop_exp hashTable in
 match exp with
| Int n -> Int (n)
| IdExp (Id x) -> if Hashtbl.mem hashTable x then Int (Hashtbl.find hashTable x) else IdExp (Id x)
| Plus (e1,e2) -> Plus (const_prop_exp' e1, const_prop_exp' e2)
| Minus (e1,e2) -> Minus (const_prop_exp' e1, const_prop_exp' e2)
| Times (e1,e2) -> Times (const_prop_exp' e1, const_prop_exp' e2)
| Div(e1,e2) -> Div (const_prop_exp' e1, const_prop_exp' e2)
| Mod (e1,e2) -> Mod (const_prop_exp' e1, const_prop_exp' e2)
| And (e1,e2) -> And (const_prop_exp' e1, const_prop_exp' e2)
| Or (e1,e2) -> Or (const_prop_exp' e1, const_prop_exp' e2)
| Gt (e1,e2) -> Gt (const_prop_exp' e1, const_prop_exp' e2)
| Lt (e1,e2) -> Lt (const_prop_exp' e1, const_prop_exp' e2)
| Eq (e1,e2) -> Eq (const_prop_exp' e1, const_prop_exp' e2)
| Not e1 -> Not (const_prop_exp' e1)
| Assign((Id id), (Int n)) as e-> let _ = Hashtbl.replace hashTable id n in
                                          e
| Assign((Id id), e')  as e -> let _ = Hashtbl.remove hashTable id in
                                       e
| Block(decs,es) -> if List.length decs =0 then
                    let _ = List.iter (check_for_assignment hashTable) es in
                    Block(decs,const_prop_expls hashTable es)
                    else let _ = Hashtbl.clear hashTable in
                         Block(decs,es)
                          
| Write (IdExp (Id x)) -> if Hashtbl.mem hashTable x then Write (Int (Hashtbl.find hashTable x)) else Write (IdExp (Id x))
| Write e1 -> Write (const_prop_exp' e1)
|t -> t
and
const_prop_expls hashTable expls = match expls with
| hd::tl -> let hd' = const_prop_exp hashTable hd in 
                hd' :: const_prop_expls hashTable tl
| [] -> []


let rec propagate_const_decs hashTable decs = match decs with
| Dec((Id id), (Int n))::tl -> let _ = Hashtbl.add hashTable id n in
                           Dec((Id id),(Int n)):: propagate_const_decs hashTable tl
| Dec((Id id, e))::tl -> Dec((Id id), (const_prop_exp hashTable e)):: propagate_const_decs hashTable tl 
| [] -> []

let const_prop_func f = match f with
| Function (x,argls,decs,expls) -> 
                let hashTable = Hashtbl.create (List.length decs) in
                let decs' = propagate_const_decs hashTable decs in
                let expls' = const_prop_expls hashTable expls in
                Function(x,argls,decs',expls')
                

let rec const_prop_function_list ast = match ast with
| hd::tl -> const_prop_func hd :: const_prop_function_list tl
| [] -> []

let const_prop = const_prop_function_list
