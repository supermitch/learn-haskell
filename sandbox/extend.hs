-- Join two lists into one, without using ++, like Python's extend()
-- e.g. extend [1, 2] [5, 6] = [1, 2, 5, 6]

extend :: [a] -> [a] -> [a]
extend [] ys = ys
extend (x:xs) ys = x : (join xs ys)

x = [1..4]
y = [5..8]

z = x `extend` y
