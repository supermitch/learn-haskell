main = do
    putStrLn "Enter a string with brackets in it: "
    input <- getLine
    putStrLn ("Your input was: " ++ input)
    putStrLn ("Brackets"  ++ (describeBool $ bracketMatch input) ++ " matched!")


bracketMatch :: String -> Bool
bracketMatch [] = error "Must provide a string input"
bracketMatch [x] = False
bracketMatch xs
    | even $ length brackets = True
    | odd $ length brackets = False
    where brackets = filter (`elem` "()") xs


describeBool :: Bool -> String
describeBool b
    | False = " are not"
    | True = " are"
