module Lab3 where

-----------------------------------------------------------------------------------------------------------------------------
-- LIST COMPREHENSIONS
------------------------------------------------------------------------------------------------------------------------------

-- ===================================
-- Ex. 0 - 2
-- ===================================

evens :: [Integer] -> [Integer]
evens xs = [x | x <- xs, even x]

-- ===================================
-- Ex. 3 - 4
-- ===================================

-- complete the following line with the correct type signature for this function
squares :: Integer -> [Integer]
squares n
    | n == 0 = []
    | n >= 1 = [x*x | x <- [1..n]]

sumSquares :: Integer -> Integer
sumSquares n = sum (squares n)

-- ===================================
-- Ex. 5 - 7
-- ===================================

-- complete the following line with the correct type signature for this function
squares' :: Integer -> Integer -> [Integer]
squares' m n
    | m == 0 = []
    | otherwise = [x*x | x <- [1..(m+n)], x > n]

sumSquares' :: Integer -> Integer
sumSquares' x = sum . uncurry squares' $ (x, x)

-- ===================================
-- Ex. 8
-- ===================================

coords :: Integer -> Integer -> [(Integer,Integer)]
coords m n = [(x, y) | x <- [0..m], y <- [0..n]]
