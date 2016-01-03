myDrop n xs = if n <= 0 || null xs
              then xs
              else MyDrop (n - 1) (tail xs)

-- Could be re-written in single line form, though it's ugly:

myDropX' n xs = if n <= 0 || null xs then xs else myDropX (n - 1) (tail xs)
