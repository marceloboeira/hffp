# Chapter 7

## Grab Bag

### Equivalents

1. Which two or more are equivalent?
* a) `mTh x y z = x * y * z`
* b) `mTh x y = \z -> x * y * z`
* c) `mTh x = \y -> \z -> x * y * z`
* d) `mTh = \x -> \y -> \z -> x * y * z`

They are **all** the same, in regards to type and effect.

2. What's the type of `mTh 3`?

d) `Num a => a -> a -> a`

3. Rewrite with lambda

a)
```haskell
addOneIfOdd = \n -> case odd n of
  True -> f n
  False -> n
  where f = \n -> n + 1
```

b)
```haskell
addFive = \x -> \y -> (if x > y then y else x) + 5
```

c)
```haskell
mflip = \f -> \x -> \y -> f y x
```

## Variety Pack

1. Given the following declarations
```haskell
k (x, y) = x
k1 = k ((4-1), 10)
k2 = k ("three", (1 + 2))
k3 = k (3, True)
```

* a) What is the type of k? `(a,b) => a`
* b) What is the type of k2? Is it the same type as k1 or k3? `String`, No
* c) Of k1, k2, k3, which will return the number 3 as the result?
  * `k1 -> 3`
  * `k3 -> 3`

2.
```haskell
-- Remember: Tuples have the same syntax for their
--           type constructors and
--           their data constructors.
f :: (a, b, c) -> (d, e, f) -> ((a, d), (c, f))
f (a, b, c) (d, e, f) =  ((a, d), (c, f))
```


## Case Practice

1.
```haskell
functionC x y = if (x > y) then x else y
```

Becomes:
```haskell
functionC x y = case x > y of
                  True -> x
                  False -> y
```

2.
```haskell
ifEvenAdd2 n = if even n then (n+2) else n
```

Becomes:
```haskell
ifEvenAdd2 n = case even n of
                 True -> n + 2
                 False -> n
```

3.
```haskell
nums x =
  case compare x 0 of
  LT -> -1
  GT -> 1
```

Becomes:
```haskell
nums x = case compare x 0 of
    EQ -> 0
    LT -> -1
    GT -> 1
```

## Artful Dodgy

```haskell
dodgy :: Num a => a -> a -> a
dodgy x y = x + y * 10

oneIsOne :: Num a => a -> a
oneIsOne = dodgy 1

oneIsTwo :: Num a => a -> a
oneIsTwo = (flip dodgy) 2
```

```haskell
-- 1.
dodgy 1 0 -- Num a => a --> 1
-- 2.
dodgy 1 1 -- Num a => a --> 11
-- 3.
dodgy 2 2 -- Num a => a --> 22
-- 4.
dodgy 1 2 -- Num a => a --> 21
-- 5.
dodgy 2 1 -- Num a => a --> 12
-- 6.
oneIsOne 1 -- Num a => a --> 11
-- 7.
oneIsOne 2 -- Num a => a --> 21
-- 8.
oneIsTwo 1 -- Num a => a --> 21
-- 9.
oneIsTwo 2 -- Num a => a --> 22
-- 10.
oneIsOne 3 -- Num a => a --> 31
-- 11.
oneIsTwo 3 -- Num a => a --> 23
```

## Guard Duty

```haskell
avgGrade :: (Fractional a, Ord a) => a -> Char
avgGrade x
  | y >= 0.9  = 'A'
  | y >= 0.8  = 'B'
  | y >= 0.7  = 'C'
  | y >= 0.59 = 'D'
  | y < 0.59  = 'F'
  where y = x / 100
```

1.
```haskell
avgGrade x
  | otherwise = 'O'
  | y >= 0.9  = 'A'
  | y >= 0.8  = 'B'
  | y >= 0.7  = 'C'
  | y >= 0.59 = 'D'
  | y < 0.59  = 'F'
  where y = x / 100

avgGrade 90 -- 'O'
avgGrade 75 -- 'O'
avgGrade 60 -- 'O'
```

2.
```haskell
avgGrade x
  | y >= 0.7  = 'C'
  | y >= 0.9  = 'A'
  | y >= 0.8  = 'B'
  | y >= 0.59 = 'D'
  | y < 0.59  = 'F'
  where y = x / 100

avgGrade 90 -- 'C' instead of 'A'
```
It evaluates the guard with 'C', changing the program expected behavior.

3.
```haskell
pal xs
  | xs == reverse xs = True
  | otherwise = False
```

b) `True` when xs is a palindrome

4. `pal` takes `[a]`.

5.  `[a] -> bool`

6.
```haskell
numbers x
  | x <  0 = -1
  | x == 0 =  0
  | x >  0 =  1
```
c) an indication of whether its argument is a positive or negative number or zero

7. It takes `(Num a, Ord a) => a`

8. `(Num a, Ord a, Num b) => a -> b`

## Chapter Exercises

### Multiple choice

1. d) may resolve to values of different types, depending on inputs
2. b) `Char -> [String]`
3. d) `(Ord a, Num a) => a -> Bool`
4. b) is a higher-order function
5. a) `f True :: Bool`

### Let's write code

1.
```haskell
tensDigit :: Integral a => a -> a
tensDigit x = d
  where xLast = x `div` 10
        d = xLast `mod` 10
```

* a) `tensDigit x = fst $ divMod x 10`
* b) Yes, both have `Integral => a -> a`
* c)
```haskell
hunsD x = fst $ divMod x 100
```

2.

```haskell
-- Guard
foldBool :: a -> a -> Bool -> a
foldBool a b x
  | x == True = a
  | x == False = b

-- If/Else
foldBool2 :: a -> a -> Bool -> a
foldBool2 a b x = if x then a else b

-- Pattern Matching
foldBool3 :: a -> a -> Bool -> a
foldBool3 a _ True = a
foldBool3 _ b False = b
```

3.
```haskell
g :: (a -> b) -> (a, c) -> (b, c)
g f (a, c) = (f a, c)
```

4. See `arith4.hs`
5. See `arith4.hs`
6. See `arith4.hs`
