-- file: ch04/SuffixTree.hs

-- as-pattern is a handy way to save pattern value as a variable:
-- The (_:xs') is bound to the variable xs
suffixes :: [a] -> [[a]]
suffixes xs@(_:xs') = xs : suffixes xs'
suffixes _          = []
-- e.g. ghci> suffixes "foo" => ["foo", "oo", "o"]

-- versus:
noAsPattern :: [a] -> [[a]]
noAsPattern (x:xs) = (x:xs) : noAsPattern xs
noAsPattern _      = []
-- Wasteful to recreate the (x:xs) copy in the body of our function

-- Composition allows much cleaner code.
suffixes2 xs = init (tails xs)

-- that kind of pattern can be written as a composition:
compose :: (b -> c) -> (a -> b) -> a -> c
compose f g x = f (g x)

-- So now we can compose our functions:
suffixes3 xs = compose init tails xs

-- of course, we can also curry the functions:
suffixes4 = compose init tails

-- and finally, we can just use the Haskell built-in composition function: (.)
suffixes5 = init . tails
