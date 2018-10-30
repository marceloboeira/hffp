module Cipher where

import Data.Char

-- Supported Alphabet from 'a' to 'z'
enc :: Char -> Int
enc = (+ (-ord 'a')) . ord

dec :: Int -> Char
dec = chr . (+ ord 'a')

shiftChar :: Int -> Char -> Char
shiftChar n c = dec (mod (enc c + n) 26)

--charDiff :: Char -> Char -> Char
--charDiff a b = (enc a) - (enc b)

vigenere :: String -> String -> String
vigenere key = zipWith (\x y -> shiftChar (enc x) y)  (concat $ repeat key)

unvigenere :: String -> String -> String
unvigenere key = zipWith (\x y -> shiftChar (-(enc x)) y)  (concat $ repeat key)
