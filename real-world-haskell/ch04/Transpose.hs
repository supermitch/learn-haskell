-- 4. Write a program that transposes the text in a file. For instance, it
-- should convert "hello\nworld\n" to "hw\neo\nlr\nll\nod\n".

import System.Environment (getArgs)

interactWith function inputFile outputFile = do
    input <- readFile inputFile
    writeFile outputFile (function input)

main = mainWith myFunction
    where mainWith function = do
            args <- getArgs
            case args of
              [input, output] -> interactWith function input output
              _ -> putStrLn "error: exactly two arguments needed"

          -- replace "id" with the name of our function, below
          myFunction = transposeFile

s1 = "hello\nworld\n" -- "hw\neo\nlr\nll\nod\n"

transposeFile :: String -> String
transposeFile [] = []
transposeFile xs = lines xs


