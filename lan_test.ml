open Ast
open AstUtils
open Core.Std
open Printf
open Lexing
open Lan_lex

let print_position lexbuf =   let pos = lexbuf.lex_curr_p in   
                              eprintf "Pos %d:%d:%d\n" pos.pos_lnum pos.pos_bol pos.pos_cnum

let parse_with_error lexbuf =   try Lan_par.top Lan_lex.read lexbuf with   
| SyntaxError msg -> prerr_string (msg ^ ": ");                        
  print_position lexbuf;
  []                           
| Lan_par.Error ->   prerr_string "Parse error:";                        
  print_position lexbuf;                        
  []

let rec loop_interactive buf =
  let line = read_line () in
  if (line <> "") then begin
   Buffer.add_string buf line;
   Buffer.add_string buf "\n";
   loop_interactive buf
  end
  else begin 
       buf
       |> Buffer.contents
       |> Lexing.from_string
       |> parse_with_error
       |> AstUtils.print_progr;
       print_newline ();
       end

       
   
let execute_tests () = 
    parse_with_error (Lexing.from_string "3+4") = [Plus (Int 3, Int 4)]
         |> printf ("3+4 should be parsed correctly as Plus(Int 3, Int 4): %B\n");
    parse_with_error (Lexing.from_string "21*5+7") =[Plus (Times (Int 21,Int 5), Int 7)]
         |> printf ("21*5+7 should be parsed corectly Plus (Times (Int 21,Int 5), Int 7): %B\n");    
    parse_with_error (Lexing.from_string "21*2+5-3*4") = [Minus(Plus (Times (Int 21, Int 2),Int 5),Times(Int 3,Int 4))]
         |> printf ("21*2+5-3*4 should be parsed corectly Minus(Plus (Times (Int 21,Int 2),Int 5),Times(Int 3,Int 4)): %B\n");
    parse_with_error (Lexing.from_string "id") = [IdExp (Id "id")]
         |> printf ("id should be parsed correctly IdExp (Id id): %B\n" );
    parse_with_error (Lexing.from_string "id + id") = [Plus(IdExp(Id "id"), IdExp (Id "id"))]
         |> printf ("id + id should be parsed correctly Plus (IdExp (Id\"id\"), IdExp (Id \"id\")): %B\n");
    parse_with_error(Lexing.from_string "print id") = [Write (IdExp (Id"id"))]
         |>printf("print id should be parsed correctly Write (IdExp (Id \"id\")): %B\n");
    parse_with_error(Lexing.from_string "read id") = [Read (Id "id")]
         |>printf("read id should be parsed correctly Read (Id (Id \"id\")): %B\n");
    parse_with_error(Lexing.from_string "id = 4+5-3") = [Assign (Id "id", Minus(Plus(Int 4, Int 5),Int 3))]    
         |>printf("id = 4+5-3 should be parsed correctly  Assign (Id \"id\", Minus(Plus(Int 4, Int 5),Int 3)): %B\n");
    parse_with_error(Lexing.from_string "4;5+3;id") = [Int 4; Plus(Int 5, Int 3);IdExp (Id "id")]
         |>printf("4;5+3;id should be parsed correctly [Int 4, Plus(Int 5, Int 3),IdExp (Id \"id\")]: %B\n");
    parse_with_error (Lexing.from_string "x =print z + 13 - 25*6 + read q + print 5") = [Assign(Id "x",Minus(Plus(Write (IdExp (Id "z")),Int 13),Plus(Plus(Times(Int 25,Int 6),Read (Id "q")),Write (Int 5))))]
         |> printf ("x =print z + 13 - 25*6 + read q + print 5 should be parsed Assign(Id \"x\",Minus(Plus(Write (IdExp (Id \"z\")),Int 13),Plus(Plus(Times(Int 25,Int 6),Read (Id \"q\")),Write (Int 5)))): %B\n");
    parse_with_error (Lexing.from_string " ") = []
         |> printf("empty string should be parsed correctly as empty list: %B\n");
    parse_with_error (Lexing.from_string "4;") = []
         |> printf("last expresion in the list:4; terminating with semicolon should cause a parsing error: %B\n");
    parse_with_error (Lexing.from_string "3;5+2;var;") = []
         |> printf ("last expresion in the list:3;5+2;var; terminating with semicolon should cause a parsing error: %B\n");
    parse_with_error(Lexing.from_string "x==3") = [] 
         |> printf("incorrect token in assignment: x==3 should cause parse error %B\n");
    parse_with_error(Lexing.from_string "3=3") = []
         |> printf("incorrect token in assignment: 3=3 should cause parse error %B\n");
    parse_with_error(Lexing.from_string "read 3") = []
         |> printf("trying to read an integer in read 3 should cause parse error: %B\n");
    parse_with_error (Lexing.from_string "3++5") = []
         |> printf ("duplicated + symbols should cause an error: %B\n")

let _ = if Array.length Sys.argv >1  && Sys.argv.(1) = "test" then 
           execute_tests ()
        else  (Buffer.create 1)
              |> loop_interactive 
