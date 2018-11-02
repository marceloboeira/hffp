-- 1
lefts' :: [Either a b] -> [a]
lefts' = foldr l []
  where
    l (Left x)  xs = x:xs
    l (Right _) xs = xs

-- 2
rights' :: [Either a b] -> [b]
rights' = foldr r []
  where
    r (Right x) xs = x:xs
    r (Left  _) xs = xs

-- 3
partitionEithers' :: [Either a b] -> ([a], [b])
partitionEithers' x = (lefts' x, rights' x)

-- 4
eitherMaybe' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe' f (Right b) = Just (f b)
eitherMaybe' _ (Left  a) = Nothing

-- 5
either' :: (a -> c) -> (b -> c) -> Either a b -> c
either' fl _ (Left  a) = fl a
either' _ fr (Right b) = fr b

-- 6
eitherMaybe'' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe'' f e = either' (const Nothing) (Just . f) e
