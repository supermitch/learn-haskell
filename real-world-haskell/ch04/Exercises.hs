-- 1. Write your own safe version of partial list functions
import Data.Maybe

-- e.g. safeHead [1..4] = 1
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:xs) = Just x

-- e.g. safeTail [1..4] = [2, 3, 4]
safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (x:xs) = Just xs

-- e.g. safeLast [1..4] = 4
safeLast :: [a] -> Maybe a
safeLast [] = Nothing
safeLast xs = safeHead $ reverse xs

-- | safeInit [1..4] = [1, 2, 3]
safeInit :: [a] -> Maybe [a]
safeInit [] = Nothing
safeInit (x:[]) = Just []
safeInit (x:xs) = Just (x : fromMaybe [] (safeInit xs))

-- 2. Write a function 'splitWith' that acts similarly to 'words', b ut takes
-- a predicate and a list of any type, and splits it's input on every element
-- for which the predicate returns False.

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith = undefined
