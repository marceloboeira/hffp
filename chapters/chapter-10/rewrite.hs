-- Example
myAnd :: [Bool] -> Bool
myAnd = foldr (&&) True

-- 1
myOr :: [Bool] -> Bool
myOr = foldr (||) False

-- 2
myAny :: (a -> Bool) -> [a] -> Bool
myAny f = foldr ((||) . f) False

-- 3
myElem :: Eq a => a -> [a] -> Bool
myElem e = foldr ((||) . (== e)) False
myElem' e = myAny (== e)

-- 4
myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []

-- 5
myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr ((:) . f) []

-- 6
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr (\x y -> if (f x) then x : y else y) []

-- 7
squish :: [[a]] -> [a]
squish = foldr (++) []

-- 8
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f = foldr (\x y -> (f x) ++ y) []

-- 9
squishAgain :: [[a]] -> [a]
squishAgain = squishMap id

-- 10
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [] = undefined
myMaximumBy f xs = foldr (\x y -> case (f x y) of LT -> y
                                                  EQ -> y
                                                  GT -> x) (head xs) xs

-- 11
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ [] = undefined
myMinimumBy f xs = foldr (\x y -> case (f x y) of LT -> x
                                                  EQ -> x
                                                  GT -> y) (head xs) xs
