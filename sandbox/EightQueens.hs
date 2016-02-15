{-
    8 Queens Problem:
    The solution must look something like: [1, 3, 5, 6, 2, 7, 9] where
    each index is a column (file) & each number is the row (rank)
    on which the queen is placed.
-}

-- | Append at most 'n' more queens to the given solution
--appendQueens :: [Int] -> Int -> [[Int]]
appendQueens = map addQueen [[x] | x <- [1..8]]

-- | Place one additional queen on the board, given a list of positions
addQueen :: [Int] -> [[Int]]
addQueen xs = [xs ++ [ys] | ys <- filter (okToPlace xs) [1..8]]

-- | Return True if it's ok to place a queen on this rank, given a previous
-- list of queens.
okToPlace :: [Int] -> Int -> Bool
okToPlace xs rank = not $ or [threatensRank xs rank
                             ,threatensDiagonalUp xs rank
                             ,threatensDiagonalDown xs rank]

-- | Return True if this queen attacks any other queens on the rank
threatensRank :: [Int] -> Int -> Bool
threatensRank [] _    = False
threatensRank xs rank = rank `elem` xs

-- | Return True if this queens attacks any other queens on an upward diagonal
threatensDiagonalUp :: [Int] -> Int -> Bool
threatensDiagonalUp [] _    = False
threatensDiagonalUp xs rank = (rank + 1 == last xs) || threatensDiagonalUp (init xs) (rank + 1)

-- | Return True if this queens attacks any other queens on a downwards diagonal
threatensDiagonalDown :: [Int] -> Int -> Bool
threatensDiagonalDown [] _    = False
threatensDiagonalDown xs rank = (rank - 1 == last xs) || threatensDiagonalDown (init xs) (rank - 1)
