import Prelude hiding (and, concat, elem)

and :: [Bool] -> Bool
--ad [] = True
--ad (b : bs) = b && ad bs

--and [] = True
--and (b : bs)
--    | b = and bs
--    | otherwise = False

--and [] = False
--and (b : bs) = b && and bs

--and [] = False
--and (b : bs) = b && and bs

--and [] = True
--and (b : bs)
--    | b == False = False
--    | otherwise = and bs

--and [] = True
--and (b : bs) = b || and bs

--and [] = True
--and (b : bs) = and bs && b

and [] = True
and (b : bs)
    | b = b
    | otherwise = and bs

test_and = do
    print("True", and [True, True, True])
    print("False", and [True, False, False])

-- Ex. 5: Concat
concat :: [[a]] -> [a]
--concat [] = []
--concat (xs : xss) = xs : concat xss

--concat [] = []
--concat (xs :xss) = xs ++ concat xss

--concat [] = [[]]
--concat (xs :xss) = xs ++ concat xss

concat [[]] = []
concat (xs :xss) = xs ++ concat xss

test_concat = do
    print(concat [[1,2,3], [4,5,6], [7,8,9]])

-- Ex. 6:
rep :: Int -> a -> [a]
--rep 1 x = x
--rep n x = x : rep (n - 1) x

--rep 0 _ = []
--rep n x = x : rep (n - 1) x : x

--rep 1 _ = []
--rep n x = rep (n - 1) x ++ [x]

rep 0 _ = []
rep n x = x: rep (n - 1) x
test_rep = do
    print("[4,4,4]", rep 4 4)
    print("[]", rep 0 4)
    print("[2]", rep 1 2)
    print("aaa", rep 3 'a')

-- Ex. 8:
elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem x (y : ys)
    | x == y = True
    | otherwise = elem x ys

test_elem = do
    print("True", elem 2 [1..10])
    print("False", elem 2 [3..10])

-- Ex. 9: Merge
merge :: Ord a => [a] -> [a] -> [a]


test_merge = do
    print("[1,2,3,4,5,6]", merge [2,5,6] [1,3,4])

