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
          myFunction = fixLines

-- | Split a string on any (system independant) newlines, i.e. \r or \r\n
splitLines :: String -> [String]
splitLines [] = []
splitLines cs =
    let (pre, suf) = break isLineTerminator cs
    in pre : case suf of
               ('\r':'\n':rest) -> splitLines rest
               ('\r':rest)      -> splitLines rest
               ('\n':rest)      -> splitLines rest
               _                -> []

isLineTerminator c = c == '\r' || c == '\n'

-- | This function splits input using your improved splitLines, then
-- re-attaches them into the original format.
fixLines :: String -> String
fixLines input = unlines (splitLines input)

