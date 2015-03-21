module Lab2 where

------------------------------------------------------------------------------------------------------------------------------
-- Lab 2: Validating Credit Card Numbers
------------------------------------------------------------------------------------------------------------------------------

-- ===================================
-- Ex. 0
-- ===================================
{-
First we need to find the digits of a number. Define a function

toDigits :: Integer -> [Integer]

that takes a n :: Integer where n >= 0 and returns a list of the digits of n.
More precisely, toDigits should satisfy the following properties,
for all n :: Integer  where n >= 0:

* eval (toDigits n) == n
* all (\d -> d >= 0 && d < 10) (toDigits n)
* length (show n) == length (toDigits n)

where eval is defined as follows:

    eval xs = foldl (\x y -> y + (10 * x)) 0 xs

Note: toDigits n should error when n < 0.
-}
eval xs = foldl (\x y -> y + (10 * x)) 0 xs

toDigits :: Integer -> [Integer]
toDigits n
    | n < 10 = [n]
    | n >= 10 = toDigits(new_num) ++ [last_digit]
    where
        last_digit = n `mod` 10
        remainder = n - last_digit
        new_num
            | remainder < 10 = remainder
            | remainder >= 10 = remainder `div` 10

test0 = do
    -- Test exercise 1
    print("[9,8,7,6,5,4,3,2,1]", toDigits 987654321)
    print("[0]", toDigits 0)
    print("[1]", toDigits 1)
    print(eval (toDigits 19) == 19)
    print(all (\d -> d >= 0 && d < 10) (toDigits 1234))
    print(length (show 1234) == length (toDigits 1234))

-- ===================================
-- Ex. 1
-- ===================================
{-
Now we need to reverse the digits of a number. Define a function

toDigitsRev :: Integer -> [Integer]

that takes a n :: Integer  where n >= 0 and returns a list of the digits of n
in reverse order. More precisely, toDigitsRev should satisfy the following
properties, for all n :: Integer  where n >= 0::

n == evalRev (toDigitsRev n)
all (\d -> d >= 0 && d < 10) (toDigitsRev n)
length (toDigitsRev n) == length (show n)
where evalRev is defined as follows:

evalRev xs = foldr (\x y -> x + (10 * y)) 0 xs

Note: toDigitsRev n should error when n < 0.
-}
evalRev xs = foldr (\x y -> x + (10 * y)) 0 xs

toDigitsRev :: Integer -> [Integer]
toDigitsRev n = reverse (toDigits n)

test1 = do
    -- Test exercise 1
    print("[1,2,3,4,5,6,7,8,9]", toDigitsRev 987654321)
    print("[0]", toDigitsRev 0)
    print("[3,2,1]", toDigitsRev 123)
    print(19 == evalRev (toDigitsRev 19))
    print(all (\d -> d >= 0 && d < 10) (toDigitsRev 1234))
    print(length (toDigitsRev 1234) == length (show 1234))

-- ===================================
-- Ex. 2
-- ===================================
{-
Once we have the digits in the proper order, we need to double every
other one.

Define the function

doubleSecond :: [Integer] -> [Integer]

that doubles every second number in the input list.

Example:  The result of doubleSecond [8, 7, 6, 5] is [8, 14, 6, 10].
-}
doubleSecond :: [Integer] -> [Integer]
--  doubleSecond [] = []
--  doubleSecond (xs)
--      | (length xs) `mod` 2 == 0 = doubleSecond (init xs) ++ [last xs * 2]
--      | otherwise = doubleSecond (init xs) ++ [last xs]
-- Or this is much better:
doubleSecond (xs) = [x * (mod i 2 + 1) | (x, i) <- zip xs [0..]]

test2 = do
    print("8,14,6,10", doubleSecond [8,7,6,5])
    print("1,4,3", doubleSecond [1,2,3])
    print("1", doubleSecond [1])
    print("0", doubleSecond [0])
    print("1,4", doubleSecond [1,2])
    print("1,2,1,2,1,2,1,2", doubleSecond [1,1,1,1,1,1,1,1])

