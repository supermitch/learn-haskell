-- file: ch04/EfficientList.hs

myDumbExample xs = if length xs > 0
                      then head xs
                      else 'Z'

-- no good, because length needs to traverse the entire list

-- Better:

mySmartExample xs = if not (null xs)
                    then head xs
                    else 'Z'

-- Or let pattern matching to the work:

myOtherExample (x:_) = x
myOtherExample [] = 'Z'

