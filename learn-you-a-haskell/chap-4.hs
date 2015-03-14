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
addVectors :: (Num a) => (, a) -> (a, a) -> (a, a)
addVectors a b = (fst a + fst b, snd a + snd b)

-- Pattern matching way
addVectors :: (Num a) => (, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)


