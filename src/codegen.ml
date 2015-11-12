(*===----------------------------------------------------------------------===
 * Code Generation
 *===----------------------------------------------------------------------===*)

open Ast
open Printf





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




let asm_suffix decList = "\tpush %rsi
                          \tmovl    $.LC0, %edi
                          \tmovl    $0, %eax
                          \tcall    printf
                          \tpop     %rax\n" ^
                          ("\tadd $" ^ string_of_int ((List.length decList)*8) ^", %rsp\n") ^
                          "\tpopq    %rbp
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
let asm_read_local_var id hashTable = let index = (Hashtbl.find hashTable id) in
                             "\t push -" ^ string_of_int index  ^ "(%rbp)
                             "
                             
let asm_assign_to_local_var hashTable id exp= let index = (Hashtbl.find hashTable id) in
                                    "\tpop %rsi
                                     \tmov %rsi, -"^ string_of_int index  ^ "(%rbp)
                                     \tpush %rsi
                                    " 


let rec codegen_exp hashTable (e:exp) = 
let codegen_exp' = codegen_exp hashTable in       
        match e with
| Int n -> asm_push_int n
| IdExp (Id id') -> asm_read_local_var id' hashTable
| Plus (e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_add
| Minus (e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_sub
| Times (e1,e2)-> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_mul
| Div (e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_div
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
| Assign ((Id id),e1) -> codegen_exp' e1 ^ asm_assign_to_local_var hashTable id e1
| Read _ -> failwith "TODO"
| Write _ -> failwith "TODO"

let codegen_exp_and_pop hashTable  e = codegen_exp hashTable e ^
                            "\t pop %rsi
                            "
                              

let codegen_dec hashTable (declaration:dec) = match declaration with
| Dec ((Id id),e) -> codegen_exp hashTable e


let addToHashTable hashTable i (decl:dec) = match decl with
| Dec ((Id id), _) -> Hashtbl.add hashTable id ((i+1)*8)


let codegen_func (ast:func) = match ast with
| Function (x,argList,decList,explist) -> 
let hashTable = Hashtbl.create (List.length decList) in
let _ = List.iteri (addToHashTable hashTable) decList in
asm_prefix ^ (List.map (codegen_dec hashTable) decList |>  List.fold_left (^) " ") ^ (List.map (codegen_exp_and_pop hashTable) explist |>  List.fold_left (^) " ") ^  (asm_suffix decList)

let codegen_progr (ls:program) = match ls with
| [] -> failwith "Currently not generating code for an empty program"
| hd::tl -> codegen_func hd
