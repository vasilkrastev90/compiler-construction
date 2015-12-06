let foo = decl let n = 5; let i=1; let p=1 lced begin
                    n;
                    i;
                    { decl lced 
                      if i>n then
                      break else
                      p = i*p;
                      i=i+1; 
                      repeat
                    };
                    n;
                    i;
                    p
                    end  
