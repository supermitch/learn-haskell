-- file: ch03/Guard.hs

from Maybe defval wrapped =
    case wrapped of
      Nothing -> defval
      Just value -> value

-- of keyword signifies end of the case expression
-- all expressions must have the same type

{- Here's how we would use it:

> :m + Data.Maybe
> z = Nothing
> fromMaybe 2 z
2
> z = Just 5
> fromMaybe 2 z
5

-}

-- Another example of case:

data Fruit = Apple | Organge | UnknownFruit
             deriving (Eq, Show)

whichFruit :: String -> Fruit
whichFruit f = case f of
                 "apple" -> Apple
                 "organge" -> Orange
                 _ -> UnknownFruit

