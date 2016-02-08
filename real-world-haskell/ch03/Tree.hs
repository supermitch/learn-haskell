-- file: ch03/Tree.hs

-- Here's the defintion of a binary tree type:
data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)

-- We don't have null, for a tree with no children
-- Instead we use the no-argument Empty constructor.

simpleTree = Node "parent" (Node "left child" Empty Empty)
                           (Node "right child" Empty Empty)

