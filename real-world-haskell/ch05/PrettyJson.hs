-- file: ch05/PrettyJson.hs

renderJValue :: JValue -> Doc
renderJValue (JString s) = string str
renderJValue (JNumber n) = double num
renderJValue (JBool True) = text "true"
renderJValue (JBool False) = text "false"
renderJValue (JNull) = text "null"

{-
renderJValue (JObject o) = "{" ++ pairs 0 ++ "}"
    where pairs [] = ""
          pairs ps = intercalate ", " (map renderPair ps)
          renderPair (k, v) = show k ++ ": " ++ renderJValue v
renderJValue (JArray a) = "[" ++ values a ++ "]"
    where values [] = ""
          values vs = intercalate ", " (map renderJValue vs)
-}
