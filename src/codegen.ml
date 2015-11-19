(*===----------------------------------------------------------------------===1
 * Code Generation
 *===----------------------------------------------------------------------===*)

open Ast
open Printf


let main_function_name = "foo"

let asm_func_prefix id = "\t.globl "^ id ^"
                          \t.type "^ id ^ ", @function
                          "^ id ^":\n"

let asm_set_bp = "
                  \tpushq %rbp
                  \tmovq    %rsp, %rbp
                 "

let asm_main_prefix = ".LC0:
                  \t.string \"%i\\n\"
                  \t.text
                  \t.globl  main
                  \t.type   main, @function
                  main:
                  \tpushq %rbp
                  \tmovq    %rsp, %rbp
                  "



let asm_func_suffix id argList decList= "\tmov $0, %rax
                                         \tadd %rsi, %rax
                                         \tadd $" ^ string_of_int ((List.length decList)*8) ^ ", %rsp     
                                         \tpop %rsi
                                         \tadd $" ^ string_of_int ((List.length argList)*8) ^ ", %rsp
                                         \tpopq %rbp
                                         \tjmp *%rsi
                                         \t.size " ^ id ^", .-" ^ id ^"\n" 

let asm_main_suffix decList = "\tpush %rsi
                          \tmovl    $.LC0, %edi
                          \tmovl    $0, %eax
                          \tcall    printf
                          \tpop     %rax\n" ^
                          ("\tadd $" ^ string_of_int ((List.length decList)*8) ^", %rsp\n") ^
                          "\tpopq    %rbp
                          \tret 
                          \t.size   main, .-main
                          "
let asm_file_suffix = "\t.ident  \"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4\"
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
| Apply (Id id, explist) -> asm_set_bp ^ (List.map codegen_exp' explist |>  List.fold_left (^) " ") ^ "\t call " ^ id ^ "\n\tpush %rax\n" 
| Lambda _ -> failwith "TODO"
| Assign ((Id id),e1) -> codegen_exp' e1 ^ asm_assign_to_local_var hashTable id e1
| Read _ -> failwith "TODO"
| Write _ -> failwith "TODO"

let codegen_exp_and_pop hashTable  e = codegen_exp hashTable e ^
                            "\t pop %rsi
                            "
                              

let codegen_dec hashTable (declaration:dec) = match declaration with
| Dec ((Id id),e) -> codegen_exp hashTable e

let addArgsToHashTable hashTable i (argument:arg ) = match argument with
| Id id -> Hashtbl.add hashTable id ((i+1)*8)

let addDecsToHashTable hashTable offset i (decl:dec) = match decl with
| Dec ((Id id), _) -> Hashtbl.add hashTable id ((offset+i+1)*8)


let codegen_func (ast:func) = match ast with
| Function (Id "foo",argList,decList,explist) ->
let hashTable = Hashtbl.create (List.length decList) in
let _ = List.iteri (addDecsToHashTable hashTable 0) decList in
asm_main_prefix ^ (List.map (codegen_dec hashTable) decList |>  List.fold_left (^) " ") ^ (List.map (codegen_exp_and_pop hashTable) explist |>  List.fold_left (^) " ") ^  asm_main_suffix decList
| Function (Id id,argList,decList,explist) -> 
let hashTable = Hashtbl.create (List.length decList) in
let _ = List.iteri (addArgsToHashTable hashTable) argList in
let _ = List.iteri (addDecsToHashTable hashTable ((List.length argList+1))) decList in
let asm_suffix = asm_func_suffix id argList decList in
let asm_prefix = asm_func_prefix id in
asm_prefix ^ (List.map (codegen_dec hashTable) decList |>  List.fold_left (^) " ") ^ (List.map (codegen_exp_and_pop hashTable) explist |>  List.fold_left (^) " ") ^  asm_suffix

let rec codegen_progr (ls:program) = match ls with
| [] -> asm_file_suffix  
| hd::tl -> codegen_func hd ^"\n\n"^ codegen_progr tl 
