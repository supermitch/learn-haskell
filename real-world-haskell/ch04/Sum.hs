-- file: ch04/Sum.hs

mySum xs = helper 0 xs
    where helper acc [] = acc
          helper acc (x:xs) = helper (acc + x) xs

-- let's re-write mySum using foldl:

foldlSum xs = foldl step 0 xs
    where step acc x = acc + x

-- of course, the 'step' function is just taking the sum, so we can do

niceSum :: [Integer] -> Integer
niceSum xs = foldl (+) 0 xs

-- We can also use currying to make this better. This gives us a function
-- of the same type!

niceSum' :: [Integer] -> Integer
niceSum' = foldl (+) 0
