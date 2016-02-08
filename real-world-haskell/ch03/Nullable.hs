-- file: ch03/Nullable.hs

someBool = Just True

someString = Just "something"

{-

> :type Just "something"
Just "something" :: Maybe [Char]

-- Maybe is a polymorphic, or generic, type.
We give the Maybe type constructor a parameter to create a specific type,
such as Maybe Int or Maybe [Bool].

We can nest the use of parameterised types inside each other...
-}

wrapped = Just (Just "wrapped")

-- I have no idea what that means.

