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
%token ASSIGN
%token LET
%token IN
%token IF
%token THEN
%token ELSE
%token LAMBDA
%token ARROW
%token BEGIN
%token END
%token APPLY
%token EOF
%nonassoc IN ARROW
%nonassoc ELSE
%nonassoc LT GT EQ
%left MINUS PLUS
%left TIMES DIV MOD
%left AND OR
%right NOT
%left APPLY
%left WRITE
%start <Ast.program> top
%%

top:
  | ls = funclist {ls}

revfunclist:
  | (*empty *) {[]}
  | ls = revfunclist; f = func {f :: ls}

funclist: 
  | ls = revfunclist; EOF {List.rev ls}

explist:
  |ls = separated_list(SEMICOLON, exp) {ls}  

revarglist:
  | (*empty*){[]}
  | ls = revarglist; var = ID {(Id var)::ls}


arglist: 
  | ls = revarglist {List.rev ls}


func:
  | LET; var = ID; args = arglist; ASSIGN; BEGIN; es = explist; END {Function(Id var,args,es)}

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
  | APPLY m = exp; n = exp {Apply (m,n)}
  | LAMBDA; arg = ID; ARROW; e1 = exp {Lambda(Id arg,e1)}
  | var = ID  {IdExp (Id var)}
  | LET; var = ID; ASSIGN; e1 = exp; IN; e2=exp  {Assign(Id var,e1,e2)}
  | WRITE; e1=exp  {Write e1}
  | READ;  var=ID  {Read (Id var)}
