-- Recursion Section
--
dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = go num denom 0
  where go n d count
         | n < d = (count, n)
         | otherwise = go (n - d) d (count + 1)

--- Exercise 1
  -- num    d c
  -- 15     2 0
  -- (15-2) 2 1
  -- (13-2) 2 2
  -- (11-2) 2 3
  -- (09-2) 2 4
  -- (07-2) 2 5
  -- (05-2) 2 6
  -- (03-2) 2 7
  -- (01-2) 2 7 returns (7, 1)
---

-- Exercise 2
sumIncrease :: (Eq a, Num a) => a -> a
sumIncrease x = go x 1 0
  where go to step result
         | step == (to + 1) = result
         | otherwise = go to (step + 1) (result + step)

-- Tests
-- (sumIncrease 5) == 15
--
-- Exercise 3
multWithSum :: (Integral a) => a -> a -> a
multWithSum x y = go 0 y x
  where go result by inc
         | inc == 0 = result
         | otherwise = go (result + by) by (inc - 1)

-- Tests
-- (multWithSum 10 3) == 30

-- Fixing divideBy
data DividedResult = Result Integer | DividedByZero deriving (Show, Eq)

dividedBy' :: Integral a => a -> a -> DividedResult
dividedBy' num denom = go (abs num) (abs denom) 0 (sg num denom)
  where
    sg x y = signum x /= signum y
    inv b x = if b then (-x) else x
    go n d c p
         | d == 0 = DividedByZero
         | n < d = Result(toInteger $ inv p c)
         | otherwise = go (n - d) d (c + 1) p

-- Tests
-- (dividedBy' 10 2) == Result 5
-- (dividedBy' 10 0) == DividedByZero
-- (dividedBy' (-10) (-1)) == Result(10)
-- (dividedBy' 10 (-1)) == Result((-10))
-- (dividedBy' (-10) 1) == Result((-10))
