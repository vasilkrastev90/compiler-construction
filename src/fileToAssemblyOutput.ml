
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
Hashtbl.add fileToAssemblyMap "expression1.k"{value = 0 };
Hashtbl.add fileToAssemblyMap "exp1.k"{value = 5 };
Hashtbl.add fileToAssemblyMap "exp2.k"{value = 7};
Hashtbl.add fileToAssemblyMap "exp3.k"{value = 7 };
Hashtbl.add fileToAssemblyMap "exp4.k"{value = 7 };
Hashtbl.add fileToAssemblyMap "exp5.k"{value = 7 };
Hashtbl.add fileToAssemblyMap "exp6.k"{value = 7 };
Hashtbl.add fileToAssemblyMap "exp7.k"{value = 7 };
Hashtbl.add fileToAssemblyMap "exp8.k"{value = 7 };
Hashtbl.add fileToAssemblyMap "exp9.k"{value = 7 };
Hashtbl.add fileToAssemblyMap "exp0.k"{value = 7 };
Hashtbl.add fileToAssemblyMap "expression-local-var.k" {value = 0 };
Hashtbl.add fileToAssemblyMap "fun1.k" {value = 0};
Hashtbl.add fileToAssemblyMap "fun2.k" {value = 21};
Hashtbl.add fileToAssemblyMap "fun3.k" {value = 18};
Hashtbl.add fileToAssemblyMap "fun4.k" {value = 5};
Hashtbl.add fileToAssemblyMap "fun5.k" {value = 3};
Hashtbl.add fileToAssemblyMap "fun6.k" {value = 0};
Hashtbl.add fileToAssemblyMap "fun7.k" {value = 27};
Hashtbl.add fileToAssemblyMap "fun8.k" {value = 120};
Hashtbl.add fileToAssemblyMap "fun9.k" {value = 243};
Hashtbl.add fileToAssemblyMap "fun10.k" {value = 120};
Hashtbl.add fileToAssemblyMap "fun11.k" {value = 120};
Hashtbl.add fileToAssemblyMap "loops.k" {value = 120};
Hashtbl.add fileToAssemblyMap "break.k" {value = 1};
Hashtbl.add fileToAssemblyMap "function.k" {value = 1};





