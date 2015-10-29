http://learnyouahaskell.com/starting-out

-- Starting Out

{-
Run ghci
Can set prompt using :set prompt "ghci> "

Note that you cannot do 5 * -3, you will get an error:
    Precedence parsing error
    cannot mix `*' [infixl 7] and prefix `-' [infixl 6] in the same infix expression

Instead do 5 * (-3)

&& means boolean AND, || means boolean OR.
not negates True or False.
-}

> True && False
False
> True && True
True
> not False
True

-- etc.
-- Testing for equality:

> 5 == 5
True
> 1 == 0
False
> 5 /= 5
False
> 5 /= 4
True
> "hello" == "hello"  -- String equality
True

-- Infix & Prefix functions:

> 5 * 4 -- (*) is actually an infix function
20
> succ 8 -- prefix function
9
> min 9 10 -- multiple function arguments
9

-- Function application (func then arg with a space) has the highest
-- operator precedence.

> succ 9 + max 5 4 + 1 -- (succ 9) + (max 5 4) + 1

-- You can turn a prefix function into an infix function using backticks:

> div 92 10
9
-- alternatively:
> 92 `div` 10  -- Now it's infix
9

-- First functions:

doubleMe x = x + x
> doubleMe 9
18

doubleUs x y = x*2 + y*2
> doubleUs 3 5
16

-- Alternatively:

doubleUs x y = doubleMe x + doubleMe y -- call functions defined elsewhere

-- Order of function definition is unimportant

-- Let's use an if statement:
doubleSmallNumber x = if x > 100
                         then x
                         else x * 2

-- else is *mandatory*.
-- Can be inline:
doubleSmallnumber` x = (if x > 100 then x else x * 2) + 1

-- Valid function names:
conan'Obrien = "Hello" -- valid!
Conan'Obrien = "wrong..." -- Invalid, cannot capitalize functions

-- When a function takes no parameters it is called a "definition" or a "name".


-- Intro to Lists

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
