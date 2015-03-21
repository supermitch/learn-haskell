
-- Ex 0
--halve1 :: [a] -> ([a], [a])
--halve1 xs = (take n xs, drop n xs)
--  where n = length xs / 2

halve2 :: [a] -> ([a], [a])
halve2 xs = splitAt (length xs `div` 2) xs

halve3 :: [a] -> ([a], [a])
halve3 xs = (take (n `div` 2) xs, drop (n `div` 2) xs)
    where n = length xs

--halve4 :: [a] -> ([a], [a])
--halve4 xs = splitAt (length xs `div` 2)

halve5 :: [a] -> ([a], [a])
halve5 xs = (take n xs, drop (n + 1) xs)
    where n = length xs `div` 2

halve6 :: [a] -> ([a], [a])
halve6 xs = splitAt (div (length xs) 2) xs

--halve7 :: [a] -> ([a], [a])
--halve7 xs = splitAt (length xs / 2) xs

halve8 :: [a] -> ([a], [a])
halve8 xs = (take n xs, drop n xs)
    where n = length xs `div` 2


{-
-- Exercise 2:
import Prelude hiding ((||))
(||) :: Bool -> Bool -> Bool
False || False = False
False || True = True
True || False = True
True || True = True

ex2 = do
-}

{-
-- Exercise 3:
import Prelude hiding ((&&))
(&&) :: Bool -> Bool -> Bool
--a && b = if a then if b then True else False else False
--a && b = if not (a) then not (b) else True
--a && b = if a then if b then False else True else False
--a && b = if a then b else False
a && b = if b then a else False

ex3 = do
    print ("True", True && True)
    print ("False", True && False)
    print ("False" , False && True)
    print ("False", False && False)
-}

-- Exercise 7:
remove :: Int -> [a] -> [a]
--remove n xs = take n xs ++ drop n xs
--remove n xs = drop n xs ++ take n xs
--remove n xs = take (n + 1) xs ++ drop n xs
remove n xs = take n xs ++ drop (n + 1) xs

main = do
    print (remove 0 [1,2,3,4])

