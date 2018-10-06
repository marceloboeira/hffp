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
