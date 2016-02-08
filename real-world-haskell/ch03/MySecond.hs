-- file: ch03/MySecond.hs

mySecond :: [a] -> a

mySecond xs = if null (tail xs)
              then error "List too short"
              else head (tail xs)

-- We can use the Maybe type for a more controlled approach

safeSecond :: [a] -> Maybe a
safeSecond [] = Nothing
safeSecond xs = if null (tail xs)
                then Nothing
                else Just (head (tail xs))

-- Lets' improve the readability with pattern matching:

tidySecond :: [a] -> Maybe a
tidySecond (_:x:_) = Just x
tidySecond _       = Nothing
