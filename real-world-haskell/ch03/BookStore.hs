-- file: ch03/BookStore.hs
data BookInfo = Book Int String [String]
                deriving (Show)

-- BookInfo is the name of our new type
-- BookInfo is a "type constructor", and must start with a capital letter.

-- Book is the "value constructor" (or "data constructor"). Also
-- starts with a capital letter.

-- Int String [String] are the components of that type.

data MagazineInfo = Magazine Int String [String]
                    deriving (Show)

myInfo = Book 3459083534 "Algebra of Programming" ["Richard Bird", "Oege De Moor"]
