let foo = decl lced begin
                    bar(bar(1))
                    end 

let bar x = decl lced begin
                      x+2
                      end

