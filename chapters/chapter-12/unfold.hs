-- 1
myIterate :: (a -> a) -> a -> [a]
myIterate f a = a : myIterate f (f a)

-- 2
myUnfoldr :: (b -> Maybe (a, b)) -> b -> [a]
myUnfoldr f b =
  case (f b) of
    Nothing -> []
    Just (a, bb) -> a : myUnfoldr f bb

-- 3
betterIterate :: (a -> a) -> a -> [a]
betterIterate f x = myUnfoldr (\a -> Just (f a, f a)) x
