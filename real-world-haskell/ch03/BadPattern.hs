-- file: ch03/BadPattern.hs

badExample (x:xs) = x + badExample xs

-- If you apply this to an empty list (constructed without cons) you get a runtime error.

goodExample (x:xs) = x + goodExample xs
goodExample _      = 0

-- That will match the empty list.
