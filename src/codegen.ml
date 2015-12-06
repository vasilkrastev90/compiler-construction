(*===-----------------------------------------------------------v-----------===1
 * Code Generation
 *===----------------------------------------------------------------------===*)

open Ast
open Printf


let main_function_name = "foo"


let generateLabel label_count  = let current_count = Hashtbl.find label_count "lb_count" in
                                 let _ = Hashtbl.add label_count "lb_count" (current_count+1) in
                                 ".L" ^ (string_of_int (current_count+1))

let asm_func_prefix id = "\t.globl "^ id ^"\n" ^
                         "\t.type "^ id ^ ", @function\n"^ id ^":\n"

let asm_push_bp = "\tpushq %rbp\n"
                 

 
      
                 


let asm_set_sp offset= "mov %rsp, %rsi\n" ^
                       "\tadd $"^  (string_of_int offset) ^", %rsi\n" ^
                       "\tmovq %rsi, %rbp\n"                
let asm_main_prefix = ".LC0: \n"^
                      "\t.string \"%i\\n\"\n" ^
                      ".LC1: \n" ^
                      "\t.string \"%i\"\n" ^
                      "\t.text\n\t.globl  main\n"^
                      "\t.type   main, @function\n" ^
                      "main:\n" ^
                      "\tpushq %rbp\n" ^
                      "\tmovq  %rsp, %rbp\n"



let asm_func_suffix id argList decList= "\tmov $0, %rax\n" ^
                                        "\tadd %rsi, %rax\n" ^
                                        "\tadd $" ^ string_of_int ((List.length decList)*8) ^ ", %rsp\n" ^
                                        "\tpop %rsi\n"^
                                        "\tadd $" ^ string_of_int ((List.length argList)*8) ^ ", %rsp\n" ^
                                        "\tpopq %rbp\n" ^
                                        "\tjmp *%rsi\n" ^
                                        "\t.size " ^ id ^", .-" ^ id ^"\n" 

let asm_main_suffix decList = "\tpush %rsi\n"^
                              "\tmovl    $.LC0, %edi\n" ^
                              "\tmovl    $0, %eax\n"^
                              "\tcall    printf\n" ^
                              "\tpop     %rax\n" ^
                              "\tadd $" ^ string_of_int ((List.length decList)*8) ^", %rsp\n" ^
                              "\tpopq    %rbp\n"^
                              "\tret\n"^
                              "\t.size   main, .-main\n"

                              

let asm_file_suffix = "\t.ident  \"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4\"\n" ^
                      "\t.section        .note.GNU-stack,\"\",@progbits"

let asm_print =  "\tpop %rsi\n" ^
                 "\tpush %rsi\n"^
                 "\tmovl    $.LC0, %edi\n" ^
                 "\tmovl    $0, %eax\n"^
                 "\tcall    printf\n"                      


 let asm_read offset= "\tmovl    $4, %edi\n"^
                      "\tcall    malloc\n" ^
                      "\tpush    %rax\n"  ^
                      "\tmovq    %rax, %rsi\n" ^
                      "\tmovl    $.LC1, %edi\n"^
                      "\tmovl    $0, %eax\n" ^
                      "\tcall    __isoc99_scanf\n" ^
                      "\tpop     %rax\n" ^
                      "\tmov   (%rax), %rdi\n"^
                      "\tmov  %rdi, -" ^ (string_of_int offset) ^ "(%rbp)\n" ^ 
                      "\tmovq    %rax, %rdi\n" ^
                      "\tcall    free\n"^
                      "\t push $0\n"                 

let asm_push_int n = sprintf "\tpush $%d\n" n

let asm_add ="\tpop %rdi\n"^
             "\tpop %rsi\n" ^
             "\tadd %rdi, %rsi\n" ^ 
             "\tpush %rsi\n" 

let asm_sub ="\tpop %rdi\n"^
             "\tpop %rsi\n" ^
             "\tneg %rdi\n"^
             "\tadd %rdi, %rsi\n"^
             "\tpush %rsi\n"

let asm_mul ="\tpop %rdi\n" ^
             "\tpop %rsi\n" ^
             "\timul %rdi, %rsi\n" ^
             "\tpush %rsi\n"
              
let asm_div ="\tpop %rsi\n"^
             "\tpop %rdi\n" ^
             "\txor  %rdx, %rdx\n" ^
             "\tmov  %rdi, %rax\n" ^
             "\tidiv %rsi\n" ^
             "\tpush %rax\n"

