module Database where

import Data.Time

data DatabaseItem = DbString String | DbNumber Integer | DbDate UTCTime deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase = [
 DbDate (UTCTime (fromGregorian 1911 5 1) (secondsToDiffTime 34123)),
 DbNumber 9001,
 DbNumber 999,
 DbString "Hello, world!",
 DbDate (UTCTime (fromGregorian 1921 5 1) (secondsToDiffTime 34123)),
 DbDate (UTCTime (fromGregorian 2018 4 8) (secondsToDiffTime 0)) ]

-- 1. Write a function that filters for DbDate values and returns a list of the UTCTime values inside them.
filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate =  foldr fs []
  where fs x y = case x of (DbDate t) -> t : y
                           _ -> y

-- 2. Write a function that filters for DbNumber values and returns a list of the Integer values inside them.
filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber =  foldr fs []
  where fs x y = case x of (DbNumber n) -> n : y
                           _ -> y

-- 3. Write a function that gets the most recent date.
mostRecent :: [DatabaseItem] -> UTCTime
mostRecent = (foldr myMax defaultTime) . filterDbDate
  where defaultTime = UTCTime (fromGregorian 0 0 0) (secondsToDiffTime 0)
        myMax x y
          | x > y = x
          | otherwise = y

-- 4. Write a function that sums all of the DbNumber values.
sumDb :: [DatabaseItem] -> Integer
sumDb = (foldr (+) 0) . filterDbNumber

-- 5. Write a function that gets the average of the DbNumber values.
avgDb :: [DatabaseItem] -> Double
avgDb db = (fromInteger (sumDb db)) / (fromIntegral (length (filterDbNumber db)))
