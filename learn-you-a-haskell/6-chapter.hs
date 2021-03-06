-- Higher Order Functions

-- Curried Functions
-- =================

{--

The type of max:

max :: (Ord a) => a -> a -> a

can be written as:

max :: (Ord a) => a -> (a -> a)

A simple example: Multiply Three numbers:

--}

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z


-- You can "section" an infix function:

divideByTen :: (Floating a) => a -> a
divideByTen = (/10)

-- divideByTen 200 is results in 200/10, or (/10) 200 or (/) 200 10

-- Another example:

isUpperAlphanum :: Char -> Bool
isUpperAlphanum = (`elem` ['A'..'Z'])

-- so isUpperAlphanum 'B' is equivalent to: 'B' `elem` ['A'..'Z']

-- Subtract. Note that (-4) is minus four, NOT an infix function which
-- subtracts 4. Use the `subtract` function explicitly.

subtractFour :: Num a => a -> a
subtractFour = (subtract 4)

-- Higher Order Functions
-- ======================

-- Functions that return other functions & can take functions as parameters

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ _ [] = []
zipWith' _ [] _ = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f x y = f y x

-- Map is a classic example of a higher order function

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map f xs

-- Filter is another nice one. 'p' is the predicate.
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs)
    | p x       = x : filter p xs
    | otherwise = filter p xs


-- Find the largest number under 100,000 that's divisible by 3829
-- (without using list comprehensions)

findIt :: (Integral a) => a
findIt = head (filter p (filter (< 100000) [900000,899999..]))
    where p x = x `mod` 3829 == 0

-- find the sum of all odd squares that are smaller than 10,000

sumIt :: (Integral a) => a
sumIt = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))

-- Collatz sequence.
-- take N, if even, divide by two. If odd, multiply by 3 and add 1.
-- Add new number, and continue...

-- Q: For all starting numbers, between 1 and 100, how many chains have a
-- length greater than 15?

-- First, write a function that produces a chain:

collatz :: (Integral a) => a -> [a]
collatz 1 = [1]
collatz n
    | even n = n : collatz (n `div` 2)
    | odd n = n : collatz (n * 3 + 1)

countCollatz :: Int
countCollatz = length (filter isLong (map collatz [1..100]))
    where isLong xs = length xs > 15

-- Lambdas
-- =======

-- alternative to countCollatz, above:

numLongChains :: Int
numLongChains = length (filter (\xs -> length xs > 15) (map collatz [1..100]))

-- Lambdas can erroneously replace partial applications

