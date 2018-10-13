myWords :: String -> [String]
myWords x
  | x == "" = []
  | otherwise = [takeWhile (/= ' ') x] ++ (myWords . dropWhile (== ' ') . dropWhile (/= ' ') $ x)
