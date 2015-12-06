let foo = decl let i = 0; let j =0; let k =0; let m = 0
          lced begin 
          for i = 1 to 2 do {decl lced
             for j = 1 to 9 do {decl lced
               for k = 1 to 9 do {decl lced
                 for m = 1 to 9 do {decl lced 
                 print (i*1000 + j*100 + k*10 + m)
                 }
                }
              } 
          }
          end