-- map (+3) [1,6,3,2]
-- versus: (Don't do this!)
-- map (\x -> x + 3) [1,6,3,2]

-- lambdas can take multiple arguments:
-- zipWith (\a b -> (a * 30 + 30) / b) [5,4,3,2,1] [1,2,3,4,5]
-- [153.0, 61.5, 31.0, 15.75, 6.6]

-- You can also pattern match in a lambda:
-- map (\(a,b) -> a + b) [(1,2), (3,5), (6,3)]

-- Parentheses limit scope of lambdas, but are optional. These are equivalent:

addThree :: (Num a) => a -> a -> a -> a
addThree x y z = x + y + z

-- is equivalent to:

addThreeLambda :: (Num a) => a -> a -> a -> a
addThreeLambda = \x -> \y -> \z -> x + y + z

-- The second one is an ugly demonstration of obvious currying.

-- Sometimes this lambda notation is more clear:

flip'' :: (a -> b -> c) -> b -> a -> c
flip'' f = \x y -> f y x

-- equivalent to: flip f x y = f y x
-- Clearly indicates that we are returning a function

-- FOLDS
-- =====

sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

-- sum' [3,5,2,1] = 11

{- The lambda is the binary function
0 is the starting value (aka "accumulator")
xs is the list to be folded

aka (((0 + 3) + 5) + 2) + 1

Can be written much more succinctly: -}

sum'' :: (Num a) => [a] -> a
sum'' = foldl (+) 0

{-
 Which returns a partially applied function that accepts a list for folding.

 Generally, if you have a function of the form: func a = bar b a
 you simply re-write it as func = bar b, because of currying.
-}

-- Implement elem` with foldl:

elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldl (\acc x -> if x == y then True else acc) False ys

-- foldr just pulls from the right of the list, and reverses the
-- argument order in the lambda:

map'' :: (a -> b) -> [a] -> [b]
map'' f xs = foldr (\x acc -> f x : acc) [] xs

{-
-- Here we used an empty list as start value and did cons to construct
-- list for each item.

e.g.

map' (+3) [1,2,3] --> 3+1:(3+2:(3+3:[])) --> [4,5,6]

or with foldl:

map'' f xs = foldl (\acc x -> acc ++ [f x]) [] x

++ is much more expensive than : (cons)!
----------------------------------------

foldl1 and foldr1 are the same, except they don't take an initial value,
they use the starting list value.

e.g. this fully implemented sum function!
sum = foldl1 (+)

Numerous examples of standard library functions using folds:

-}

maximum' :: (Ord a, Num a) => [a] -> a
maximum' = foldr1 (\x acc -> if x > acc then x else acc)

reverse' :: [a] -> [a]
reverse' = foldl (\acc x -> x : acc) []

-- My version:
product' :: (Num a) => [a] -> a
product' = foldl (\acc x -> x * acc) 1

-- Much better:
product'' :: (Num a) => [a] -> a
product'' = foldr1 (*)

filter'' :: (a -> Bool) -> [a] -> [a]
filter'' p = foldr (\x acc -> if p x then x : acc else acc) []

-- For these cases, you just ignore the accumulator (1 in both cases),
-- iterate through the list, and return the final 'x':

head' :: [a] -> a
head' = foldr1 (\x _ -> x)

last' :: [a] -> a
last' = foldl1 (\_ x -> x)


{-
SCANL & SCANR

scanl and scanr are just like foldl and foldr, but they return
intermediate accumulator states as as list

scanl (+) 0 [3,5,2,1] --> [0,3,8,10,11]
scanr (+) 0 [3,5,2,1] --> [11,10,8,3,1,0]

scanl1 (\acc x -> if x > acc then x else acc) [3,4,5,3,7,9,2,1] -->
[3,4,5,5,7,9,9,9]

scanl (flip (:)) [] [3,2,1]
[[], [3], [2,3], [1,2,3]]

Scans are used to monitor the prgression of a function that can be
implemented as a fold.

"How many elements does it take for the sum of the roots of all natural
numbers to exceed 1000".
-}

sqrtSum :: Int
sqrtSum = length (takeWhile (< 1000) (scanl1 (+) (map sqrt [1..]))) + 1


{-
FUNCTION APPLICATION WITH $

($) :: (a -> b) -> a -> b
f $ x = f x

consider:

sum (map sqrt [1..10])  -- brackets are required

or can be written as:

sum $ map sqrt [1..10]  -- fancy

similarly:

sum (3 + 4 + 5)

can be written as:

sum $ 3 + 4 + 5

Another:

sum (filter (> 10) (map (*2) [2..10]))  -- multiply list by 2 and filter by > 10, then sum

or better yet:

sum $ filter (> 10) $ map (*2) [2..10]  -- fancy

However you can use it like a function (which it is...)
-}

map ($ 3) [(4+), (10*), (^2), sqrt]
[7.0, 30.0, 9.0, 1.73205]  -- nutty...


{-
FUNCTION COMPOSITION

(.) :: (b -> c) -> (a -> b) -> a -> c
f . g = \x -> f (g x)

Note that g() returns type b and f() takes type b.

e.g. negate . (* 3) yields a new function that returns the negative multiple of 3.

This is useful as a clearer, more concise kind of lambda.
-}

map (\x -> negate (abs x)) [5, -3, -6, 7, 2]
[-5, -3, -6, -7, -2]

-- using function composition we can re-write this as:

map (negate . abs) [5, -3, -6, 2] -- cool.

-- function composition is right-associative, so
-- f (g (h x)) is (f . g . h) x

map (\xs -> negate (sum (tail xs))) [[1..5], [3..6], [1..7]]
[-14, -15, -27]

-- or as a function composition

map (negate . sum . tail) [[1..5], [3..6], [1..7]]

-- If a function takes more than one parameter, you have to partially apply them..

sum (replicate 5 (max 6.7 8.9))  -- can be re-written as:

(sum . replicate 5 . max 6.7) 8.9  -- or:
sum . replicate 5 . max 6.7 $ 8.9

{- If you want to rewrite a complex function using composition, start by putting the
last parameter of the innermost function after a $ and them composing all the others:

e.g. -}

replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8]))) -- can be rewritten as:

replicate 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8] -- yikes. wtf.

-- Another use is point-free style:

sum' :: (Num a) => [a] -> a
sum' xs = foldl (+) 0 xs

-- because of currying we can omit the xs

sum' = foldl (+) 0

-- That is called "point free style"
-- How would you write this in point free style?

fn x = ceiling (negate (tan (cos (max 50 x))))

-- Like this:

fn = ceiling . negate . tan . cos . max 50

-- Let's rewrite our "sum of odd squares smaller than 10,000":

oddSquareSum :: Integer
oddSquareSum = sum (takeWhile (< 10000) (filter odd (map (^2) [1..])))

-- let's re-write this using composition:

oddSquareSum = sum . takeWhile (< 10000) . filter odd . map (^2) $ [1..]

-- However, that is ugly. Normal readable code would be something like this:

oddSquareSum =
    let oddSquares = filter odd $ map (^2) [1..]
        belowLimit = takeWhile (< 10000) oddSquares
    in sum belowLimit

-- (... personally I think that's awful but that's just me)
