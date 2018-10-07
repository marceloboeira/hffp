module Arith4 where

roundTrip :: (Show a, Read a) => a -> a
roundTrip a = read (show a)

-- 5
roundTrip' :: (Show a, Read a) => a -> a
roundTrip' = read . show

-- 6
roundTrip'' :: (Show a, Read b) => a -> b
roundTrip'' = read . show

main = do
  print (roundTrip'' 4 :: Integer)
  print (id 4)
