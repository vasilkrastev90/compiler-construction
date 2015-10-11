open AstUtils

let rec loop () =
  let line = read_line () in
  if (line <> "exit") then begin
   line
   |> Lexing.from_string
   |> Lan_par.top Lan_lex.read
   |> AstUtils.print_progr;
   print_newline ();
   loop ()
  end
  else ()
   
let _ = loop ()
