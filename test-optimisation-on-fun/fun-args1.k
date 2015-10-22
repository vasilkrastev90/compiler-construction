let f a b = begin a + b end 


let foo = begin let x =3 in
                let y = 4 in
                apply apply f x y end
