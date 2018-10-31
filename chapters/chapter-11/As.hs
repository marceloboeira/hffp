import Data.Char
import Data.List (words, intercalate)

-- As
-- example
doubleUp :: [a] -> [a]
doubleUp [] = []
doubleUp xs@(x:_) = x : xs

-- 1
isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf (x:xs) p@(y:ys) =
  case elem x p of
    True -> isSubsequenceOf xs ys
    False -> isSubsequenceOf (x:xs) ys

-- 2
capitalizeWords :: String -> [(String, String)]
capitalizeWords = map (\x -> (x, capitalizeWord x)) . words

-- Language Exercises
-- 1
capitalizeWord :: String -> String
capitalizeWord [] = []
capitalizeWord (x:xs) = (toUpper x) : xs

-- 2
capitalizeParagraph :: String -> String
capitalizeParagraph = (intercalate " ") . (map capitalizeWord) . words
