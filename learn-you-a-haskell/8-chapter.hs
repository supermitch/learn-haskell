-- 8. Making our own Types & Typeclasses

-- 1. Into to algebraic data types --
-------------------------------------

data Bool = False | True  -- 'data' defines a new type
                          -- False | True are 'value constructors'
                          -- '|' can be read as 'or'

-- How might we define a shape in a data type?

data Shape = Circle Float Float Float | Rectangle Float Float Float Float

-- In this case, a circle has 3 params (x, y, r)

> data Shape = Circle Float Float Float | Rectangle Float Float Float Float
> :t Circle
Circle :: Float -> Float -> Float -> Shape

-- The floats are parameters to the value constructors, which are functions
-- that return a value of a data type.

-- Let's make a function that takes a shape and returns it's surface

surface :: Shape -> Float
surface (Circle _ _ r) = pi * r ^ 2
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)

-- Note that *Circle* is NOT a type. Shape is!
-- Just like you can't write a function with type :: True -> Int,
-- You don't write a function of type Circle -> Float

> surface $ Circle 10 20 10
314.15927

-- That will work
-- But we can't just print > Circle 10 20 10
-- because we haven't implemented show.

data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)

-- adding deriving (Show) means our Type is now part of the Show typeclass.
-- This now works:

> Circle 10 20 5
Circle 10.0 20.0 5.0

-- *Value constructors are functions*, so we can map them, etc.

> map (Circle 10 20) [4,5,6,6]
[Circle 10.0 20.0 4.0,Circle 10.0 20.0 5.0,Circle 10.0 20.0 6.0,Circle 10.0 20.0 6.0]

-- Let's use an intermediate data type called Point
data Point = Point Float Float deriving (Show)
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

-- Our surface function needs to change now:

surface :: Shape -> Float
surface (Circle _ r) = pi * r ^ 2  -- Only one missing param in constructor
surface (Rectangle (Point x1 y1) (Point x2 y2)) = ... -- used nested pattern matching

-- and we build our objects differently:

surface (Circle (Point 0 0) 24)


-- You can export your data types in your modules. You can also export
-- the value constructors for that type, using (..), or specify them directly

module Shapes
( Point(..)
, Shape(Rectangle, Circle)
, surface
, nudge
, baseCircle
, baseRect
) where ...


-- 2. Record Syntax --
----------------------

-- We want to create a Data Type for a person

data Person = Person String String Int Float String String deriving (Show)

> let guy = Person "Buddy" "Finkle" 43 184.2 "459-7707" "Chocolate"

-- Cool but useless. If you wanted to get a single field you would have
-- to do:

firstName :: Person -> String
firstName (Person name _ _ _ _ _) = name

-- And so on for all other attributes, which is dumb
-- Alternatively you can use record syntax

data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     , flavour :: String
                     } deriving (Show)

-- Haskell now automatically created our equivalent "getters"

> :t flavour
flavour :: Person -> String

-- If you define and use record syntax to instantiate, show looks better:


data Car = Car {company :: String, model :: String, year :: Int} deriving (Show)

-- Instantiate using record syntax too
> let truck = Car {company="Ford", model="Mustang", year=1967}
Car {company = "Ford", model = "Mustang", year = 1967} -- displayed nicely

-- no need to order fields in the Value Constructor call.

-- 3. Type Parameters --
------------------------

-- A Value constructor takes some value parameters and then produces a new value.
-- Similarly, a "Type Constructor" takes type parameters and produces a new type.

data Maybe a = Nothing | Just a

-- 'a' here is the "type parameter". 'Maybe' is a "type constructor".

-- You can't have a value of type 'Maybe' because it's not a type; it's a type
-- constructor.

-- But if we pass Int to Just a, we get a Maybe Int.

> Just "haha"
Just "haha"
> Just 64
Just 64
> :t Just "haha"
Just "haha" :: Maybe [Char]
> :t Just 84
Just 84 :: (Num t) => Maybe t
> :t Nothing
Nothing :: Maybe a
> Just 12 :: Maybe Double
Just 10.0

-- Note that Nothing is polymorphic! It can be Maybe Int if a function
-- needed it to be, etc.

-- An empty list [] is also polymorphic:

>[1, 2, 3] ++ []
[1, 2, 3]
>["ha", "ha"] ++ []
["ha", "ha"]

-- If your type acts as a kind of "container" then it makes sense.
-- You could define a Car this way but it makes no sense:

data Car a b c = Car { company :: a
                     , model :: b
                     , year :: c
                     } deriving (Show)

-- Here's an example of parameterized type in Vector type.

data Vector a = Vector a a a deriving (Show)

vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i + l) (j + m) (k + n)

-- and so on:

scalarMult :: (Num t) => Vector t -> Vector t -> t
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n

-- Note that there's no value in putting the Num constraint in the type declaration
-- (though you can) because we have to repeat it in our functions anyway.

-- Examples of usage:

> Vector 3 5 8 `vplus` Vector 9 2 8
Vector 12 7 16
> Vector 4 9 5 `scalarMult` Vector 9.0 2.0 4.0
74.0  -- Double!


-- 4. Derived Instances (of a Type Class) --
--------------------------------------------

-- Haskell can automatically make our data type on of several typeclasses:
-- Eq, Ord, Enum, Bounded, Show, and Read.

-- You use the 'deriving' keyword when making our data type. For example:

data Person = Person { firstName :: String
                     , lastName :: String
                     , age :: Int
                     } deriving (Eq)

-- Now two people can be tested for equality.

> let adRock = Person {firstName = "Adam", lastName = "Horovitz", age = 41}
> let mca = Person {firstName = "Adam", lastName = "Yauch", age = 44}
> mca == adRock
False
> mca == mca
True

-- Since person is now of Eq, we can use it for the arg to all functions that
-- have a class constraint of Eq a in type signature.

> let beastieBoys = [mca, adRock, mikeD]
> mikeD `elem` beastieBoys
True

-- Show and read are for converting to and from Strings.
