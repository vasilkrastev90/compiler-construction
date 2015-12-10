let foo =   decl 
            lced begin 
            bar(3)
            end                  


let bar z = decl
            let a =3;
            let b =4
            lced begin 
            while 1 do {decl lced
            z=(a+b)*z;
            break;
            a=5
            };
            z
            end
