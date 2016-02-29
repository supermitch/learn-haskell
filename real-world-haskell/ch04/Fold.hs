-- file: ch04/Fold.hs

-- Folding, left-associative

foldl' :: (a -> b -> a) -> a -> [b] -> a
foldl' step zero (x:xs) = foldl step (step zero x) xs
foldl' _    zero []     = []

{-
foldl (+) 0 (1:2:3:[])
          == foldl (+) (0 + 1)             (2:3:[])
          == foldl (+) ((0 + 1) + 2)       (3:[])
          == foldl (+) (((0 + 1) + 2) + 3) []
          ==           (((0 + 1) + 2) + 3)
-}

-- Folding right-associative

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' step zero (x:xs) = step x (foldr step zero x)
foldr' _    zero []     = zero

{-
foldr (+) 0 (1:2:3:[])
          == 1 +           foldr (+) 0 (2:3:[])
          == 1 + (2 +      foldr (+) 0 (3:[])
          == 1 + (2 + (3 + foldr (+) 0 []))
          == 1 + (2 + (3 + 0))

1 : (2 : (3 : []))
1 + (2 + (3 + 0 ))
-}

-- Why use foldr? Let's look at Filter, written using explicit recursion:

filter :: (a -> Bool) -> [a] -> [a]
filter p [] = []
filter p (x:xs)
    | p x = x : filter p xs
    | otherwise : filter p xs

-- ok, but surprisingly, we can write this using foldr

filter' p xs = foldr step [] xs
    where step x ys | p x       = x : ys
                    | otherwise = ys

-- The class of functions that we can express using foldr is called primitive recursive.

-- Implment 'map' in terms of foldr:

map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr step [] xs
    where step x ys = f x : ys

-- we can even write foldl in terms of foldr:

foldl' :: (a -> b -> a) -> a -> [b] -> a
foldl' f z xs = foldr step id xs z
    where step x g a = g (f a x)

-- Good lord...

-- You can write the identity transformation also:
identity :: [a] -> [a]
identify xs = foldr (:) [] xs

-- We can also look at foldr as a way of appending, e.g.

[1..4] ++ [5..8] -- [1..8]

-- can be written as:

append :: [a] -> [a]
append xs ys = foldr (:) ys xs


