let foo = decl lced begin
                    blah(blah(3)) + bar(bar(1))
                    end 

let bar x = decl lced begin
                      x+2
                      end 

let blah x = decl lced begin
                      x+3
                      end
