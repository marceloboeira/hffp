# Chapter 5

## Type Maching

* a) `not` -> c) `_ :: Bool -> Bool`
* b) `length` -> d) `_ :: [a] -> Int`
* c) `concat` -> b) `_ :: [[a]] -> [a]`
* d) `head` -> a) `_ :: [a] -> a`
* e) `(<)` ->  e) `_ :: Ord a => a -> a -> Bool`

## Type Arguments

1. `f :: a -> a -> a -> a` and `a` is `Char` then x is: a) `Char -> Char -> Char`
2. `g :: a -> b -> c -> b` then the type os `g 0 'c' "woot"` is: d) `Char`
3. `(Num a, Num b) => a -> b -> b` then the type of `h 1.0 2` is: d) `Num b => b`
4. `h 1 (5.5 :: Double)` then the type is: c) `Double`
5. `jackal :: (Ord a, Eq b) => a -> b -> a for jackal "foo" "bar"`: a) `[Char]`
6. `jackal "foo"`: then the type is e) `(Eq b) => b -> [Char]`
7. `kessel :: (Ord a, Num b) => a -> b -> a for kessel 1 2` then the type is `(Num a, Ord a) => a`
8. `kessel 1 (2 :: Integer)` then the type is d) `(Num a, Ord a) => a`
9. `kessel (1 :: Integer) 2` then the type is c) `Integer`

## Paramecitry

1.

```haskell
impossible :: a -> a
impossible x = x

    No instance for (Num a) arising from a use of `+`
      Possible fix:
        add (Num a) to the context of
          the type signature for:
            impossible :: forall a. a -> a
        In the expression: x + 1
      In an equation for 'impossible': impossible x = x + 1
```

Or

```haskell
impossible :: a -> a
impossible x = x + ""

<interactive>:2:42: error:
    Couldn't match expected type 'a' with actual type [Char]
      a is a rigid type variable bound by
        the type signature for:
          impossible :: forall a. a -> a
        at <interactive>:2:1-20
    In the second argument of (+), namely " "
      In the expression: x + " "
      In an equation for impossible: impossible x = x + " "
    Relevant bindings include
        x :: a (bound at <interactive>:2:34)
        impossible :: a -> a (bound at <interactive>:2:23)
```

2.

```haskell
left :: a -> a -> a
left x y = x

right :: a -> a -> a
right x y = y
```

3.
```haskell
right :: a -> b -> b
right x y = y
```
