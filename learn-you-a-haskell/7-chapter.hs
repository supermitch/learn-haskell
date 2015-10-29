{- Chapter 7: Modules -}

-- importing is just like Python

import Data.List

numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub  -- nub is a function from Data.List

-- To import in GHCI use: `:m + Data.List Data.Map Data.Set` for example

-- You can selectively import:

import Data.List (nub, sort)

-- or even selectively hide!

import Data.List hiding (nub)

-- alternatively you can use qualified importing

import qualified Data.Map

num = length . Data.Map.nub

-- so we can use both filter (Prelude.filter) and Data.Map.filter

-- you can also import with a renamed module:

import qualified Data.Map as DM

-- All Haskell libraries can be found here:
https://downloads.haskell.org/~ghc/latest/docs/html/libraries/

-- Hoogle is how to find shit:
https://www.haskell.org/hoogle/


{- MODULE: Data.List -}

-- Data.List doesn't clash with any of the Prelude names other than
-- synonyms.

-- Some functions include:

Data.List.intersperse

intersperse 0 [1..6]
[1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6]

intercalate [1,2] [[1,1,1], [2,2,2], [3,3,3]]
[1,1,1, 1,2, 2,2,2, 1,2, 3,3,3] -- Neat.

transpose [[1,2,3], [4,5,6], [7,8,9]]
[[1, 4, 7], [2, 5, 8], [3, 6, 9]] -- super handy

concat [[3,4], [5,6], [7,8]]  -- Flattens lists of lists
[3,4,5,6,7,8]

concatMap (replicate 2) [1..3]  -- Apply function then concat
[replicate 2 1, replicate 2 2, replicate 2 3]
[[1, 1], [2, 2], [3, 3]]
[1, 1, 2, 2, 3, 3] -- Neat.

and -- is like `all` in python
and $ map (>4) [5, 6, 7 8]
and [True, True, True, True]
True

or -- is like `any` in Python
or $ map (>4) [1, 2, 3]
or [False, False, False]
False

any -- is like `or $ map f xs`
all -- is like `and $ map f xs`, e.g.

all (>4) [6, 9, 10]
True

any (==4) [2,3,4,5,6]
True

iterate -- Takes a function and start value, applies f to start, then applies
        -- f to result, then f to that result, storing each value

iterate (*2) 1
[1, 2, 4, 8, 16, ...]

takeWhile (<16) $ iterate (*2) 1
[1, 2, 4, 8]

-- Another example of takeWhile
sum $ takeWhile (<10000) $ map (^3) [1..]
53361

-- Similarly, dropWhile returns the tail

span -- is like takeWhile, but returns a pair of lists. It takes until takeWhile
     -- would have stopped: it continues while the predicate is True.

break -- is different: it breaks as soon as the predicate is True, e.g.

break (==4) [1,2,3,4,5,6,7]
([1,2,3], [4,5,6,7])

-- Break can be written as:

span (not . (==4)) [1,2,3,4,5]
[[1,2,3], [4,5]]

sort -- sorts a list
group -- groups adjacent elements into sublists. Cool.

group [1,1,1, 2,2, 3, 4,4]
[[1,1,1], [2,2], [3], [4,4]]

-- If we sort a list before grouping it, we can find out how many times each element
-- appears in a list

map (\l@(x:xs) -> (x, length l)) . group . sort $ [1,2,3,2,1,3,4,4,5,6,6,7]  -- Fancy as f
[(1,2),(2,2),(3,2),(4,2),(5,1),(6,2),(7,1)]

inits & tails -- all the 'possible' init and tail of a given list:
inits "woot"
["", "w", "wo", "woo", "woot"]
tails "what"
["what","hat","at","t",""]

-- Kinda weird...

-- Let's use tails to implement searching a list for a sublist:

search :: (Eq a) => [a] -> [a] -> Bool
search needle haystack =
    let nlen = length needle
    in foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)

-- We generate tails list... then foldl over that list. If any entry in the list
-- matches our needle, (up to the length of the needle) then our accumulator becomes True.
-- Accumulator being True continues to bubble up to the finish.

> search "ha" "whassup"
True

-- That's just a duplicate of the 'isInfixOf' function:

> "cat" `isInfixOf` "I'm a cat burglar"  -- Is case sensitive
True

-- These are similar to isPrefixOf or isSuffixOf:

> isPrefixOf "hey" "hey there!"
True
> "there!" `isSuffixOf` "Hey there!"
True

> elem 5 [1..10]  -- Is elem in the list?
True

> notElem 5 [1..4]  -- Check if element is NOT inside the list
True

-- Partition breaks a list up into two, via a predicate:
> partition (`elem` ['A'..'Z']) "BOBisaCOOLguy"
("BOBCOOL", "isaguy")

-- This is different to how span and break work, because they stop running
-- as soon as the predicate switches to False (or True, for break).


-- Find finds the first element that satisfies a predicate, but wraps the
-- response in a Maybe value:

> find (>4) [1..6]
Just 5  -- Found something
> find (>10) [1..6]
Nothing -- Empty Maybe value.

:t find
find :: (a -> Bool) -> [a] -> Maybe a

-- Note that the end result of find a `Maybe a`. Maybe is just like a list,
-- except that it can only only 0 or 1 elements. [] or [a], but not [a:as].

-- Let's try to reimplement a previous function using Maybe:

head (dropWhile (\(val, y, m, d) -> val < 1000) stock)

-- find the first value with a stock price of $1000 or more.
-- using 'head' here is not safe, because head [] raises an exception.
-- However, we could re-write that as:

find (\(val, y, m, d) -> val > 1000) stock

-- Now it will either return something like Just (1001.4, 2015, 9, 4) if a
-- > 1000 entry is found, or Nothing.

-- elemIndex returns the Maybe index of the element's location (0 based index)

:t elemIndex
elemIndex :: (Eq a) => a -> [a] -> Maybe Int
> 4 `elemIndex` [1,2,3,4,5,6]
Just 3
> 8 `elemIndex` [1,2,3,4]
Nothing

-- Neat.

> elemIndices 5 [1,5,2,5,3,5]
[1, 3, 5]

-- No need for Maybe because we either get a list, or an empty list, which
-- is equivalent to Nothing basically.

> findIndex (==4) [5,3,2,1,6,4]
Just 5

> findIndices (`elem` ['A'..'Z']) "Where Are The Caps?"
[0, 6, 10, 14]

lines -- breaks a string into lines, using \n newline character:
> lines "first\nsecond\nthird"
["first", "second", "third"]

unlines -- is just the opposite.

words -- splits a line of text into words:
> words "this is a test. What will the words be?\nNobody knows for sure!"
["this","is","a","test.","What","will","the","words","be?","Nobody","knows","for","sure!"]

unwords -- the opposite:
> unwords ["hey","there","mate"]
"hey there mate"

nub -- Eliminates duplicates:
> nub [1,2,3,1,2,3,1,2,3,4]
[1,2,3,4]

