-- QSort implementation: file:///Library/Haskell/doc/ghc-doc/users_guide/ghci-debugger.html
qsort [] = []
qsort (a:as) = qsort left ++ [a] ++ qsort right
    where (left,right) = (filter (<=a) as, filter (>a) as)

main = print (qsort [8, 4, 0, 2, 1, 23, 11, 18])

