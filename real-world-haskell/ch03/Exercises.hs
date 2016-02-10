import Data.List (sortBy)
import Data.Function (on)

-- file: ch03/Exercises.hs

-- 1. Write a function to count number of elements in a list.
-- 2. Add type signature
counter :: [a] -> Int
counter [] = 0
counter (x:xs) = 1 + counter xs


-- 3. Write a function to compute mean of a list.
--    (`fromIntegral` converts integer into floats)
myMean :: (Fractional a) => [a] -> Maybe a
myMean [] = Nothing
myMean xs = Just (sum xs / fromIntegral (counter xs))


-- 4. Turn a list into a palindrome, e.g. [1..3] -> [1, 2, 3, 3, 2, 1]
palindrome :: [a] -> [a]
palindrome [] = []
palindrome xs = xs ++ reverse xs


-- 5. Write a function to determine if a list is a palindrome.
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome [] = True
isPalindrome [_] = True
isPalindrome (x:xs)
    | x == last xs = isPalindrome (init xs)
    | otherwise = False

-- Or the incredibly obvious:
isPalindrome' :: (Eq a) => [a] -> Bool
isPalindrome' xs
    | xs == reverse xs = True
    | otherwise = False


-- 6. Create a function that sorts lists of lists by length of inner list.
--    Consider "sortBy" in Data.List
lengthSort :: [[a]] -> [[a]]
lengthSort xs = sortBy (compare `on` length) xs

-- Exercise 3.6
sortByLength xs = sortBy lengthGT xs
    where lengthGT (xs) (ys)
            | length xs > length ys = GT
            | length ys > length xs = LT

{- 7. Write a function intersperse' that operates like Python's join.
      intersperse :: a -> [[a]] -> [a]
      e.g.
        ghci> intersperse ',' []
        ""
        ghci> intersperse ',' ["foo"]
        "foo"
        ghci> intersperse ',' ["foo","bar","baz","quux"]
        "foo,bar,baz,quux"
-}
intersperse :: a -> [[a]] -> [a]
intersperse _ []     = []
intersperse y (x:[]) = x
intersperse y (x:xs) = x ++ [y] ++ intersperse y xs

-- 8. a) Using the binary tree type that we defined earlier in this chapter, write
-- a function that will determine the height of the tree. The height is the
-- largest number of hops from the root to an Empty. For example, the tree
-- Empty has height zero; Node "x" Empty Empty has height one; Node "x" Empty
-- (Node "y" Empty Empty) has height two; and so on.

data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)

testTree = Node "parent" (Node "left child" Empty Empty)
                           (Node "right child" Empty Empty)

treeDepth :: Tree a -> Int
treeDepth Empty          = 0
treeDepth (Node _ c1 c2) = 1 + max (treeDepth c1) (treeDepth c2)

-- 8. b) Define Tree using Maybe and repeat 8.a.

data Tree' a = Node' a (Maybe (Tree' a)) (Maybe (Tree' a))
             deriving (Show)

testTree'1 = Node' "top" Nothing Nothing
testTree'2 = Node' "top" (Just (Node' "mid" Nothing Nothing)) Nothing

treeDepth' :: Tree' a -> Int
treeDepth' (Node' _ c1 c2) = 1 + max (maybeDepth c1) (maybeDepth c2)
    where maybeDepth x = case x of
            Just value -> treeDepth' value
            Nothing -> 0


-- 9. Consider three two-dimensional points a, b, and c. If we look at the
--    angle formed by the line segment from a to b and the line segment from b to
--    c, it either turns left, turns right, or forms a straight line. Define a
--    Direction data type that lets you represent these possibilities.

data Direction = Left | Right | Straight
                 deriving (Show)

-- 10. Write a function that calculates the angle made by three 2D points and
--     returns a direction

data Point2D = Point2D Float Float

a = Point2D 0 0
b = Point2D 5 5
c = Point2D 9 9

findTurn :: Point2D -> Point2D -> Point2D -> Direction
findTurn a b c = compareAngles (findAngle a b) (findAngle b c)

compareAngles :: Float -> Float -> Direction
compareAngles angle1 angle2
    | angle1 < angle2 = Main.Left
    | angle1 == angle2 = Straight
    | angle1 > angle2 = Main.Right

findAngle :: Point2D -> Point2D -> Float
findAngle (Point2D x1 y1) (Point2D x2 y2) = atan2 (y2 - y1) (x2 - x1)

