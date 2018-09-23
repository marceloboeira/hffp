# Chapter 4

## Find mistakes

1. `not True && true` -> `not True && True` -> `false`
2. `not (x = 6)` -> `x is not previously defined`
3. `(1 * 2) > 5` -> `false`
4. `[Merry] > [Happy]` -> `["Merry"] > ["Happy"]` > `True`
5. `[1, 2, 3] ++ "look at me!"` -> 2 different types

## Chapter Exercises

```haskell
awesome = ["Papuchon", "curry", ":)"]
also = ["Quake", "The Simons"]
allAwesome = [awesome, also]
```
length is a function that takes a list and returns a result that tells how many items are in the list.

1.

* a) `lenght :: [a] -> Integer`
* b) Takes 1 argument, the "list/array/collection" itself
* c) It results in a "Int/Integer" number

2.

* a) `length [1, 2, 3, 4, 5]` -> `5`
* b) `length [(1, 2), (2, 3), (3, 4)]` -> `3`
* c) `length allAwesome` -> `2`
* d) `length (concat allAwesome)` -> `5`

3.

```haskell
6 / 3
-- and
6 / length [1, 2, 3] -- because it returns Int and that's not a Fractional number
```

4.

```haskell
6 `div` length [1,2,3]
-- or
6 / fromIntegral (length [1,2,3])
```

since

```haskell
:t div
div :: Integral a => a -> a -> a
```

5.

```haskell
2 + 3 == 5 -- :: Bool -> True
```

6.

```haskell
let x = 5 -- nothing?
x + 3 == 5 -- False
```

7.

```haskell
length allAwesome == 2 -- works, it reduces to True (still unsure how tho)
length [1, 'a', 3, 'b'] -- should not have different types
length allAwesome + length awesome -> works, it reduces to 5 (precendence?...)
(8 == 8) && ('b' < 'a') -- works, it reduces to False because 'b' > 'a'
(8 == 8) && 9 -- should have 2 boolean statements
```

8.

```haskell
isPalindrome :: Eq a => [a] -> Bool
isPalindrome x = (x == reverse x)

isPalindrome "ovo" -> Should return True
isPalindrome "vaca" -> Should return False
````

9.

```haskell
myAbs :: Integer -> Integer
myAbs x = if (x < 1) then 1 else x

myAbs 0 -- Should return 1
myAbs 1 -- Should return 1
myAbs 10 -- Should return 10
```

10.

```haskell
f :: (a, b) -> (c, d) -> ((b, d), (a, c))

f x y = ((snd x, snd y), (fst x, fst y))

f ('a', 'b') ('c', 'd') -- using chars to demonstrate
-- returns (('b','d'),('a','c'))
```

## Correcting Syntax

1.

```haskell
x = (+)
F xs = w 'x' 1
where w = length xs
```

```haskell
x = (+)
f xs = w `x` 1
where w = length xs
```

2.

```haskell
\X = x

-- becomes

id' x = x
-- or
id' = \x -> x
```

3.

```haskell
f (a b) = A

-- becomes

fst' (a, _) = a
```

### Match the function names to their types

1. c) `Show a => a -> String`

2. b) `Eq a => a -> a -> Bool`

3. a) `(a, b) -> a`

4. d) `(+) :: Num a => a -> a -> a`
