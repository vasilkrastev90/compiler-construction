open Ast
open AstUtils
open Printf
open Lexing
open Lan_lex
open FileToAstMap

let print_position lexbuf =   let pos = lexbuf.lex_curr_p in   
                              eprintf "Pos %d:%d:%d\n" pos.pos_lnum pos.pos_bol pos.pos_cnum

let rec read_file channel res = try while true do 
                                res := !res ^ input_line channel;
                                done
                                with 
                                | End_of_file -> ()
                               

                                 
let parse_with_error lexbuf = try Lan_par.top Lan_lex.read lexbuf with   
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


let execute_tests directoryPath fileName =
    let program = directoryPath ^ fileName |> open_in in
    let result = ref "" in
    read_file program result;
    let fileInfo  = Hashtbl.find fileToAstMap fileName in
    print_string fileInfo.formatString;  
    parse_with_error (Lexing.from_string !result) = fileInfo.ast 
           |> printf ("%B\n");
    close_in program
    
let _ = if Array.length Sys.argv >1  && Sys.argv.(1) = "test-parser" then 
           for i =2 to (Array.length Sys.argv)-1 do
             let directoryPath = "./"^ Sys.argv.(1) ^"/" ^ Sys.argv.(i) ^ "/" in
             let fileNamesArray = directoryPath |> Sys.readdir in
              Array.iter (fun fileName ->  execute_tests directoryPath fileName) fileNamesArray
           done
        else begin
          print_string "You are in the parser interactive mode please type in expressions and an ast will be generated for you \n";
          (Buffer.create 1)
              |> loop_interactive
        end  
