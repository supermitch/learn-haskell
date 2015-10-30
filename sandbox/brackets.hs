main = do
    putStrLn "Enter a string with brackets in it: "
    input <- getLine
    putStrLn ("Your input was: " ++ input)
    putStrLn ("Brackets"  ++ (describeBool $ bracketMatch input) ++ " matched!")

bracketMatch :: String -> Bool
bracketMatch [] = True
bracketMatch [x] = False
bracketMatch xs
    | -1 `elem` scan = False -- At any point a right bracket appears first
    | last scan /= 0 = False -- Not all left brackets have been closed
    | otherwise = True
    where scan = countBrackets xs

countBrackets :: String -> [Int]
countBrackets xs = scanl (\acc x -> if x == '(' then acc + 1 else if x == ')' then acc - 1 else acc) 0 xs

describeBool :: Bool -> String
describeBool b
    | b == True = " are"
    | otherwise = " are not"
