eftBool :: Bool -> Bool -> [Bool]
eftBool from to
  | from == to = [to]
  | otherwise = [from] ++ eftBool (not from) to

eftOrd :: Ordering -> Ordering -> [Ordering]
eftOrd from to
  | from == to = [to]
  | otherwise = [from] ++ eftOrd (succ from) to

eftInt :: Int -> Int -> [Int]
eftInt from to
  | from > to = []
  | from == to = [to]
  | otherwise = [from] ++ eftInt (succ from) to

eftChar :: Char -> Char -> [Char]
eftChar from to
  | from > to = []
  | from == to = [to]
  | otherwise = [from] ++ eftChar (succ from) to
