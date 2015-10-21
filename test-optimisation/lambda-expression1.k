let foo = begin let a = 5 in
                let b = a+3 in
                apply (\x -> apply x a) \a -> a + 8
          end
