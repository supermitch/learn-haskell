-- file: ch04/Filter.hs

oddList :: [Int] -> [Int]
oddList [] = []
oddList (x:xs)
    | odd x     = x : oddList xs
    | otherwise = oddList xs

