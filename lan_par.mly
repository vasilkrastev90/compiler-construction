%{ open Ast %}
%token <int> INT
%token <string> ID
%token ASSIGN 
%token PLUS
%token MINUS
%token TIMES
%token WRITE
%token READ
%token SEMICOLON
%token EOF
%left PLUS
%left MINUS
%left TIMES
%left ASSIGN
%left READ
%left WRITE
%start <Ast.program> top
%%

top:
  | ls = separated_list(SEMICOLON, exp); EOF {ls}

exp:
  | i = INT {Int i}
  | e1 = exp; PLUS; e2 = exp {Plus (e1, e2)}
  | e1 = exp; TIMES; e2 = exp {Times (e1, e2)}
  | e1 = exp; MINUS; e2 = exp {Minus (e1, e2)}
  | var = ID  {Id var}
  | var = ID; ASSIGN; e1 = exp  {Assign (var,e1)}
  | WRITE; e1=exp  {Write e1}
  | READ;  e1=exp  {Read e1}
