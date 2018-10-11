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

# Apply Yourself

1. `(++) :: [a] -> [a] -> [a]`

```haskell
myConcat x = x ++ " yo"
```

It starts as a generic array of any type `[a]`, and it changes to be an specific concat of `[Char]`:
```haskell
myConcat :: [Char] -> [Char]
```

2. `(*) :: Num a => a -> a -> a`

```haskell
myMult x = (x / 3) * 5
```
It starts as a generic `Num a` kind of type, it gets narrow down to `Fractional a` because of the `/3`.
```Haskell
myMult :: Fractional a => a -> a
```

3. `take :: Int -> [a] -> [a]`

```haskell
myTake x = take x "hey you"
```
Since it takes from an specific array of char, the new signature is less generic, e.g.:
```haskell
myTake :: Int -> [Char]
```

4. `(>) :: Ord a => a -> a -> Bool`

```haskell
myCom x = x > (length [1..10])
```
It focuses on getting the `Int` comparinson only:
```haskell
myCom :: Int -> Bool
```

5. `(<) :: Ord a => a -> a -> Bool`
```haskell
myAlph x = x < 'z'
```
It focuses on getting the `Char` comparinson only:
```haskell
myAlph :: Char -> Bool
```

## Chapter Exercises

### Multiple Choice
1. c) a list whose elements are all of some type `a`
2. a) take a list of strings as an argument
3. b) returns one element of type `a` from a list
4. c) takes a tuple argument and returns the first value

### Determine the Type

1.

* a) `Num a => a`
* b) `Num a => (a, [Char])`
* c) `(Integer, [Char])`
* d) `Bool`
* e) `Int`
* f) `Bool`

2. `Num a => a`

3. `Fractional a => a`

4. `[Char]`

### Does it compile?

1.
```haskell
bigNum = (^) 5 $ 10
wahoo = bigNum $ 10
```
No, bigNum must be a function

```haskell
bigNum = (^) 5
wahoo = bigNum $ 10
```

2.
```haskell
x = print
y = print "woohoo!"
z = x "hello world"
```
Yes.

3.
```haskell
a = (+)
b = 5
c = b 10
d = c 200
```

No, missing the use of (+) function
```haskell
a = (+)
b = a 5
c = b 10
d = c 200
```

4.
```haskell
a = 0
c = 12 + a
b = 10000 * c
```

### Type variable or specific type constructor?

1.
```haskell
f :: Num a => a -> b -> Int -> Int`
         --  [0]  [1]   [2]    [3]
```

* 0 -> Constrained
* 1 -> Fully
* 2 -> Concrete
* 3 -> Concrete

2.
```haskell
f :: zed -> Zed -> Blah
```

* 0 -> Fully
* 1 -> Concrete
* 2 -> Concrete

3.
```haskell
f :: Enum b => a -> b -> C
```

* 0 -> Fully
* 1 -> Constrained
* 2 -> Concrete

4.
```haskell
f :: f -> g -> C
```

* 0 -> Fully
* 1 -> Fully
* 2 -> Concrete

### Write a type signature

1.
```haskell
functionH :: [a] -> a
functionH (x:_) = x
```

2.
```haskell
functionC :: (Ord a) => a -> a -> Bool
functionC x y = if (x > y) then True else False
```

3.
```haskell
functionS :: (a, b) -> b
functionS (x, y) = y
```

### Given a type, write the function

1.
```haskell
i :: a -> a
i = a
```

2.
```haskell
c :: a -> b -> a
c x y = x
```

3.
```haskell
c'' :: b -> a -> b
c'' x y = x
```

4.
```haskell
c' :: a -> b -> b
c' x y = y
```

5.
```haskell
r :: [a] -> [a]
r (x:xs) = xs --tail
```

6.
```haskell
co :: (b -> c) -> (a -> b) -> a -> c
co f g x = f $ g x
```

7.
```haskell
a :: (a -> c) -> a -> a
a f x = a
```

8.
```haskell
a' :: (a -> b) -> a -> b
a' f a = f a
```

### Fix it

1. `Sing.hs`
2. `SingAnother.hs`
3. `Arith3Broken.hs`

### Type-Kwon-Do

1. `TypeKwonDo_1.hs`
2. `TypeKwonDo_2.hs`
3. `TypeKwonDo_3.hs`
4. `TypeKwonDo_4.hs`
