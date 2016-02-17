-- file: ch04/Plus.hs

a `plus` b = a + b

data a `Pair` b = a `Pair` b
                  deriving (Show)

-- We can use the constructor either as prefix or infix
foo = Pair 1 2
bar = 1 `Pair` 2
