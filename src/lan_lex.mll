{
open Lan_par
exception SyntaxError of string
}

let int = ['0'-'9'] ['0'-'9']*
let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*
let white = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n" 

rule read = 
  parse
   | white {read lexbuf}
   | newline {read lexbuf}
   | int {INT (int_of_string (Lexing.lexeme lexbuf))}
   | '=' {ASSIGN}
   | '+' {PLUS}
   | '-' {MINUS}
   | '*' {TIMES}
   | "div" {DIV}
   | "mod" {MOD}
   | '('  {LBRACKET}
   | ')'  {RBRACKET}
   | '{'  {LCURLY}
   | '}'  {RCURLY}
   | ','  {COMMA}
   | '!'  {NOT}
   | "&&" {AND}
   | "||" {OR}
   | "<" {LT}
   | ">" {GT}
   | "==" {EQ}
   | "let" {LET}
   | "decl" {DECL}
   | "lced" {LCED}
   | "if" {IF}
   | "then" {THEN}
   | "else" {ELSE}
   | "\\" {LAMBDA}
   | "->" {ARROW}
   | "begin" {BEGIN}
   | "end"   {END}
   | ';' {SEMICOLON}
   | "print" {WRITE}
   | "read"  {READ}
   | "repeat" {REPEAT}
   | "break"  {BREAK}
   | "while"  {WHILE}
   | "do"     {DO}
   | "for"    {FOR}
   | "to"     {TO}
   | id  {ID (Lexing.lexeme lexbuf)}
   | _   { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf))}
   | eof {EOF}
