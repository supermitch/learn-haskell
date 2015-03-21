import Data.Char

let2int :: Char -> Int
let2int c
    | isLower c = ord c - ord 'a'
    | isUpper c = ord c - ord 'A'
    | otherwise = ord c - ord 'a'

int2lower :: Int -> Char
int2lower n = chr (ord 'a' + n)

int2upper :: Int -> Char
int2upper n = chr (ord 'A' + n)

shift :: Int -> Char -> Char
shift n c
    | isLower c = int2lower ((let2int c + n) `mod` 26)
    | isUpper c = int2upper ((let2int c + n) `mod` 26)
    | otherwise = c

encode :: Int -> String -> String
encode n xs = [shift n x | x <- xs]

ceasar = do
    print(encode 13 "Think like a Fundamentalist Code like a Hacker")

riffle :: [a] -> [a] -> [a]
--riffle xs ys = concat [[x,y] | x <- xs, y<-ys]
riffle xs ys = concat [[x,y] | (x,y) <- xs `zip` ys]
--riffle xs ys = [x, y | (x, y) <- xs `zip` ys]
--riffle xs ys = [x : [y] | x <- xs, y <- ys]

rif = do
    riffle [1,2,3] [4,5,6]

divides :: Int -> Int -> Bool
divides x y = mod x y == 0

divisors :: Int -> [Int]
divisors x = [d | d <- [1..x], x `divides` d]
--divisors x = [d | d <- [1..x], d `divides` x]
--divisors x = [d | d <- [2..x], x `divides` d]
--divisors x = [d | d <- [1..x], x divides d]

ldiv = do
    print(divides 15 2)
    print(divides 15 3)
    print(divisors 15)

