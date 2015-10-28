main = do
    putStrLn "Please enter a palindrome (or not!)"
    input <- getLine
    let result = describeBool $ isPalindrome input
    putStrLn ("You wrote: " ++ input ++ " which" ++ result ++ " a palindrome!")

isPalindrome :: String -> Bool
isPalindrome [] = True
isPalindrome [x] = True
isPalindrome (x:xs)
    | x == last xs = isPalindrome $ init xs
    | otherwise = False

describeBool :: Bool -> String
describeBool b
    | False = " is not"
    | True = " is"
