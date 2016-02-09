-- file: ch03/BadTree.hs

bad_nodesAreSame (Node a _ _) (Node a _ _) = Just a
bad_nodesAreSame _            _            = Nothing

-- The issue here is that a name can only appear once in a set of pattern bindings.
-- So `a` and `a` can't be used twice.

-- You'll get an error "conflicting definitions for `a`".

-- Here we can solve this issue using guards:

nodesAreSame (Node a _ _) (Node b _ _)
    | a == b     = Just a
nodesAreSame _ _ = Nothing

-- Guards are expressions of type Bool.
