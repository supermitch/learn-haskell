-- Defining recursive functions

factorial 0 = 1
factorial n = n * factorial (n-1)

-- e.g. factorial 3 = 3 * factorial 2 = 3 * (2 * factorial 1) ...

product :: [Int] -> Int
product [] = 1
product (n:ns) = n * product ns

length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs

reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]

zip :: [a] -> [b] -> [(a, b)]
zip [] _ = []
zip _ [] = []
zip (x:xs) (y:ys) = (x, y) : zip xs ys

-- Remove the first n elements of a list
drop :: Int -> [a] -> [a]
drop 0 xs = xs
drop _ [] = []
drop n (_:xs) = drop (n-1) xs

-- Appending two lists
(++) :: [a] -> [a] -> [a]
[] ++ ys = ys
(x:xs) ++ ys = x : (xs ++ ys)

-- Quicksort in Haskell
qsort :: [Int] -> [Int]
qsort [] = []
qsort (x:xs) =
    qsort smaller ++ [x] ++ qsort larger
    where
        smaller = [a | a <- xs, a <= x]
        larger = [b | b <- xs, b > x]

-- Product a list w/ n identical els:
replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate n a = [a] ++ replicate (n-1) a

-- Select nth el of a list:
(!!) :: [a] -> Int -> a
(!!) x:xs 0 = x
(!!) x:xs n = (!!) xs (n-1)
(!!) [] _ = []

-- Decide if a value is an el of a list:
elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem a x:xs
    | a == x = True
    | otherwise = elem a xs


