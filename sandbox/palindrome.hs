main = do
    putStrLn "Please enter a palindrome (or not!)"
    input <- getLine
    let result = describeBool $ isPalindrome input
    putStrLn ("You wrote: " ++ input ++ " which" ++ result ++ " a palindrome!")

isPalindrome :: String -> Bool
isPalindrome [] True
isPalindrome [x] True
isPalindrome (xs)
    | head s == last string = isPalindrome $ init $ tail s
    | otherwise = False

describeBool :: Bool -> String
describeBool b
    | False = " is not"
    | True = " is"