let asm_and = "\tpop %rdi\n" ^
              "\tpop %rsi\n" ^
              "\tand %rdi, %rsi\n" ^
              "\tpush %rsi\n"
              
              
                         
let asm_or =  "\tpop %rdi\n" ^
              "\tpop %rsi\n" ^
              "\tor %rdi, %rsi\n" ^
              "\tpush %rsi"

let asm_gt label_count = let labelGe = generateLabel label_count in
             let labelEnd = generateLabel label_count in
             "\tpop %rdi\n" ^
             "\tpop %rsi\n" ^
             "\tcmp %rdi, %rsi\n"^
             "\tjg " ^labelGe ^ "\n" ^
             "\tpush $0\n" ^
             "\tjmp " ^ labelEnd ^ "\n" ^
             labelGe ^":\n" ^
             "\tpush $1\n" ^
             labelEnd ^ ":\n"

let asm_lt label_count = let labelLe = generateLabel label_count in
             let labelEnd = generateLabel label_count in
             "\tpop %rdi\n" ^
             "\tpop %rsi\n" ^
             "\tcmp %rdi, %rsi\n"^
             "\tjl " ^labelLe ^ "\n" ^
             "\tpush $0\n" ^
             "\tjmp " ^labelEnd ^"\n" ^
             labelLe ^":\n" ^
             "\tpush $1\n" ^
             labelEnd ^ ":\n"

let asm_eq label_count = let labelEq = generateLabel label_count in
             let labelEnd = generateLabel label_count in
             "\tpop %rdi\n" ^
             "\tpop %rsi\n" ^
             "\tcmp %rdi, %rsi\n"^
             "\tje " ^labelEq ^ "\n" ^
             "\tpush $0\n" ^
             "\tjmp " ^labelEnd  ^ "\n" ^
             labelEq ^":\n" ^
             "\tpush $1\n" ^
             labelEnd ^ ":\n"

let asm_not label_count =  let labelEq = generateLabel label_count in
               let labelEnd = generateLabel label_count in
               "\tpop %rdi\n" ^
               "\tcmp $0, %rdi\n"^
               "\tjne " ^labelEq ^ "\n" ^
               "\tpush $1\n" ^
               "\tjmp " ^labelEnd  ^ "\n" ^
               labelEq ^":\n" ^
               "\tpush $0\n" ^
               labelEnd ^ ":\n"
              

let asm_read_local_var id hashTable = let index = (Hashtbl.find hashTable id) in
                             "\t push -" ^ string_of_int index  ^ "(%rbp)\n"
                             
                             
let asm_assign_to_local_var hashTable id exp= let index = (Hashtbl.find hashTable id) in
                                    "\tpop %rsi\n\tmov %rsi, -"^ string_of_int index  ^ "(%rbp)\n\tpush %rsi\n"
                                    
let asm_if_then_else label_count b1_code b2_code = let labelb2 = generateLabel label_count in
                                       let labelEnd = generateLabel label_count in      
                                       "\tpop %rsi\n" ^
                                       "\tcmp $0, %rsi\n" ^
                                       "\tje "  ^ labelb2 ^ "\n" ^
                                       b1_code ^
                                       "\tjmp " ^labelEnd ^ "\n" ^
                                       labelb2 ^ ":\n" ^
                                       b2_code ^
                                       labelEnd ^ ":\n" 


let addArgsToHashTable hashTable i (argument:arg ) = match argument with
| Id id -> Hashtbl.add hashTable id ((i+1)*8)

let addDecsToHashTable hashTable offset i (decl:dec) = match decl with
| Dec ((Id id), _) -> Hashtbl.add hashTable id ((offset+i+1)*8)


let rec codegen_exp label_count hashTable ?(label = "") ?(offset = 0) (e:exp) = 
let codegen_exp' = codegen_exp label_count hashTable ~label:label ~offset:offset in       
        match e with
