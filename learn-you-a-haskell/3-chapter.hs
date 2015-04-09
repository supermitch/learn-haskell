-- Types and Typeclasses
-- http://learnyouahaskell.com/types-and-typeclasses

-- in GHCI, :t tells you the type
-- :t True -> True :: Bool
-- :: means "has type of"

-- Function type declaration
removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- alternatively
removeNonUppercase :: String -> String

-- Multiple parameters
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- Integer types: huge ints
factorial :: Integer -> Integer
factorial n = product [1..n]

-- Float types
circumference :: Float -> Float
circumference r = 2 * pi * r

-- Double types = double the Float
circumference' :: Double -> Double
circumference' r = 2 * pi * r

-- Polymorphic functions
-- :t head gives [a] -> a
-- takes a list of any type and returns one element of that type

{- Typeclasses
:t (==)
    (==) :: Eq a => a -> a -> Bool

:t elem
    elem :: Eq a => a -> [a] -> Bool
Means that elements of type a must support Eq interface (be part of
Eq Typeclass)

'Eq' is for equality
'Ord' is for ordering
'Show' required for string representation
'Read' is for reading strings (like eval)
'Enum'
'Bounded'
'Num' (numeric)
'Integral' Int & Integer
'Floating' Float & Double

Aside: (*) turns * from a default infix function to a regular function,
for example:
2 * 4 = 8
(*) 2 4 = 8

Basically the reverse of `mod`:
mod 4 2 = 0
4 `mod` 2 = 0


Explicity Type Annotations

If we check the read type:

:t read
    read :: (Read a) => String -> a

read "5" - 2
    3

However:
read "4"
    Error: Ambiguous type variable `a`...

GHCI can't infer return type, because `a` type variable
is not defined in type signature.


However, we can do this:
read "5" :: Int
    5
read "5" :: Float
    5.0
(read "5" :: Float) * 4
    20.0

And example of multiple TypeClasses:

:t fromIntegral
    fromIntegral :: (Integral a, Num b) => a -> b

It converts an Integral number into a general Num type.

