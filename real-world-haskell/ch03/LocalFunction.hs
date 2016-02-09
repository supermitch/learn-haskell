-- file: ch03/LocalFunction.hs

pluralise :: String -> [Int] -> [String]
pluralise word counts = map plural counts
    where plural 0 = "no " ++ word ++ "s"
          plural 1 = "one " ++ word
          plural n = show n ++ " " ++ word ++ "s"

-- 'plural' is a local function, consisting of several possible equations.
-- local functions can freely use variables in the outer scope.

