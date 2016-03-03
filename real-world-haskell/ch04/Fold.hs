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


-- Avoiding space leaks with seq:

-- The actual fold' is a strict left fold, bypasses lazy evaluation
-- via a special function called "seq":
foldl'' _    zero []     = zero
foldl'' step zero (x:xs) =
    let new = step zero x
     in new `seq` foldl'' step new xs

-- it operates as follows... seq forces the first argument to be evaluated,
-- then returns the second argument (of type b).
{-
foldl'' (+) 1 (2:[])

expands as:

foldl' step zero (x:xs) =
    let new = step zero x
     in new `seq` foldl' step new xs

foldl' (+) 1 (2:[]) =
    let new = (+) 1 2
     in new `seq` foldl' (+) new []  -- note that `seq` is infix, so

therefore results in: foldl' (+) 3 []

which gives 3.

-}
-- To use seq effectively:

-- * "seq" must be the first thing evaluated in an expression:

-- incorrect: seq is hidden by the application of someFunc
-- since someFunc will be evaluted first, seq may occur too late

hiddenInside x y = someFunc (x `seq` y)

-- incorrect: a variation of the above mistake:
hiddenByLet x y z = let a = x `seq` someFunc y
                     in anotherFunc a z

-- correct: seq will be evaluted first, forcing evaluation of x:
onTheOutside x y = x `seq` someFunc y

-- * To evaluate several values, chain applications of seq together:
chained x y z = x `seq` y `seq` someFunc z

-- * A common mistake is to use seq with two unrelated expressions:
badExpression step zero (x:xs) =
    seq (step zero x) (badExpression step (step zero x) xs)
-- Here we are apparently trying to evaluate 'step zero x' strictly.

-- seq stops when it reaches a constructor:
strictPair (a, b) = a `seq` b `seq` (a, b)

strictList (x:xs) = x `seq` x : strictList xs
strictList []     = []
-- Those are ways to work around that limitation?

