-- file ch02/lastButOne.hs
lastButOne :: [a] -> a
lastButOne xs = head (tail (reverse xs))
