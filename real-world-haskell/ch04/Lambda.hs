-- file: ch04/Lambda.hs

safeHead (x:_) = Just x
safeHead _     = Nothing

-- That function is safe for empty lists.

-- Can re-write as an ugly lambda, but all patterns must match:
unsafeHead = \(x:_) -> x
-- ghci> unsafeHead [] => *** Exception: Non-exhaustive patterns...
