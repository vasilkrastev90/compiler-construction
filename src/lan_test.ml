open Ast
open AstUtils
open Printf
open Lexing
open Lan_lex
open FileToAstMap
open FrontendOptimisationComposition

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

let rec loop_interactive compile_function optimisation_function is_optimisable buf =
  let line = read_line () in
  if (line <> "") then begin
   Buffer.add_string buf line;
   Buffer.add_string buf "\n";
   loop_interactive compile_function optimisation_function is_optimisable buf
  end
  else begin 
       let optimisation_function_if_needed = if is_optimisable then fun lexbuf -> lexbuf |> compile_function |> optimisation_function
       else compile_function  in
       buf
       |> Buffer.contents
       |> Lexing.from_string
       |> compile_function
       |> AstUtils.print_progr;
       print_newline ();
       end


let execute_tests directorypath filename compile_function optimisation_function is_optimisable =
    let program = directorypath ^ filename |> open_in in
    let result = ref "" in
    read_file program result;
    let fileInfo  = Hashtbl.find fileToAstMap filename in
    compile_function (Lexing.from_string !result) = fileInfo.ast 
           |> printf "the program in %s should parsed as exptected: %B\n" filename;
    if is_optimisable then let optFileInfo = Hashtbl.find fileToAstMap (filename ^ "-opt") in
      Lexing.from_string !result |> compile_function |> optimisation_function = optFileInfo.ast |> printf ("the program in %s should be optimised as  expected: %B\n") filename;
    else ();
    close_in program



let execute_tests_over_dir dirname compile_function optimisation_function is_optimisable =
     let filenamesArray = dirname |> Sys.readdir in
              Array.iter (fun fileName ->  execute_tests dirname fileName compile_function optimisation_function is_optimisable) filenamesArray


let compile_test dirnames is_optimisable  =
  let compile_function = parse_with_error in
  let optimisation_function = constant_elimination in
    List.iter (fun dirname -> execute_tests_over_dir dirname compile_function optimisation_function is_optimisable) dirnames 


let compile_interact directorypath filename is_optimisable = print_string "You are in the parser interactive mode please type in expressions and an ast will be generated for you \n";
         let compile_function = parse_with_error in
         let optimisation_function = constant_elimination in
         if filename = "-" then 
          (Buffer.create 1)
              |> loop_interactive compile_function optimisation_function is_optimisable
          else begin 
           let program = directorypath ^ filename |> open_in in
           let result = ref "" in
           read_file program result;
           let fileInfo  = Hashtbl.find fileToAstMap filename in
           compile_function (Lexing.from_string !result) = fileInfo.ast 
           |> printf "the program in %s should parsed as exptected: %B\n" filename;
           Lexing.from_string !result |> compile_function |> AstUtils.print_progr;
    if is_optimisable then begin let optFileInfo = Hashtbl.find fileToAstMap (filename ^ "-opt") in
       Lexing.from_string !result |> compile_function |> optimisation_function = optFileInfo.ast |> printf ("the programe in %s should be optimised as  expected: %B\n") filename;
         Lexing.from_string !result |> compile_function |> optimisation_function |>  AstUtils.print_progr;         
         end
         else ();
         close_in program
         end



let test =
  let open Core.Std in
  Command.basic
    ~summary:"A compiler for a toy language used for a university module"
    ~readme:(fun () -> "More detailed information")
    Command.Spec.(
      empty
      +> anon (sequence ("filename" %: file))
      +> flag "--fe-opt" no_arg ~doc:"turn on front end optimisations"
     )
    (fun dirnames is_optimisable () -> compile_test dirnames is_optimisable)


let interact =  let open Core.Std in 
    Command.basic
    ~summary:"A compiler for a toy language used for a university module"
    ~readme:(fun () -> "More detailed information")
    Command.Spec.(
      empty
      +> flag "--directory"  (optional_with_default "-" file) ~doc: "directory name"
      +> flag "--filename"  (optional_with_default "-"  file) ~doc: "filename"
      +> flag "--fe-opt" no_arg ~doc:"turn on front end optimisations"
     )
    (fun directorypath filename is_optimisable () -> compile_interact directorypath filename is_optimisable)
 
let command = let open Core.Std in
  Command.group ~summary:"Manipulate dates"
    [ "test", test; "interact", interact ]

let _ = let open Core.Std in
        Command.run command
