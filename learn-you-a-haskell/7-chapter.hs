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


