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

--  Guards:
-- =========

bmiTell :: (RealFloat a) => a -> String
bmitell bmi
    | bmi <= 18.5 = "You're underweight."
    | bmi <= 25.0 = "You're normal."
    | bmi <= 30.0 = "You're fat."
    | otherwise   = "You're a whale."

-- You can do calcs in guards
bmiTell' :: (RealFloat a) => a -> a-> String
bmiTell' w h
    | w / h ^ 2 <= 18.5 = "You're underweight."
    | otherwise         = "blah blah..."

-- Implement max functions
max' :: (Ord a) => a -> a -> a
max' a b
    | a > b     = a
    | otherwise = b

-- Implement ordering. Note that we can define a function as infix
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
    | a > b     = GT
    | a == b    = EQ
    | otherwise = LT

-- Where clause, eliminate repetition:
bmiTell'' :: (RealFloat a) => a -> a -> String
bmiTell'' w h
    | bmi <= 18.5 = "You're skinny."
    | bmi <= 25.0 = "You're normal..."
    | otherwise   = "You're a whale."
    where bmi = w / h ^ 2

-- Where clause w/ multiple definitions
bmiTell'' :: (RealFloat a) => a -> a -> String
bmiTell'' w h
    | bmi <= skinny = "You're skinny."
    | bmi <= normal = "You're normal..."
    | otherwise   = "You're a whale."
    where bmi = w / h ^ 2
          skinny = 18.5
          normal = 25.0

{- You can do something like this also:
...
where bmi = weight / height ^ 2
      (skinny, normal, fat) = (18.5, 25.0, 30.0)
-}

-- Another example of pattern matching in guards:

initial :: String -> String -> String
initials firstName lastName = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = firstName
          (l:_) = lastName

-- Stupid example, but it works.

-- You can also define functions inside guards:
calcBMIs :: (RealFloat a) -> [(a, a)] -> [a]
calcBMIs xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2

-- "bmi weight height" is an entirely new function

