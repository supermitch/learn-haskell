-- file: ch04/FixLines.hs

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
          myFunction = firstWords

s1 = "This is\nThe second line\nof the file."

firstWords :: String -> String
firstWords [] = []
firstWords xs = unlines [head $ words x | x <- lines xs]

