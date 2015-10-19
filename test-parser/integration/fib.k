let fib n = begin
            if n == 0 then 1
            else if n == 1 then 1
            else apply fib (n-1) + apply fib (n-2)
            end
