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
