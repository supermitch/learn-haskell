-- file: ch05/Main.hs

module Main (main) where -- exports nothing

import SimpleJson

main = print (JObject [("foo", JNumber 1), ("bar", JBool False)])
