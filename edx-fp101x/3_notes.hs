-- Conditional format
abs :: Int -> Int
abs n = n if n >= 0 else -n

signum  :: Int -> Int
signum n = if n < 0 then -1 else
              if n == 0 then 0 else 1

-- Guarded function
abs n | n >= 0 = n
      | otherwise = -n

signum n | n < 0     = -1
         | n == 0    = 0
         | otherwise = 1

-- Pattern Matching
not :: Bool -> Bool
not False = True
not True = False

(&&) :: Bool -> Bool -> Bool
True && True = True
_    && _    = False

-- or, better:
True && b = b
False && _ = False

-- Patterns match from top to bottom:
_ && _ = False
True && True = True
-- will always return False

-- Patterns cannot repeat variables:
b && b = b
-- returns an error

-- Lambda expressions:
-- \x -> x + x

odds n = map (\x -> x*2 + 1) [0..n-1]

-- Sections

-- 1+2
-- 3
-- (+) 1 2
-- 3
-- (1+) 3
-- 3
-- (+2) 1
-- 3
-- code in parens are called 'sections'
