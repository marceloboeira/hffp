explode :: Char -> String -> [String]
explode on str
  | str == "" = []
  | otherwise = [takeWhile (/= on) str] ++ (explode on . dropWhile (== on) . dropWhile (/= on) $ str)
