-- Lookup
-- 1.
pure 1 :: [ Int ]
pure "foobar" ::  [String]

-- 2.
(<$>) (+10) [10, 20, 30]
(<$>) (++"!") ["hello", "you"]

-- 3.
(<*>) (Just (++"!")) (Just "hello")
(<*>) (Just (+3)) (Just 2)

-- Make the following expressions typecheck
-- 1.
added :: Maybe Integer
added = (+3) <$> (lookup 3 $ zip [1, 2, 3] [4, 5, 6])
-------- | function not wraped on any data structure
------------- | use fmap or <$>

added' :: Maybe Integer
added' = (pure (+3)) <*> (lookup 3 $ zip [1, 2, 3] [4, 5, 6])
-------- | function is now wraped with pure (Applicative f) => a -> f a
------------- | use ap or <*>

added'' :: Maybe Integer
added'' = (Just (+3)) <*> (lookup 3 $ zip [1, 2, 3] [4, 5, 6])
-------- | function is now wraped on any data structure
------------- | use fmap or <$>

-- 2.
y :: Maybe Integer
y = lookup 3 $ zip [1, 2, 3] [4, 5, 6]

z :: Maybe Integer
z = lookup 2 $ zip [1, 2, 3] [4, 5, 6]

tupled :: Maybe (Integer, Integer)
tupled = (pure (,)) <*> y <*> z

-- 3.
import Data.List (elemIndex)

x2 :: Maybe Int
x2 = elemIndex 3 [1, 2, 3, 4, 5]

y2 :: Maybe Int
y2 = elemIndex 4 [1, 2, 3, 4, 5]

max' :: Int -> Int -> Int
max' = max

maxed :: Maybe Int
maxed = (pure max') <*> x2 <*> y2

-- 4.
xs = [1, 2, 3]
ys = [4, 5, 6]

x3 :: Maybe Int
x3 = lookup 3 $ zip xs ys

y3 :: Maybe Int
y3 = lookup 2 $ zip xs ys

summed :: Maybe Int
summed = (pure sum) <*> ((,) <$> x3 <*> y3)

summed' :: Maybe Int
summed' = sum <$> ((,) <$> x3 <*> y3)
