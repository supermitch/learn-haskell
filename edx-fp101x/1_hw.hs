-- Week 1

--double x = x + x

quadruple x = double (double x)

factorial n = product [1..n]

average ns = sum ns `div` length ns

qsort [] = []
qsort (x : xs) = qsort larger ++ [x] ++ qsort smaller
  where
    smaller = [a | a <- xs, a <= x]
    larger = [b | b <- xs, b > x]

-- Week 2
second xs = head (tail xs) -- 5

swap (x, y) = (y, x) -- 6

pair x y = (x, y) -- 7

double x = x * 2 -- 8

palindrome xs = reverse xs == xs -- 9

twice f x = f (f x) -- 10

check xs = take 3 (reverse xs) -- 18


