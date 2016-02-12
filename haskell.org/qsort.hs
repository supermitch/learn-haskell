-- QSort implementation: file:///Library/Haskell/doc/ghc-doc/users_guide/ghci-debugger.html
qsort [] = []
qsort (a:as) = qsort left ++ [a] ++ qsort right
    where (left, right) = (filter (<=a) as, filter (>a) as)

main = print (qsort [8, 4, 0, 2, 1, 23, 11, 18])

-- Alternative qsort:

quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (p:xs) = (quicksort lesser) ++ [p] ++ (quicksort greater)
    where
        lesser = filter (< p) xs
        greater = filter (>=p) xs

-- List comprehension form

qsort' :: Ord a => [a] -> [a]
qsort' [] = []
qsort' (p:xs) = qsort [x | x<-xs, x < p] ++ [p] ++ qsort [x | x<-xs, x >= p]


