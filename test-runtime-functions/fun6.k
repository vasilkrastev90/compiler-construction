let foo = decl let i = 0; let j = 0 lced begin
                    for i = 0 to 5 do {decl lced
                                       for j =0 to 10 do {decl lced
                                         print (i*10+j)
                                       }
                                     }
                    end 

let bar x = decl lced begin
                      x+2
                      end

