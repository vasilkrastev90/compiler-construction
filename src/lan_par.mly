%{open Ast %}
%token <int> INT
%token <string> ID
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token MOD
%token NOT
%token AND
%token OR
%token LT
%token GT
%token EQ
%token WRITE
%token READ
%token SEMICOLON
%token RBRACKET
%token LBRACKET
%token LCURLY
%token RCURLY
%token ASSIGN
%token LET
%token IF
%token THEN
%token ELSE
%token LAMBDA
%token ARROW
%token BEGIN
%token END
%token DECL
%token LCED
%token EOF
%token COMMA
%token REPEAT
%token WHILE
%token DO
%token FOR
%token TO
%token BREAK
%nonassoc ARROW ASSIGN
%nonassoc ELSE
%nonassoc LT GT EQ
%left MINUS PLUS
%left TIMES DIV MOD
%left AND OR
%right NOT
%left WRITE
%start <Ast.program> top
%%

top:
  | ls = funclist EOF {ls}

revfunclist:
  | (*empty *) {[]}
  | ls = revfunclist; f = func {f :: ls}

funclist: 
  | ls = revfunclist; {List.rev ls}

explist:
  |ls = separated_list(SEMICOLON, exp) {ls}  

argexplist:
  |ls = separated_list(COMMA, exp) {ls}

revarglist:
  | (*empty*){[]}
  | ls = revarglist; var = ID {(Id var)::ls}


arglist: 
  | ls = revarglist {List.rev ls}


dec: 
  | LET; var = ID; ASSIGN; e1 = exp; {Dec(Id var,e1)}

declist:  
  | ls = separated_list(SEMICOLON,dec) {ls}

func:
  | LET; var = ID; args = arglist; ASSIGN; DECL decs = declist LCED BEGIN es = explist; END {Function(Id var,args,decs,es)}

exp:
  | i = INT {Int i}
  | e1 = exp; PLUS; e2 = exp {Plus (e1, e2)}
  | e1 = exp; TIMES; e2 = exp {Times (e1, e2)}
  | e1 = exp; MINUS; e2 = exp {Minus (e1, e2)}
  | e1 = exp; DIV;   e2 = exp {Div (e1,e2)}
  | e1 = exp; MOD;   e2 = exp {Mod (e1,e2)}
  | e1 = exp; AND; e2 = exp {And (e1,e2)}
  | e1 = exp; OR;  e2 = exp {Or (e1,e2)}
  | e1 = exp; GT;  e2 = exp {Gt (e1,e2)}
  | e1 = exp; LT;  e2 = exp {Lt (e1,e2)}
  | e1 = exp; EQ; e2 = exp {Eq (e1,e2)}
  | NOT; e1 = exp {Not e1}
  | LBRACKET; e1 = exp; RBRACKET {e1}  
  | IF; e1 = exp; THEN; e2 = exp; ELSE; e3 = exp {IfThenElse(e1,e2,e3)}
  | var = ID; LBRACKET; args = argexplist; RBRACKET {Apply (Id(var),args)}
  | LAMBDA; arg = ID; ARROW; e1 = exp {Lambda(Id arg,e1)}
  | var = ID  {IdExp (Id var)}
  | var = ID ASSIGN e1=exp  {Assign(Id var,e1)}
  | WRITE; e1=exp  {Write e1}
  | READ;  var=ID  {Read (Id var)}
  | LCURLY; DECL; dec = declist LCED; expl = explist RCURLY {Block(dec,expl)}
  | WHILE; cond = exp; DO; LCURLY; DECL; decl=declist; LCED; expl = explist; RCURLY {
                                                                                 let else_exp = if List.length expl = 0 then Repeat 
                                                                                 else (List.hd expl) in
                                                                                 let block_explist = if List.length expl = 0 then []
                                                                                 else List.tl expl @ [Repeat] in
                                                                                 Block(decl,(IfThenElse((Not cond),Break,else_exp))::block_explist)}
  |FOR; exp_init = exp; TO n = exp; DO; LCURLY; DECL; decl = declist; LCED; expl = explist; RCURLY {
                                                      match exp_init with
                                                      | Assign (id, exp) -> 
                                                        let else_exp = if List.length expl = 0 then (Assign(id, Plus (IdExp id, Int 1))) 
                                                                                 else List.hd expl in
                                                        let block_explist = if List.length expl = 0 then [Repeat]
                                                                            else List.tl expl @ [(Assign(id, Plus (IdExp id, Int 1)));Repeat] in
                                                      Block([],exp_init::[(Block(decl,IfThenElse((Gt(IdExp id,n)),Break,else_exp)::block_explist))])
                                                       | _ -> let _ = print_string "pattern matching to assignment failed" in
                                                                      failwith "Syntax Error in for loop initialisation"

                                                                                                } 
  | REPEAT {Repeat}
  | BREAK  {Break}
