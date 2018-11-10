import Control.Monad
import System.Exit (exitSuccess)
import Data.Char (toLower)
-- 2
palindrome :: IO ()
palindrome = forever $ do
  line1 <- getLine
  case (line1 == reverse line1) of
    True -> putStrLn "It's a palindrome!"
    False -> do
      putStrLn "Nope!"
      exitSuccess

-- 3
palindrome' :: IO ()
palindrome' = forever $ do
  l <- getLine
  case ((norm l) == reverse (norm l)) of
    True -> putStrLn "It's a palindrome!"
    False -> do
      putStrLn "Nope!"
      exitSuccess
    where norm s = filter (flip elem ['a'..'z']) $ map toLower s

