{-# LANGUAGE NoMonomorphismRestriction #-}

module DetermineTheType where

-- simple example
example = 1

-- 1
example_a = (* 9) 6
example_b = head [(0,"doge"),(1,"kitteh")]
example_c = head [(0 :: Integer ,"doge"),(1,"kitteh")]
example_d = if False then True else False
example_e = length [1, 2, 3, 4, 5]
example_f = (length [1, 2, 3, 4]) > (length "TACOCAT")

-- 2
x = 5
y = x + 5
w = y * 10

-- 3
f = 4 / y

-- 4
m = "Julie"
n = " <3 "
o = "Haskell"
p = m ++ n ++ o
