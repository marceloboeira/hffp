# Chapter 10

## Understanding Folds

1. `foldr (*) 1 [1..5]`

* b) foldl (flip (*)) 1 [1..5]
* c) foldl (*) 1 [1..5]

Both return the same as the first one.

2.
```
foldl (flip (*)) 1 [1..3]

foldl (flip (*)) ((flip (*)) 1 1) [2, 3]
                 ((flip (*)) 1 2) [3]
                 ((flip (*)) 2 3) []
                 6 []
```

3. c) foldr, but not foldl, associates to the right

4. a) reduce structure

5.

* a) `foldr (++) "-start" ["woot", "WOOT", "woot"]`
* b) `foldr max 'a' "fear is the little death"`
* c) `foldr (\x y -> and [x,y]) True  [False, True]` OR `foldr (&&) True  [False, True]`
* d) `foldr (||) False [False, True]`
* e) `foldr ((++) . show) "" [1..5]`
* f) `foldl const 'a' [1..5]`
* g) `foldl const 0 "tacos"`
* h) `foldl const 0 "burritos"`
* i) `foldl const 'z' [1..5]`

## Database Processing

`Database.hs`

## Scan Exercises

--- TODO

## Chapter Exercises

### Warm-up and review

1.
a)

```haskell
warmUp stops vowels = [(x, y, z) | x <- stops, y <- vowels, z <- stops]
```

b)

```haskell
warmUp stops vowels = [(x, y, z) | x <- stops, y <- vowels, z <- stops, x == 'p']
```

c)

```haskell
warmUp nouns verbs = [(x, y, z) | x <- nouns, y <- verbs, z <- nouns]
```

2.

```haskell
seekritFunc x = div (sum (map length (words x))) (length (words x))
```

Apparently, it calculates the average length of the words of a text.

3.

```haskell
avgWordLength :: Fractional a => String -> a
avgWordLength x = (/) (sum (map length' (words x))) (length' (words x))
  where length' = fromIntegral . length
```


### Rewrite with fold

`rewrite.hs`
