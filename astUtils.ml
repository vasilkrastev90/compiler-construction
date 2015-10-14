open Ast
open Printf

let rec print_spaces n = match n with
| 0 -> ();
| m -> print_string "   "; print_spaces (m-1)

let print_id id n = match id with
| Id s -> print_spaces n; printf "Id %s\n" s

let rec print_exp e n = match e with
| Int i -> print_spaces n; printf "Int %d\n" i
| String s ->print_spaces n; printf "String %s\n" s
| IdExp id -> print_spaces n; print_string("IdExp\n"); print_id id (n+1)
| Plus (e1,e2) -> print_spaces n; print_string "Plus\n"; print_exp e1 (n+1); print_exp e2 (n+1)
| Minus (e1,e2) -> print_spaces n; print_string "Minus\n"; print_exp e1 (n+1); print_exp e2 (n+1)
| Times (e1,e2) -> print_spaces n; print_string "Times\n"; print_exp e1 (n+1);  print_exp e2 (n+1)
| Assign (id,e1) ->print_spaces n; print_string "=\n";print_id id (n+1); print_exp e1 (n+1)
| Read id -> print_spaces n; print_string "Read\n"; print_id id (n+1)
| Write e1 ->  print_spaces n; print_string "Write\n"; print_exp e1 (n+1)

 
 
let rec print_progr es = match es with
| [] -> ()
| hd::tl -> print_exp hd 0; print_string "\n\n\n";print_progr tl

