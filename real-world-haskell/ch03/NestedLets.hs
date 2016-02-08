-- file: ch03/NestedLets.hs

foo = let a = 1
        in let b = 2
          in a + b

-- Ugly.

-- You can also 'shadow' outer values. Same name, different type and value.

bar = let x = 1
       in ((let x = "foo" in x), x)

{- Results in:
> bar
("foo", 1)

-}

-- We can also shadow a function's parameters, leading to even stranger
-- results. What is the type of this function?
quux a = let a = "foo"
          in a ++ "eek!"

{-
>:type quux
quux :: t -> [Char]

The function's argument a is never used.
-}