| Int n -> asm_push_int n
| IdExp (Id id') -> asm_read_local_var id' hashTable
| Plus (e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_add
| Minus (e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_sub
| Times (e1,e2)-> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_mul
| Div (e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_div
| Mod _ -> failwith "TODO"
| And(e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_and
| Or(e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ asm_or
| Gt (e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ (asm_gt label_count)
| Lt (e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ (asm_lt label_count)
| Eq (e1,e2) -> (codegen_exp' e1) ^ (codegen_exp' e2) ^ (asm_eq label_count)
| Not e1 -> (codegen_exp' e1) ^ (asm_not label_count)
| IfThenElse (c,b1,b2) -> let c_code = codegen_exp' c in
                          let b1_code = codegen_exp' b1 in
                          let b2_code = codegen_exp' b2 in
                          c_code ^ asm_if_then_else label_count b1_code b2_code 
| Apply (Id id, explist) ->asm_push_bp ^ (List.map codegen_exp' explist |>  List.fold_left (^) " ")^ asm_set_sp ((List.length explist)*8) ^ "\t call " ^ id ^ "\n\tpush %rax\n" 
| Lambda _ -> failwith "TODO"
| Assign ((Id id),e1) -> codegen_exp' e1 ^ asm_assign_to_local_var hashTable id e1
| Read (Id id) -> let offset = Hashtbl.find hashTable id in
                  asm_read offset
| Write e1 -> codegen_exp' e1 ^ asm_print
| Repeat ->  "\tadd $" ^ (string_of_int (offset* 8)) ^ ", %rsp\n" ^
              "\tjmp " ^ label ^ "B \n"
| Break -> "\tadd $" ^ (string_of_int (offset*8)) ^ ", %rsp\n" ^
           "\tpush $0\n" ^
           "\tjmp " ^ label ^ "E \n"
| Block(declist, explist) -> (*Create a new hashmap*)
                        let hashTable' = Hashtbl.create ((List.length declist)*3) in
                        let label = generateLabel label_count in
                            (*insert the decs with offset the max offset so far*)
                        let offset = (Hashtbl.length hashTable)   in 
                        let _ = Hashtbl.iter (Hashtbl.add hashTable') hashTable in
                        let _ = List.iteri (addDecsToHashTable hashTable' offset) declist in
                        (*insert the label after the decs*)
                        (*let _ = Hashtbl.add hashTable' label (offset+(List.length declist)+1)*8 in*)
                        (*opening label*)     
                        label ^ "B:\n" ^
                        (*codegen for the decs*)
                        (List.map (codegen_dec label_count hashTable') declist |>  List.fold_left (^) " ") ^
                        (*push the label to the stack*)
                        (* "\tpush " ^ generateLabel ^ "\n"*)
                         (*codegen for expressions*)
                   (List.map (codegen_exp_and_pop label_count hashTable' ~label:label ~offset:(List.length declist)) explist |>  List.fold_left (^) " ")^
                         "\tadd $" ^ string_of_int ((List.length declist)*8) ^", %rsp\n" ^
                         "\t push %rsi\n"^
                         (*closing label*)
                         label ^ "E:\n"
                 and
codegen_exp_and_pop label_count hashTable ?(label="") ?(offset=0) e = codegen_exp label_count hashTable ~label:label ~offset:offset e ^
                            "\t pop %rsi\n"
                              
                 and
codegen_dec label_count hashTable (declaration:dec) = match declaration with
| Dec ((Id id),e) -> codegen_exp label_count hashTable e


let codegen_func label_count (ast:func) = match ast with
| Function (Id "foo",argList,decList,explist) ->
let hashTable = Hashtbl.create (List.length decList) in
let _ = List.iteri (addDecsToHashTable hashTable 0) decList in
asm_main_prefix ^ (List.map (codegen_dec label_count hashTable) decList |>  List.fold_left (^) " ") ^ (List.map (codegen_exp_and_pop label_count hashTable) explist |>  List.fold_left (^) " ") ^  asm_main_suffix decList
| Function (Id id,argList,decList,explist) -> 
let hashTable = Hashtbl.create (List.length decList) in
let _ = List.iteri (addArgsToHashTable hashTable) argList in
let _ = List.iteri (addDecsToHashTable hashTable ((List.length argList+1))) decList in
let asm_suffix = asm_func_suffix id argList decList in
let asm_prefix = asm_func_prefix id in
asm_prefix ^ (List.map (codegen_dec label_count hashTable) decList |>  List.fold_left (^) " ") ^ (List.map (codegen_exp_and_pop label_count hashTable) explist |>  List.fold_left (^) " ") ^  asm_suffix

let rec codegen_progr (ls:program) = 
let label_count =  Hashtbl.create 1 in
let _ = Hashtbl.add label_count "lb_count" (-1) in
        match ls with
| [] -> asm_file_suffix  
| hd::tl -> codegen_func label_count hd ^"\n\n"^ codegen_progr tl 
