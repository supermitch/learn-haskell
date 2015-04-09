-- Recursion

-- an example of max using recursion
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "Max of an empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs

-- or even more elegantly:
maximum'' :: (Ord a) => [a] -> a
maximum'' [] = error "max of empty list"
maximum'' [x] = x
maximum'' (x:xs) = max x (maximum'' xs)

-- implement replicate
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0    = []
    | otherwise = x:replicate' (n-1) x

-- Note: 'Num' is not a subclass of 'Ord'... so we need to specify both
-- when doing math AND comparison

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0    = []
take' _ []      = []
take' n (x:xs)  = x : take' (n - 1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

-- Implement infinite recursive list:
repeat' :: a -> [a]
repeat' x = x:repeat' x

-- Implement zip recursively.
-- zip takes two lists, and generates tuples of elements
-- until one of the lists is empty...

zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x, y):zip' xs ys

-- Elem returns True if an element is in a list
elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' a (x:xs)
    | a == x    = True
    | otherwise = elem' a xs

-- Quicksort in Haskell:
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallSorted = quicksort [a | a <- xs, a <= x]
        bigSorted = quicksort [a | a <- xs, a > x]
    in smallSorted ++ [x] ++ bigSorted

-- Super chill.

