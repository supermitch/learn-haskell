-- file: ch04/Map.hs

import Data.Char (toUpper)

square :: [Double] -> [Double]
square [] = []
square (x:xs) = x * x : square xs

-- rewrite using map

square2 xs = map squareOne xs
    where squareOne x = x * x

uppercase :: String -> String
uppercase [] = []
uppercase (x:xs) = toUpper(x) : uppercase xs

-- rewrite using map

uppercase2 xs = map toUpper xs

-- Let's implement map ourselves:

myMap :: (a -> b) -> [a] -> [b]
myMap f (x:xs) = f x : myMap f xs
myMap _ [] = []