-- ===================================
-- Ex. 3
-- ===================================
{-
The output of doubleSecond has a mix of one-digit and two-digit numbers.
Define a function

sumDigits :: [Integer] -> Integer

to calculate the sum of all individual digits, even if a number in the list
has more than 2 digits.

Example:  The result of

sumDigits [8,14,6,10] = 8 + (1 + 4) + 6 + (1 + 0) = 20.

sumDigits [3, 9, 4, 15, 8] = 3 + 9 + 4 + (1 + 5) + 8 = 30
-}

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs)
    | x >= 10 = sumDigits (toDigits x) + sumDigits xs
    | otherwise = x + sumDigits xs

test3 = do
    print("20", sumDigits [8,14,6,10])
    print("30", sumDigits [3,9,4,15,8])
    print("1", sumDigits [1])
    print("0", sumDigits [0])
    print("5", sumDigits [14])

-- ===================================
-- Ex. 4
-- ===================================
{-
Calculate the modulus of the sum divided by 10.  If the result equals 0, then
the number is valid. Here is an example of the results of each step on the
number 4012888888881881.
-}
isValid :: Integer -> Bool
isValid n = (sumDigits (doubleSecond (toDigitsRev n))) `mod` 10 == 0

test4 = do
    print(isValid 4012888888881881)
    print(isValid 4012888888881891)

-- ===================================
-- Ex. 5
-- ===================================

numValid :: [Integer] -> Integer
numValid xs = sum . map (\_ -> 1) $ filter isValid xs


creditcards :: [Integer]
creditcards = [ 4716347184862961,
                4532899082537349,
                4485429517622493,
                4320635998241421,
                4929778869082405,
                5256283618614517,
                5507514403575522,
                5191806267524120,
                5396452857080331,
                5567798501168013,
                6011798764103720,
                6011970953092861,
                6011486447384806,
                6011337752144550,
                6011442159205994,
                4916188093226163,
                4916699537435624,
                4024607115319476,
                4556945538735693,
                4532818294886666,
                5349308918130507,
                5156469512589415,
                5210896944802939,
                5442782486960998,
                5385907818416901,
                6011920409800508,
                6011978316213975,
                6011221666280064,
                6011285399268094,
                6011111757787451,
                4024007106747875,
                4916148692391990,
                4916918116659358,
                4024007109091313,
                4716815014741522,
                5370975221279675,
                5586822747605880,
                5446122675080587,
                5361718970369004,
                5543878863367027,
                6011996932510178,
                6011475323876084,
                6011358905586117,
                6011672107152563,
                6011660634944997,
                4532917110736356,
                4485548499291791,
                4532098581822262,
                4018626753711468,
                4454290525773941,
                5593710059099297,
                5275213041261476,
                5244162726358685,
                5583726743957726,
                5108718020905086,
                6011887079002610,
                6011119104045333,
                6011296087222376,
                6011183539053619,
                6011067418196187,
                4532462702719400,
                4420029044272063,
                4716494048062261,
                4916853817750471,
                4327554795485824,
                5138477489321723,
                5452898762612993,
                5246310677063212,
                5211257116158320,
                5230793016257272,
                6011265295282522,
                6011034443437754,
                6011582769987164,
                6011821695998586,
                6011420220198992,
                4716625186530516,
                4485290399115271,
                4556449305907296,
                4532036228186543,
                4916950537496300,
                5188481717181072,
                5535021441100707,
                5331217916806887,
                5212754109160056,
                5580039541241472,
                6011450326200252,
                6011141461689343,
                6011886911067144,
                6011835735645726,
                6011063209139742,
                379517444387209,
                377250784667541,
                347171902952673,
                379852678889749,
                345449316207827,
                349968440887576,
                347727987370269,
                370147776002793,
                374465794689268,
                340860752032008,
                349569393937707,
                379610201376008,
                346590844560212,
                376638943222680,
                378753384029375,
                348159548355291,
                345714137642682,
                347556554119626,
                370919740116903,
                375059255910682,
                373129538038460,
                346734548488728,
                370697814213115,
                377968192654740,
                379127496780069,
                375213257576161,
                379055805946370,
                345835454524671,
                377851536227201,
                345763240913232
              ]

