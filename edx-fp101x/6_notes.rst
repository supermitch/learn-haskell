======================
Higher-Order Functions
======================

Part 1
------

Higher order functions take a function as an argument
or return a function as a result. Example::

    twice :: (a -> a) -> a -> a
    twice f x == f (f x)

Example: The **Map** function applies a function to every elment of a list::

    map :: (a -> b) -> [a] -> [b]

    > map (+1) [1,3,5,7]
    [2,4,6,8]

Remember (+1) is a "section". Implicitly defined as Lambda x: x + 1.

Map functions can very easily be applied as list comprehensions::

    map f xs = [f x | x <- xs]

But you can also define it recursively::

    map f []     = []
    map f (x:xs) = f x : map f xs

Example: The **Filter** function, which selects every element from a list
that satisfies a predicate. ::

    filter :: (a -> Bool) -> [a] -> [a]

    > filter even [1..10]
    [2,4,6,8,10]

again, can be defined using list comprehension or recursion ::

    filter p xs = [ x | x <- xs, p x]

or ::

    filter p []     = []
    filter p (x:xs)
        | p x       = x : filter p xs
        | otherwise = filter p xs

Part 2
------

A number of functions on lists can be defined using the following
simple pattern of recursion::

    f [] = v
    f (x:xs) = x (+) f xs

For example::

    sum []     = 0
    sum (x:xs) = x + sum xs

    product []     = 1
    product (x:xs) = x * product xs

    and []     = True
    and (x:xs) = x && xs

The higher-order function ``foldr`` ("Fold Right") encapsulates this
simple pattern of recursion, with the function (+) and the value v
as arguments. For example::

    sum = foldr (+) 0
    product = foldr (*) 1
    or = foldr (||) False
    and = foldr (&&) True

Foldr itself can be defined using recursion::

    foldr :: (a -> b -> b) -> b -> [a] -> b
    foldr f v []     = v
    foldr f v (x:xs) = f x (foldr f v xs)

However it is best to think of foldr *non-recursively*, as
simultaneously replacing each (:) in a list by a given function,
and [] by the given value.

For example::

    sum [1,2,3]
    = foldr (+) 0 [1,2,3]
    = foldr (+) 0 (1:(2:3:[])))
    = 1 + (2 + (3 + 0))
    = 6

We replaced each (:) by (+) and [] by 0.

Other ``foldr`` examples::

    length       :: [a] -> Int
    length []     = 0
    lenght (_:xs) = 1 + length xs

We see that length is actually another instance of foldr. ::

    length [1,2,3]
    length (1:(2:(3: [])))
    1+(1+(1+0))
    3

If we replaced (:) with Lambda _ n: 1 + n and [] = 0::

    length = foldr (\ _ n -> 1 + n) 0

Reverse::

    reverse [] = []
    reverse (x:xs) = reverse xs ++ [x]

A little bit tricky because the recursive call is on the left... unlike
the ``length`` example. ::

    reverse [1,2,3]
    = reverse (1:(2:(3: [])))
    = (([] ++ [3]) ++ [2]) ++ [1]
    = [3,2,1]

We replaced each (:) by Lambda x xs -> xs ++ [x]. Hence ::

    reverse = foldr (\ x xs -> xs ++ [x]) []

Finally, we note that the append function has a particularly compact
definition using foldr::

    (++ ys) = foldr (:) ys

Part 3
------

A few other standard higher-order functions.

The library function **(.)** returns the composition of two functions as a
single function::

    (.)   :: (b -> c) -> (a -> b) -> (a -> c)
    f . g  = \x -> f (g x)

For example::

    odd :: Int -> Bool
    odd  = not . even

Use function composition sparingly, because it's hard to read, for others.

**all** function, decides if every element of a list satisfies
a give predicate::

    all     :: (a -> Bool) -> [a] -> Bool
    all p xs = and [p x | x <- xs]

For example::

    > all even [2,4,6,8,10]
    True

**any** is similar::

    any     :: (a -> Bool) -> [a] -> Bool
    any p xs = or [p x | x <- xs]

    > any isSpace "abc def"
    True

**takeWhile** selects while a predicate holds::

    takeWhile :: (a -> Bool) -> [a] -> [a]
    takeWhile p []     = []
    takeWhile p (x:xs)
        | p x          = x : takeWhile p xs
        | otherwise    = []

    > takeWhile isAlpha "abc def"
    "abc"

**dropWhile** removes elements while a predicate holds::

    dropWhile :: (a -> Bool) -> [a] -> [a]
    dropWhile p []     = []
    dropWhile p (x:xs)
        | p x          = dropWhile p xs
        | otherwise    = x:xs

Jam Session: Church Numerals
----------------------------

type Church = (a -> a) -> a -> a

zero = \s z -> z

one = \s z -> s z

two = \s z -> s (s z)
    = \s z -> (s . s) z
    = \s   -> s . s

c2i x = x (+1) 0
c2i two = (\s z -> s (s z)) (+1) 0

wtf...
