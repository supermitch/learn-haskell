#!/usr/bin/env runhaskell
import System.Environment
import System.Random
import System.Exit


main = do
    putStrLn "Generating CSV file..."
    args <- getArgs
    let file = head args
    let n = read $ last args :: Int
    putStrLn $ "Writing <" ++ (head args) ++ "> lines to file <" ++ (last args) ++ ">"

    g <- getStdGen  -- get a random number generator
    print $ take n (randomRs (1::Int, 1000) g)
