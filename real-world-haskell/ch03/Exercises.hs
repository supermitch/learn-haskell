-- file: ch03/Exercises.hs

-- 1. Write a function to count number of elements in a list.

counter :: [a] -> Int
counter [] = 0
counter (x:xs) = 1 + counter xs

-- 2. Add type signature

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
