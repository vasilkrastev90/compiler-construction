open Printf

type id = Id of string

type exp = Int of int
           | String of string
           | IdExp of id
           | Plus of (exp * exp)
           | Minus of (exp * exp)
           | Times of (exp * exp)
           | Assign of (id * exp)
           | Read of id
           | Write of exp 

type program = exp list
