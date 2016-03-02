-- file: ch04/Partial.hs

-- We've frequently written 'helper' functions before:
isInAny needle haystack = any inSequence haystack
    where inSequence s = needle `isInfixOf` s

-- But we can re-write these using lambda functions:
isInAny2 needle haystack = any (\s -> needle `isInfix` s) haystack

-- We can use partial functions rather than a named function or a lambda:
isInAny3 needle haystack = any (isInfixOf needle) haystack
-- the (isInfixOf needle) is a partially applied (curried) function

-- We can use sections to improve the readability of this even further:
isInAny4 needle haystack = any (needle `isInfixOf`) haystack

