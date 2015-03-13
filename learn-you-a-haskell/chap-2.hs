-- http://learnyouahaskell.com/

doubleMe x = x + x

doubleUs x y = x*2 + y*2

-- Or better yet
doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                        then x
                        else x*2

-- One liner
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

{- Operators
 - ++ extend lists [1,2] ++ [3,4] -> [1,2,3,4]
 - works with strings
 - : cons prepends items to a list or string
 -  e.g. 5:[1,2,3] -> [5,1,2,3]
 -       'A': "small cat" -> "A small cat"
 - !! index
 -  e.g. "Steve Buscemi" !! 6 -> 'B'
 -       [1,2,3] !! 1 -> 2
 -}

{- List functions
 - head - First element
 - tail - Remaining elements
 - last - Last element
 - init - Initial elements
 - length - count elements
 - null - return True if empty
 - reverse - reverses list
 - take x - extract list of x elements
 - drop x - drops first x elements
 - maximum xs
 - minimum xs
 - sum xs
 - product xs
 - x `elem` ys - return True if x in ys
 -}

{- List ranges
 - Use .. to generate ranges
 - e.g. [1,2..20]
 - step is inferred, or defaults to 1
 - [1,3..] Infinite list
 -}

 {- Infinite iterators
  - cycle xs -> returns repeats of xs
  - repeat x -> return list of endless x
  -}

-- List Comprehensions

modSeven = [x | x <- [50..100], x `mod` 7 == 3]

boomBangs xs = [ if x < 10 then "Boom!" else "Bang!" | x <- xs, odd x]

-- Multiple predicates
notValues = [x | x <- [10..20], x /= 13, x /= 15, x /= 19]

-- Multiple sources
prodComp = [ x*y | x <- [2,5,10], y <- [8,10,11]]

-- Length implementation
length' xs = sum [1 | _ <- xs]

-- String comprehensions
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

-- Nested comprehensions
removeOddNested xxs = [[x | x <- xs, even x] | xs <- xxs]

-- Tuples

{-- Tuple functions
 - fst (8, 11) -> 8 aka "First"
 - snd (8, 11) -> 11 aka "Second"
 - zip xs ys -> [(x1, y1), (x2, y2)..]
 -}

allTriangles = [ (a,b,c) | c <- [1..10], b <- [1..10], a <- [1..10]]

rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b],
    a^2 + b^2 == c^2, a+b+c == 24]
