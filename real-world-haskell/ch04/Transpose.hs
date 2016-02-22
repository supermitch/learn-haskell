-- 4. Write a program that transposes the text in a file. For instance, it
-- should convert "hello\nworld\n" to "hw\neo\nlr\nll\nod\n".

import Test.HUnit

transposeFile :: String -> String
transposeFile [] = []
transposeFile xs = transposeLines $ lines xs

transposeLines :: [String] -> ??? FFffuu
transposeLines (x:xs) = undefined

-- | Join the first letter of two words
joinWords :: [String] -> String
joinWords [] = ""
joinWords (x:xs) = head x : joinWords xs

-- Tests

basicCase = TestCase (assertEqual "" "hw\nlr\nll\nod\n" (transposeFile "hello\nworld\n"))
tests = TestList [
    TestLabel "Basic case" basicCase
    ]

main = do
    runTestTT tests

