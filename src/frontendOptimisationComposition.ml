open ConstantPropagation
open ConstantFolding
open Inlining

let rec constant_elimination ast = let ast' = ast |> const_prop |> fold_const in
                                         if ast' = ast then ast' else constant_elimination ast'
