{-
    8 Queens Problem:
    The solution must look something like: [1, 3, 5, 6, 2, 7, 9] where
    each index is a column (file) & each number is the row (rank)
    on which the queen is placed.
-}

-- | Initial Queen positions (ranks 1 to 8 in the 'a' file)
initial :: [[Int]]
initial = [[x] | x <- [1..8]]

-- | Get the 8th iteration of the solver, all of which have 8 Queens.
solutions = iterate solver initial !! 7

-- | Take a set of solutions and extend it into a set of solutions with
-- added Queens.
solver :: [[Int]] -> [[Int]]
solver xs = concat $ map addQueen xs

-- | Place one additional queen on the board, given a list of positions
-- Note that this works even when xs is an empty list.
addQueen :: [Int] -> [[Int]]
addQueen xs = [xs ++ [y] | y <- filter (okToPlace xs) [1..8]]

-- | Return True if it's ok to place a queen on this rank, given a previous
-- list of queens.
okToPlace :: [Int] -> Int -> Bool
okToPlace xs rank = not $ or $ map (threatens xs rank) [id, succ, pred]

-- | Return True if this queens attacks any other queens on either an
-- upward (succ) or downward (pred) diagonal or on the same rank (id)
threatens :: [Int] -> Int -> (Int -> Int) -> Bool
threatens [] _    _    = False
threatens xs rank dir = (dir rank == last xs) || threatens (init xs) (dir rank) dir
