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

-- e.g. splitWith (odd) [1..7] = [[2], [4], [6]]
--      splitWith (odd) [2, 2, 2, 1, 2, 2, 3, 4] = [[2, 2, 2], [2, 2], [4]]

s1 = [2, 2, 2, 1, 2, 4, 6, 3, 8] -- [[2,2,2], [2,4,6], [8]]
s2 = [1..7] -- [[2], [4], [6]]

splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith p [] = []
splitWith p xs = fst broken : splitWith p (dropWhile p (snd broken))
    where broken = break p evens
          evens = dropWhile p xs

