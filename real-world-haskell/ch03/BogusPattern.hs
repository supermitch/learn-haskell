-- file: ch03/BogusPattern.hs

-- Here are some common pattern mistakes:

data Fruit = Apple | Orange

apple = "apple"
orange = "orange"

whichFruit :: String -> Fruit
whichFruit f = case f of
                apple -> Apple
                orange -> Orange

-- apple, in this case, doesn't refer to the top-level variable `apple`!
-- Easier to see here:

whichFruit2 :: String -> Fruit
whichFruit2 apple -> Apple
whichFruit2 orange -> Orange

-- The correct version is here:

betterFruit f = case f of
                  "apple" -> Apple
                  "orange" -> Orange

