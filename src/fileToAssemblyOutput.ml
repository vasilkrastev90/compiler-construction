
type asm_info = {
        value: int;
}

let fileToAssemblyMap = Hashtbl.create 500
let createTable  =
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate1.k" {value = 2};
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate2.k"{value = 2};
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate3.k" {value =9 };
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate4.k" {value =4 };
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate5.k" {value = 37};
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate6.k"{value = 40 };
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate7.k" {value =42 };
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate8.k" {value =32 };
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate9.k" {value = 99};
Hashtbl.add fileToAssemblyMap "simple-expression-to-generate10.k"{value = 75 };
