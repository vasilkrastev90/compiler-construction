(*===----------------------------------------------------------------------===
 * Code Generation
 *===----------------------------------------------------------------------===*)

open Ast
open Printf

type integers_scope = {
        value:int;
}

let asm_prefix = ".LC0:
                  \t.string \"%i\\n\"
                  \t.text
                  \t.globl  main
                  \t.type   main, @function
                  main:
                  LFB0:
                  \tpushq %rbp
                  \tmovq    %rsp, %rbp
                  "

let asm_suffix = " \tpop %rsi
                   \tpush %rsi
                   \tmovl    $.LC0, %edi
                   \tmovl    $0, %eax
                   \tcall    printf
                   \tpop     %rax
                   \tpopq    %rbp
                   \tret
                   \t.LFE0:
                   \t.size   main, .-main
                   \t.ident  \"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4\"
                   \t.section        .note.GNU-stack,\"\",@progbits
                   "

let asm_push_int n = sprintf "\tpush $%d\n" n

let asm_add ="\tpop %rdi
              \tpop %rsi
              \tadd %rdi, %rsi
              \tpush %rsi
              " 
let asm_sub ="\tpop %rdi
              \tpop %rsi
              \tneg %rdi
              \tadd %rdi, %rsi
              \tpush %rsi
              "
let asm_mul ="\tpop %rdi
              \tpop %rsi
              \timul %rdi, %rsi
              \tpush %rsi
              " 
let asm_div ="\tpop %rsi
              \tpop %rdi
              \txor  %rdx, %rdx  
              \tmov  %rdi, %rax 
              \tidiv %rsi       
              \tpush %rax
              " 
let rec codegen_exp (e:exp) = match e with
| Int n -> asm_push_int n
| IdExp _ -> failwith "TODO"
| Plus (e1,e2) -> (codegen_exp e1) ^ (codegen_exp e2) ^ asm_add
| Minus (e1,e2) -> (codegen_exp e1) ^ (codegen_exp e2) ^ asm_sub
| Times (e1,e2)-> (codegen_exp e1) ^ (codegen_exp e2) ^ asm_mul
| Div (e1,e2) -> (codegen_exp e1) ^ (codegen_exp e2) ^ asm_div
| Mod _ -> failwith "TODO"
| And _ -> failwith "TODO"
| Or _ -> failwith "TODO"
| Gt _ -> failwith "TODO"
| Lt _ -> failwith "TODO"
| Eq _ -> failwith "TODO"
| Not _ -> failwith "TODO"
| IfThenElse _ -> failwith "TODO"
| Apply _ -> failwith "TODO"
| Lambda _ -> failwith "TODO"
| Assign _ -> failwith "TODO"
| Read _ -> failwith "TODO"
| Write _ -> failwith "TODO"

let codegen_func (ast:func) = match ast with
| Function (x,argList,decList,explist) -> asm_prefix ^ (List.map codegen_exp explist |>  List.fold_left (^) " ") ^ asm_suffix

let codegen_progr (ls:program) = match ls with
| [] -> failwith "Currently not generating code for an empty program"
| hd::tl -> codegen_func hd
