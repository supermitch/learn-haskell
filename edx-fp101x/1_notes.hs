doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y 

doubleSmallNumber x = if x > 100
                        then x
                        else x * 2

removeNoneUppercase :: String -> String
removeNoneUppercase string = [ c | c <- string, elem c ['A'..'Z']]

lucky :: (Integral a) => a -> String
lucky 7 = "Lucky number seven!"
lucky x = "Sorry, you're out of luck, pal."

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)
