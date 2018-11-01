import Data.List

notThe :: String -> Maybe String
notThe "the" = Nothing
notThe x = Just x

-- 1
-- "the cow loves us"
-- "a cow loves us"
replaceThe :: String -> String
replaceThe = (intercalate " ") . (map theToA) . words
  where theToA x = case notThe x of Nothing -> "a"
                                    Just x -> x
-- 2
isVowel :: Char -> Bool
isVowel = (flip elem) "aeiouAEIOU"

countTheBeforeVowel :: String -> Int
countTheBeforeVowel = (go 0) . words
  where
    go c (x1:x2:xs)
      | (x1 == "the" && isVowel (head x2)) = go (c+1) (x2:xs)
      | otherwise = go c (x2:xs)
    go _ _ = 0

-- 3
countVowels :: String -> Int
countVowels = length . (filter (isVowel))
