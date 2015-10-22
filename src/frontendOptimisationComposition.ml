open ConstantPropagation
open ConstantFolding
open Inlining

let rec constant_elimination ast = let ast' = ast |> inline|> const_prop |> fold_const in
                                         if ast' = ast then ast' else constant_elimination ast'
