-- List comprehensions
[x^2 | x <- [1..5]]

x <- [1..5] is a generator

-- Comprehensions can have multiple generators:
[(x, y) | x <- [1, 2, 3], y <- [4, 5]]

> [(1,4), (1,5), (2,4), (2,5)...]

-- Changing the order of the generators changes the order
-- of the elements in the final list:

[(x, y) | y <- [4, 5], x <- [1, 2, 3]]

> [(1,4), (2,4), (3,4), (1,5), (2,5), (3,5)]

-- Dependant generators
-- Later generators can depend on variables in earlier
-- generators:
[(x, y) | x <- [1..3], y <- [x..3]]

> [(1,1), (1,2), (1,3), (2,2), (2,3), (3,3)]

-- Example of dependant generators
concat :: [[a]] -> [a]
concat xss = [x | xs <- xss, x <- xs]

> concat [[1,2,3], [4,5], [6]]
> [1,2,3,4,5,6]

-- Guards
[x | x <- [1..10], even x]

-- Example using Guards:
factors :: Int -> [Int]
factors n =
    [x | x <- [1..n], n `mod` x == 0]

> factors 15
> [1, 3, 5, 15]

-- Use that to build a prime factors function:
prime :: Int -> Bool
prime n = factors n == [1, n]

-- A list of all primes up to a given limit:
primes :: Int -> [Int]
primes n = [x | x <- [2..n], prime x]

> primes 40
> [2,3,5,7,11,13...]

-- Zip function

zip :: [a] -> [b] -> [(a, b)]

> zip ['a', 'b', 'c'] [1, 2, 3, 4]
> [('a', 1), ('b', 2), ('c', 3)]

-- Example of zip: a function that returns a list
-- of adjacent pairs from a list:

pairs :: [a] -> [(a, a)]
pairs xs = zip xs (tail xs)

> pairs [1,2,3,4]
> [(1,2), (2,3), (3,4)]

-- Use that to write a function that decides
-- if elements in a list are sorted:

sorted :: Ord a => [a] -> Bool
sorted xs =
    and [x <= y | (x, y) <- pairs xs]

> sorted [1,2,3,4]
True

> sorted [1,3,2,4]
False

-- A function which returns a list of all positions of
-- values in a list:

positions :: Eq a => a -> [a] -> [Int]
positions x xs =
    [i | (x', i) <- zip xs [0..n], x == x']
    where n = length xs - 1

> position 0 [1, 0, 0, 1, 1, 0]
> [1,2,5]

