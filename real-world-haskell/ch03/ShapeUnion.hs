-- file: ch03/ShapeUnion.hs

type Vector = (Double, Double)

data Shape = Circle Vector Double
           | Poly [Vector]


-- If a Shape is built using the Circle value constructor, that fact is saved.
-- We don't need to do extra work to determine the "kind" of shape.
