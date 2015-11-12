open Ast
open Printf

let rec print_spaces n = match n with
| 0 -> ();
| m -> print_string "   "; print_spaces (m-1)

let print_id id n = match id with
| Id s -> print_spaces n; printf "Id %s\n" s

let rec print_exp e n = match e with
| Int i -> print_spaces n; printf "Int %d\n" i
| IdExp id -> print_spaces n; print_string("IdExp\n"); print_id id (n+1)
| Plus (e1,e2) -> print_spaces n; print_string "Plus\n"; print_exp e1 (n+1); print_exp e2 (n+1)
| Minus (e1,e2) -> print_spaces n; print_string "Minus\n"; print_exp e1 (n+1); print_exp e2 (n+1)
| Times (e1,e2) -> print_spaces n; print_string "Times\n"; print_exp e1 (n+1);  print_exp e2 (n+1)
| Div (e1,e2) -> print_spaces n; print_string "Div\n"; print_exp e1 (n+1);  print_exp e2 (n+1)
| Mod (e1,e2) -> print_spaces n; print_string "Mod\n"; print_exp e1 (n+1);  print_exp e2 (n+1)
| And (e1,e2) -> print_spaces n; print_string "And\n"; print_exp e1 (n+1);  print_exp e2 (n+1)
| Or (e1,e2) -> print_spaces n; print_string "Or\n"; print_exp e1 (n+1);  print_exp e2 (n+1)
| Gt (e1,e2) -> print_spaces n; print_string "Gt\n"; print_exp e1 (n+1);  print_exp e2 (n+1)
| Lt (e1,e2) ->  print_spaces n; print_string "Lt\n"; print_exp e1 (n+1);  print_exp e2 (n+1)
| Eq (e1,e2) ->  print_spaces n; print_string "Eq\n"; print_exp e1 (n+1);  print_exp e2 (n+1)
| Not e1 ->  print_spaces n; print_string "Not\n"; print_exp e1 (n+1)
| Assign (id,e1) ->print_spaces n; print_string "=\n";print_id id (n+1); print_exp e1 (n+1);
| Apply (e1,e2) -> print_spaces n; print_string "Apply\n"; print_exp e1 (n+1); print_exp e2 (n+1)
| Lambda (id,e1) -> print_spaces n; print_string "Lambda\n";  print_id id (n+1); print_exp e1 (n+1)
| Read id -> print_spaces n; print_string "Read\n"; print_id id (n+1)
| Write e1 ->  print_spaces n; print_string "Write\n"; print_exp e1 (n+1)
| IfThenElse(e1,e2,e3) -> print_spaces n; print_string "If\n"; print_exp e1 (n+1); print_spaces n; print_string "Then\n"; print_exp e2 (n+1); print_spaces n; print_string "Else\n"; print_exp e3 (n+1)  

let rec print_args args  = match args with
| [] -> print_string "\n"
| (Id x)::tl -> print_string x; print_spaces 1; print_args tl

let rec print_es es n = match es with 
| [] -> ()
| hd::tl -> print_exp hd 0; print_string "\n\n\n"; print_es tl 0


let print_dec (declaration:dec) = match declaration with
| Dec (id,exp) -> print_string "TO BE IMPLEMENTED \n"

let print_decs decs = List.iter print_dec decs


let  print_func f = match f with
 | Function(Id id,args,decs,es) -> print_string ("Function:" ^ id ^ "\n"); print_args args ; print_decs decs;print_es es 0

 
let rec print_progr fs = match fs with
| [] -> ()
| hd :: tl -> print_func hd; print_string "\n\n\n"; print_progr tl

