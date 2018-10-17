module Cipher where

import Data.Char

-- Supported Alphabet from 'a' to 'z'
enc :: Char -> Int
enc = (+ (-ord 'a')) . ord

dec :: Int -> Char
dec = chr . (+ ord 'a')

shiftChar :: Int -> Char -> Char
shiftChar n c = dec (mod (enc c + n) 26)

caesar :: Int -> String -> String
caesar n = map (shiftChar n)

uncaesar :: Int -> String -> String
uncaesar n = caesar (-n)
