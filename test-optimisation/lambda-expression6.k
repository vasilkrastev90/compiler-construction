let foo = begin
          let x = \a -> a + 2 in
          apply x y + apply x z
          end
