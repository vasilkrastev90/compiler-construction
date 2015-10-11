open Printf

type exp = Int of int
           | String of string
           | Id of string
           | Plus of (exp * exp)
           | Minus of (exp * exp)
           | Times of (exp * exp)
           | Assign of (string * exp)
           | Read of exp
           | Write of exp 

type program = exp list
