let foo = begin let a = 5 in
                let b = a+3 in
                apply (\x -> x+7)  a + 8
          end
