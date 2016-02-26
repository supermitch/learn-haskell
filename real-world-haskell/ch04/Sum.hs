-- file: ch04/Sum.hs

mySum xs = helper 0 xs
    where helper acc [] = acc
          helper acc (x:xs) = helper (acc + x) xs
