let foo = begin let a = 5 in
                let b = a + 3 in
          apply (\x -> apply x a) \b -> let a = b in
                                        a + 2
          end
