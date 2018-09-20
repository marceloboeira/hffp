module Reverse where

--
-- Given
-- "Curry is awesome"
-- Return
-- "awesome is Curry"
rvrs :: String -> String
rvrs x =  y ++ " " ++ z ++ " " ++ w
  where y = drop 9 x
        z = take 2 $ drop 6 x
        w = take 5 x

main :: IO()
main = print $ rvrs "Curry is awesome"
