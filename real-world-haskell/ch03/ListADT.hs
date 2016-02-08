-- file ch03/ListADT.hs

-- List is recursive. Let's create our own list type:
-- We use cons instead of : and Nil instead of []

data List a = Cons a (List a)
            | Nil
              deriving (Show)

-- Is this an acceptable list?
-- we can prove it:

fromList (x:xs) = Cons x (fromList xs)
fromList []     = Nil

