# Chapter 3

```haskell
Prelude> :type 'a'
'a' :: Char
```

## Scope

1. These lines of code are from a REPL session. Is y in scope for z?

```haskell
> let x = 5
> let y = 7
> let z = x * y
```
> Yes

2. These lines of code are from a REPL session. Is h in scope for g? Go with your gut here.

```haskell
> let f = 3
> let g = 6 * f + h
````
> No, h was not defined previously

3. This code sample is from a source file. Is everything we need to execute area in scope?

```haskell
area d = pi * (r * r)
r = d/2
```
> No, pi comes from Prelude?, but also r expects d to be sent

4. This code is also from a source file. Now are r and d in scope for area?
```haskell
area d = pi * (r * r)
  where r = d / 2
```
> Yes, now d in is the scope of r which is in the scope of area

## Syntax Errors

Read the syntax of the following functions and decide whether it will compile.
Test them in your REPL and try to fix the syntax errors where they occur.

1. `++ [1, 2, 3] [4, 5, 6]` -> `(++) [1, 2, 3] [4, 5, 6]`
2. `'<3' ++ ' Haskell'` -> `"<3" ++ " Haskell"`
3. `concat ["<3", " Haskell"]` -> it works already

## Chapter Exercises

1.

* a) `concat [[1, 2, 3], [4, 5, 6]]` -> Correct
* b) `++ [1, 2, 3] [4, 5, 6]` -> `(++) [1, 2, 3] [4, 5, 6]`
* c) `(++) "hello" " world"` -> Correct
* d) `["hello" ++ " world]` -> Correct
* e) `4 !! "hello"` -> `"hello" !! 4`
* f) `(!!) "hello" 4` -> Correct
* g) `take "4 lovely"` -> `take 4 "lovely"`
* h) `take 3 "awesome"` -> Correct

2.

* a) `concat [[1 * 6], [2 * 6], [3 * 6]]` ->  `[6,12,18]`
* b) `"rain" ++ drop 2 "elbow"` -> `"rainbow"`
* c) `10 * head [1, 2, 3]` -> `10`
* d) `(take 3 "Julie") ++ (tail "yes")` ->  `"Jules"`
* e) `concat [tail [1, 2, 3], tail [4, 5, 6], tail [7, 8, 9]]` -> `[2,3,5,6,8,9]`

## Building functions

Example

```haskell
-- If you apply your function -- to this value:
-- "Hello World"
-- Your function should return: "ello World"
let dropFirst = drop 1
dropFirst "Hello World"
-- "ello World"
```

a)

```haskell
-- Given
-- "Curry is awesome"
-- Return
-- "Curry is awesome!"

let enphasize x = x ++ "!"
enphasize "Curry is awesome"
-- "Curry is awesome!"
```

b)
```haskell
-- Given
-- "Curry is awesome!"
-- Return
-- "y"

let fourthLetter x = x !! 4
fourthLetter "Curry is awesome"
-- "y"
```

c)

```haskell
-- Given
-- "Curry is awesome"
-- Return
-- "awesome!"

let drop9 = drop 9
drop9 "Curry is awesome!"
-- "awesome!"
```

2. -- `curry.hs`

3. -- `curry.hs`
3. -- `curry.hs`

5.
```haskell
-- Given
-- "Curry is awesome"
-- Return
-- "awesome is Curry"

let x = "Curry is awesome"
let y = drop 9 x
let z = take 2 $ drop 6 x
let w = take 5 x
let rvrs = y ++ " " ++ z ++ " " ++ w
```

6. -- `Reverse.hs`
