-- Function Syntax
-- http://learnyouahaskell.com/syntax-in-functions

-- Pattern Matching
lucky :: (Integral a) => a -> String
lucky 7 = "Lucky number 7!"
lucky x = "Sorry, no such luck."

-- Enables recursion
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- Failed pattern Match
-- trying charName 'h' failed with Non-exhaustive pattern Exception
charName :: Char -> String
charName 'a' = "Albert"
charName 'm' = "Mitch"

-- Non pattern matched method
--addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
--addVectors a b = (fst a + fst b, snd a + snd b)

-- Pattern matching way
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c
third (_, _, z) = z

-- Custom 'head' implementation
head' :: [a] -> a
head' [] = "You can't head an empty list"
head' (x:xs) = x

-- Custom recursive 'length' implementation
length' :: (Num b) => [a] -> b
length' [] = 0
length' (x:xs) = 1 + length' xs

-- Custom recursive 'sum' implementation
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- Variable 'patterns'
firstLetter :: String -> String
firstLetter "" = "Empty string input is no good"
firstLetter all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

-- all@ saves us having to retype (x:xs), we've named that pattern "all"

-- Guards:


