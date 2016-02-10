import Data.List (sortBy)
import Data.Function (on)

-- file: ch03/Exercises.hs

-- 1. Write a function to count number of elements in a list.
-- 2. Add type signature
counter :: [a] -> Int
counter [] = 0
counter (x:xs) = 1 + counter xs


-- 3. Write a function to compute mean of a list.
--    (`fromIntegral` converts integer into floats)
myMean :: (Fractional a) => [a] -> Maybe a
myMean [] = Nothing
myMean xs = Just (sum xs / fromIntegral (counter xs))


-- 4. Turn a list into a palindrome, e.g. [1..3] -> [1, 2, 3, 3, 2, 1]
palindrome :: [a] -> [a]
palindrome [] = []
palindrome xs = xs ++ reverse xs


-- 5. Write a function to determine if a list is a palindrome.
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome [] = True
isPalindrome [_] = True
isPalindrome (x:xs)
    | x == last xs = isPalindrome (init xs)
    | otherwise = False

-- Or the incredibly obvious:
isPalindrome' :: (Eq a) => [a] -> Bool
isPalindrome' xs
    | xs == reverse xs = True
    | otherwise = False


-- 6. Create a function that sorts lists of lists by length of inner list.
--    Consider "sortBy" in Data.List
lengthSort :: [[a]] -> [[a]]
lengthSort xs = sortBy (compare `on` length) xs


{- 7. Write a function intersperse' that operates like Python's join.
      intersperse :: a -> [[a]] -> [a]
      e.g.
        ghci> intersperse ',' []
        ""
        ghci> intersperse ',' ["foo"]
        "foo"
        ghci> intersperse ',' ["foo","bar","baz","quux"]
        "foo,bar,baz,quux"
-}

intersperse :: a -> [[a]] -> [a]
intersperse _ []     = []
intersperse y (x:[]) = x
intersperse y (x:xs) = x ++ [y] ++ intersperse y xs
