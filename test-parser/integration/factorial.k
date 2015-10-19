let fact n =begin
            if n == 0 then 1
            else n * apply fact (n-1)
            end
