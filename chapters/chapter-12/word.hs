newtype Word' = Word' String deriving (Eq, Show)

vowels = "aeiou"

mkWord :: String -> Maybe Word'
mkWord xs
  | vowelsCount > consonantsCount = Nothing
  | otherwise = Just (Word' xs)
  where
    vowelsCount = length $ filter (isVowel) xs
    consonantsCount = (length xs) - vowelsCount
    isVowel = (flip elem) vowels
