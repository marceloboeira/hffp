# Chapter 9

## EnumFromTo

Check `enumFromTo.hs`.

## Thy Fearful Symmetry

1. Check `myWords.hs`
2. Check `PoemLines.hs`
3. Check `explode.hs`

## Comprehend Thy Lists

1. `[x | x <- mySqr, rem x 2 == 0]` - `[4, 16, 36, 64, 100]` -> filtered only the even ones
2. `[(x, y) | x <- mySqr, y <- mySqr, x < 50, y > 50]` - `[(1, 64), (1, 81), (1, 100), (4, 64), (4, 81), (4, 100), (9, 64), (9, 81), (9, 100), (16, 64), (16, 81), (16, 100), (25, 64), (25, 81), (25, 100), (36, 64), (36, 81), (36, 100), (49, 64), (49, 81), (49, 100)]`
3. `take 5 [ (x, y) | x <- mySqr, y <- mySqr, x < 50, y > 50 ]` -> `[(1, 64), (1, 81), (1, 100), (4, 64), (4, 81)]`

## Square Cube

```haskell
let mySqr = [x^2 | x <- [1..5]]
let myCube = [y^3 | y <- [1..5]]
```

1.
```haskell
[(x, y) | x <- mySqr, y <- myCube]
```

2.
```haskell
[(x, y) | x <- mySqr, y <- myCube, x < 50, y > 50]
```

3.
```haskell
length [(x, y) | x <- mySqr, y <- myCube, x < 50, y > 50]
```

## Bottom Madness

### Will it blow up?

1. `[x^y | x <- [1..5], y <- [2, undefined]]` Yes
2. `take 1 $ [x^y | x <- [1..5], y <- [2, undefined]]` No
3. `sum [1, undefined, 3]` Yes
4. `length [1, 2, undefined]` No
5. `length $ [1, 2, 3] ++ undefined` Yes
6. `take 1 $ filter even [1, 2, 3, undefined]` No
7. `take 1 $ filter even [1, 3, undefined]` Yes
8. `take 1 $ filter odd [1, 3, undefined]` No
9. `take 2 $ filter odd [1, 3, undefined]` No
10. `take 3 $ filter odd [1, 3, undefined]` Yes

### Intermission: Is it in normal form?

1. `[1, 2, 3, 4, 5]` -> NF
2. `1 : 2 : 3 : 4 : _` -> WHNF
3. `enumFromTo 1 10` -> Neither, not a data constructor.
4. `length [1, 2, 3, 4, 5]` -> Neither, not a data constructor.
5. `sum (enumFromTo 1 10)` -> Neither, not a data constructor.
6. `['a'..'m'] ++ ['n'..'z']`  -> Neither, not a data constructor.
7. `(_, 'b')` -> WHNF, _, wasn't fully evaluated but it is a data constructor.

## More Bottoms

1. `take 1 $ map (+1) [undefined, 2, 3]` - It errors since `undefined` is in the first usage
2. `take 1 $ map (+1) [1, undefined, 3]` - It works, returns `[2]` since we only take 1 from the list
3. `take 2 $ map (+1) [1, undefined, 3]` - It errors, since `undefined` is taken

Note: map only 'runs' for the amount of times it is forced to.

4.
```haskell
itIsMystery xs = map (\x -> elem x "aeiou") xs
```
The function takes a String and returns an array of Bool. `String -> [Bool]`, where each bool represents the `Char` on the same position on the String, for being a vowel or not. e.g.:

* `aaaa` -> `[True, True, True, True]`
* `abab` -> `[True, False, True, False]`:w

5.
* a) `map (^2) [1..10]` -> `[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]`
* b) `map minimum [[1..10], [10..20], [20..30]]` -> `[1, 10, 20]`
* c) `map sum [[1..5], [1..5], [1..5]]` -> `[15, 15, 15]`

6.
```haskell
import Data.Bool
map (\x -> bool x (-x) (x == 3)) [1..10]
```

## Filtering

1. `filter (\x -> (rem x 3) == 0) [1..30]`
2. `length $ filter (\x -> (rem x 3) == 0) [1..30]`
3.
```haskell
myFilter :: String -> [String]
myFilter = filter (\w -> notElem w ["the", "a", "an"]) . words
```

```haskell
myFilter "the brown dog was a goof"
> ["brown","dog","was","goof"]
```


## Zipping exercises

1.
```haskell
zip :: [a] -> [b] -> [(a, b)]
zip _ [] = []
zip [] _ = []
zip (x:xs) (y:ys) = (x,y) : zip xs ys
```

2.
```haskell
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ [] _ = []
zipWith _ _ [] = []
zipWith f (x:xs) (y:ys) = f x y : zipWith f xs ys
```

3.
```haskell
zip = zipWith \x -> \y -> (x, y)
```

## Chapter Exercises

### Data.Char
1.
```haskell
Prelude Data.Char> isUpper 'J'
True
Prelude Data.Char> toUpper 'j'
'J'
```
2.
```haskell
import Data.Char

fUp = filter (isUpper)
fUp "HbEfLrLxO"` -- `"HELLO"`
```

3.
```haskell
import Data.Char

captalize :: String -> String
captalize (x:xs) = toUpper x : xs
```

4.
```haskell
import Data.Char

makeUpper :: String -> String
makeUpper = map toUpper
-- or
makeUpper "" = ""
makeUpper (x:xs) = toUpper x : makeUpper xs
```

5.
```haskell
import Data.Char

firstUpper :: String -> Char
firstUpper x = toUpper (head x)
```

6.
```haskell
import Data.Char

firstUpper = toUpper . head
```


### Writing your own standard functions

````haskell
-- Example
myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (x:xs) = x && myAnd xs

-- 1.
myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs)
  | x == True = True
  | otherwise = myOr xs

-- 2.

myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny f (x:xs)
  | (f x) = True
  | otherwise = myAny f xs

-- 3.
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem e (x:xs)
  | x == e = True
  | otherwise = myElem e xs

myElem' :: Eq a => a -> [a] -> Bool
myElem' x = myAny (== x)

-- 4.
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = (myReverse xs) ++ [x]

-- 5.
squish :: [[a]] -> [a]
squish [] = []
squish (x:xs) = x ++ squish xs

-- 6.
squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ [] = []
squishMap f (x:xs) = (f x) ++ squishMap f xs

-- 7.
squishAgain = squishMap (id)

-- 8.
myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ (x:[]) = x
myMaximumBy f (x:xs)
  | r == LT = y
  | otherwise = x
  where y = (myMaximumBy f xs)
        r = f x y

-- 9.
myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ (x:[]) = x
myMinimumBy f (x:xs)
  | r == GT = y
  | otherwise = x
  where y = (myMinimumBy f xs)
        r = f x y

-- 10.
myMaximum :: (Ord a) => [a] -> a
myMaximum = myMaximumBy compare

myMinimum :: (Ord a) => [a] -> a
myMinimum = myMinimumBy compare
```
