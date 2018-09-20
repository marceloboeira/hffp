-- If you apply your function -- to this value:
-- "Hello World"
-- Your function should return: "ello World"
dropFirst = drop 1

-- Given
-- "Curry is awesome"
-- Return
-- "Curry is awesome!"
enphasize = flip (++) "!"

-- Given
-- "Curry is awesome!"
-- Return
-- "y"
fourthLetter = flip (!!) 4

-- Given
-- "Curry is awesome"
-- Return
-- "awesome!"
drop9Letters = drop 9

-- Given
-- "Curry"
-- Return
-- 'r'
thirdLetter :: String -> Char
thirdLetter = flip (!!) 3

-- 4
-- Given
-- 1
-- Return
-- 'u'
letterIndex :: Int -> Char
letterIndex = (!!) "Curry is awesome!"
