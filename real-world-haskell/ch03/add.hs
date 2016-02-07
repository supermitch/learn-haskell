-- file: ch03/add.hs

myNot True = False
myNot False = True

-- We've defined a function as a series of equations.

-- Another example:
sumList (x:xs) = x + sumList xs
sumList []     = 0

