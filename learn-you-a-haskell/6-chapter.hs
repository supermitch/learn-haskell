-- Higher Order Functions

-- Curried Functions

{--

The type of max:

max :: (Ord a) => a -> a -> a

can be written as:

max :: (Ord a) => a -> (a -> a)

A simple example: Multiply Three numbers:

--}

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z


