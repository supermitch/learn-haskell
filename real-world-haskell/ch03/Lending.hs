-- file: ch03/Lending.hs

lend amount balance = let reserve    = 100
                          newBalance = balance - amount
                      in if balance < reserve
                        then Nothing
                        else Just newBalance

-- Let starts a block of variable definition, and 'in' ends it.
-- These variables, e.g. `reserve` are called "let-bound variables".

-- We can also define local vars via the 'where' clause
-- where clauses apply to the code that *precedes* it.

lend2 amount balance = if amount < reserve * 0.5
                          then Just newBalance
                          else Nothing
                       where reserve = 100
                             newBalance = balance - amount
