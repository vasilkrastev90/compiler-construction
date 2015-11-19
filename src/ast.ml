open Printf

type id = Id of string

type exp = Int of int
           | IdExp of id
           | Plus of (exp * exp)
           | Minus of (exp * exp)
           | Times of (exp * exp)
           | Div of (exp * exp)
           | Mod of (exp * exp)
           | And of (exp * exp)
           | Or of (exp * exp)
           | Gt of (exp * exp)
           | Lt of (exp * exp)
           | Eq of (exp * exp)
           | Not of exp
           | IfThenElse of (exp * exp * exp)
           | Apply of (id*exp list)
           | Lambda of (id * exp)
           | Assign of (id * exp)
           | Read of id
           | Write of exp 


type dec = Dec of (id * exp)          
          
type arg = id

type func = Function of (id * arg list * dec list * exp list)

type program = func list
