#!/usr/bin/env runhaskell
import System.Environment
import System.Random
import qualified Data.UUID.V5 as U5


stringify :: [(Int, Int)] -> [Char]
stringify []     = ""
stringify (x:xs) = (show $ fst x) ++ "," ++ (show $ snd x) ++ "\n" ++ (stringify xs)

main = do
    putStrLn "Generating CSV file..."
    args <- getArgs
    let fileName = head args
    let n = read $ last args :: Int
    putStrLn $ "Writing <" ++ (show n) ++ "> lines to file <" ++ (show fileName) ++ ">"

    g <- getStdGen  -- get a random number generator
    let rands = take n (randomRs (1::Int, 1000) g)

    writeFile fileName "id,guid\n" -- write headers
    appendFile fileName $ stringify $ zip [1..] rands

    print $ U5.generateNamed

