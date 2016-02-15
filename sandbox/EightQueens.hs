start_pos = [1..8]

{-
    The solution must look something like: [1, 3, 5, 6, 2, 7, 9]
    where each index is a column and
    each number is the row on which the queen is placed.
-}

-- | Place an additional queen on the board, given a list of positions
placeQueen :: [Int] -> [Int]
placeQueen (x:xs) = undefined

-- | Returns True if this queen attacks any other queens on the rank
threatensRank :: [Int] -> Int -> Bool
threatensRank = undefined

-- | Returns True if this queen attacks any other queens on the file
threatensFile :: [Int] -> Int -> Bool
threatensFile = undefined

-- | Returns True if this queens attacks any other queens on a diagonal
threatensDiagonal :: [Int] -> Int -> Bool
threatensDiagonal = undefined
