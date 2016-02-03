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

-- Let's create a new type constructor
-- Note: BookReview is also the name of the value constructor
data BookReview = BookReview BookInfo Int String

-- let's define some type synonyms:
type CustomerId = Int
type ReviewBody = String

-- We can define a new, better Review:
data BetterReview = BetterReview BookInfo CustomerId ReviewBody

-- We can also use a type synonym for a verbose type:
type BookRecord = (BookInfo, BookReview)

-- An algebraic data type's Value Constructor can take zero or more arguments.
type CardHolder = String
type CardNumber = String
type Address = [String]

data BillingInfo = CreditCard CardNumber CardHolder Address
                 | CashOnDelivery
                 | Invoice CustomerId
                   deriving (Show)

-- Note that the three Value Constructors all take different args.
