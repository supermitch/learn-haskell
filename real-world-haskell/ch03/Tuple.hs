-- file: ch03/Tuple.hs

-- There's no limit to how "deep" a pattern can look inside a value
complicated (True, a, x:xs, 5) = (a, xs)

