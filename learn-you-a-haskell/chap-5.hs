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
replacate' n x
    | n <= 0    = 0
    | othwerwise x:replicate' (n-1) x

-- Note: 'Num' is not a subclass of 'Ord'... so we need to specify both
-- when doing math AND comparison

