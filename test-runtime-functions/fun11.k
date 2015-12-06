let foo  = decl let n = 0 lced begin 
                               read n;
                               fact(n) end 

let fact n = decl lced begin print n; 
                             if n ==1 then 1 else n*fact(n-1) end 
