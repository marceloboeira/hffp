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
