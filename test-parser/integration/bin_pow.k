let bin_pow n m = 
              begin 
              if m == 0 then 1
              else if m mod 2 == 0 then n*n* apply (apply bin_pow n) (m div 2)
              else n* apply (apply bin_pow n) (m-1)
              end
