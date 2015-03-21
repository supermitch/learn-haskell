-- Ex. 1: all
alll :: (a -> Bool) -> [a] -> Bool
alll p = foldr (&&) True . map p

test_all = do
    print("True", alll (>0) [1..10])
    print("False", alll (<9) [1..10])
    print(alll (>0) [1..])
    print(alll (<9) [1..])

-- Ex. 2: any
anyy :: (a -> Bool) -> [a] -> Bool
anyy p xs = foldr (||) True (map p xs)

test_any = do
    print("True", anyy (>0) [1..10])
    print("True", anyy (<9) [1..10])
    print("False", anyy (>99) [1..10])
    print("False", anyy (<0) [1..])
    print("True", anyy (>0) [1..])
    print("True", anyy (>99) [1..])

-- Ex. 3: takeWhile
-- takeWhile, applied to a predicate p and a list xs,
-- returns the longest prefix (possibly empty) of xs of elements
-- that satisfy p
tw :: (a -> Bool) -> [a] -> [a]
tw p = foldl (\ acc x -> if p x then x : acc else acc) []
test_tw = do
    print("[1,2,3,4]", tw (<5) [1..10])
    print("[1,2,3]", tw (<4) [1..])
    print("[]", tw (>5) [1..])
    print("[]", tw (>5) [1..10])

-- Ex. 4: dropWhile
-- dropWhile p xs returns the suffix remaining after takeWhile p xs.
dw :: (a -> Bool) -> [a] -> [a]
--dw _ [] = []
--dw p (x : xs)
--    | p x = dw p xs
--    | otherwise = x : xs
dw p = foldr (\ x acc -> if p x then acc else x : acc) []
--dw p = foldl add []
--    where add [] x = if p x then [] else [x]
--          add acc x = x : acc

test_dw = do
    print("[5,6,7,8,9,10]", dw (<5) [1..10])
    print("[1,2,3]", dw (<0) [1,2,3])
    print("[]", dw (< 9) [1,2,3])
    print("[]", dw (< 9) [1..])
    print("[]", dw (< 9) [undefined])

-- Ex. 5: Map
mapp :: (a -> b) -> [a] -> [b]
--mapp f = foldr (\ x xs -> xs ++ [f x]) []
--mapp f = foldr (\x xs -> f x ++ xs) []
--mapp f = foldl (\ xs x -> f x: xs) []
mapp f = foldl (\xs x -> xs ++ [f x]) []

-- Ex. 6: Filter
flt :: (a -> Bool) -> [a] -> [a]
--flt p = foldl (\ xs x -> if p x then x : xs else xs) []
flt p = foldr (\ x xs -> if p x then x : xs else xs) []
--flt p = foldr (\ x xs -> if p x then xs ++ [x] else xs) []
--flt p = foldl (\ x xs -> if p x then xs ++ [x] else xs) []
test_flt = do
    print(flt even [1..10])

-- Ex. 7: dec2Int
dec2int :: [Integer] -> Integer
--dec2int = foldr (\ x y -> 10 * x + y) 0
--dec2int = foldl (\ x y -> x + 10 * y) 0
dec2int = foldl (\ x y -> 10 * x + y) 0
--dec2int = foldr (\ x y -> x + 10 * y) 0

test_d2i = do
    print("2345", dec2int [2..5])
    print("0", dec2int [])
    print("0", dec2int [0, 0, 0, 0])

-- Ex. 8:
compose :: [a -> a] -> (a -> a)
compose = foldr (.) id

--Fails type check:
--sumsqreven = compose [sum, map (^2), filter even]

-- Ex. 9:

add (x, y) = x + y

cury :: ((a, b) -> c) -> a -> b -> c
--cury f = \ x y -> f x y
--cury f = \ x y -> f
cury f = \ x y -> f (x, y)
--cury f = \ (x, y) -> f x y

-- Ex. 10:

minus x y = x - y

uncury :: (a -> b -> c) -> (a, b) -> c
uncury f = \ (x, y) -> f x y
--uncury f = \ x y -> f (x, y)
--uncury f = \ (x, y) -> f
--uncury f = \ x y -> f

test_uncury = do
    let b = uncury minus
    print(b (10,3))

-- Ex. 11: Unfold

unfold :: (b -> Bool) -> (b -> a) -> (b -> b) -> b -> [a]
unfold p h t x
    | p x = []
    | otherwise = h x : unfold p h t (t x)

type Bit = Int
int2bin :: Int -> [Bit]
int2bin = unfold (==0) (`mod` 2) (`div` 2)

chop8 :: [Bit] -> [[Bit]]
--chop8 [] = []
--chop8 bits = take 8 bits : chop8 (drop 8 bits)

-- or
chop8 = unfold null (take 8) (drop 8)

-- Ex. 12;
maap :: (a -> b) -> [a] -> [b]
--maap f = unfold null (f) tail
--maap f = unfold null (f (head)) tail
maap f = unfold null (f . head) tail
--maap f = unfold empty (f . head) tail



-- Ex. 13: Iterate
iter :: (a -> a) -> a -> [a]
iter f = unfold (const False) id f
--iter f = unfold (const False) f f
--iter f = unfold (const True) id f
--iter f = unfold (const True) f f
--
test_iter = do
    print(takeWhile (< 10) (iter (+2) 5))
