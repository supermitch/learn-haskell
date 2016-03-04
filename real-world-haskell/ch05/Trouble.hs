-- file: ch05/Trouble.hs
import Data.Char (toUpper)

-- Type inference can cause problems:
upcaseFirst (c:cs) = toUpper c -- forgot :cs here!

camelCase :: String -> String
camelCase xs = concat (map upcaseFirst (words xs))  -- This fails. Type error.
