import Text.ParserCombinators.Parsec

-- Each file contains many lines
csvFile :: GenParser Char st [[String]]
csvFile =
    do result <- many line
       eof
       return result

-- Each line contains 1 or more cells
line :: GenParser Char st [String]
line =
    do result <- cells
       eol
       return result

cells :: GenParser Char st [String]
cells =
    do first <- cellContent
       next <- remainingCells
       return (first : next)

remainingCells :: GenParser Char st [String]
remainingCells =
    (char ',' >> cells)  -- Found comma? More cells coming
    <|> (return [])      -- No comma? Return [], no more cells

-- Each cell contains 0 or more characters
-- which must not be a comma or EOL
cellContent :: GenParser Char st String
cellContent =
    many (noneOf ",\n")

-- The end of line character is \n
eol :: GenParser Char st Char
eol = char '\n'

parseCSV :: String -> Either ParseError [[String]]
parseCSV input = parse csvFile "(unknown)" input


