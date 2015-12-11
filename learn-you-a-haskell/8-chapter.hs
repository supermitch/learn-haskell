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
