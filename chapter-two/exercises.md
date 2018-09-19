## Expressions & Functions

1. Convert to GHCI/REPL usage

From:
```haskell
half x = x / 2
square x = x * 2
```

To:

```haskell
let half x = x / 2
let square x = x * 2
```

PS: They work on GHCI on their normal form... IDK why we, supposedly, have to use the let statement.

2. Create a function for pi times

```haskell
3.14 * (5 * 5)
3.14 * (10 * 10)
3.14 * (2 * 2)
3.14 * (4 * 4)
```

As a function
```haskell
let circleAreaWith x = 3.14 * square x

circleAreaWith 5   // 78.5
circleAreaWith 10  // 314.0
circleAreaWith 2   // 12.56
circleAreaWith 4   // 50.24
```

3. Use pi instead of `3.14`

```haskell
let circleAreaWith x = pi * square x

circleAreaWith 5   // 78.53981633974483
circleAreaWith 10  // 314.1592653589793
circleAreaWith 2   // 12.566370614359172
circleAreaWith 4   // 50.26548245743669
```

## Parentheses and Association

1.
```haskell
a) 8 + 7 * 9
b) (8 + 7) * 9
```
> Yes, it changes because of precedence of * against +


2.
```haskell
a) perimeter x y = (x * 2) + (y * 2)
b) perimeter x y = x * 2 + y * 2
```
> No, it doesn't change

3.
```haskell
a) f x = x / 2 + 9
b) f x = x / (2 + 9)
```
> Yes, it changes, because of precedence on / against +

## A Head Code

1. `let x = 5 in x`
> Should return 5, returns 5

2. `let x = 5 in x * 5`
> Should return 25, returns 25

3. `let x = 5; y = 6 in x * y`
> Should return 30, returns 30

4. `let x = 3; y = 1000 in x + 3`
> Should return 6, returns 6

-----

**Rewrite with where**

1. `let x = 3; y = 1000 in x * 3 + y`

```haskell
mult1 = x * 3 + y
  where x = 5
        y = 1000
```
> 1015

2. `let y = 10; x = 10 * 5 + y in x * 5`

```haskell
mult2 = x * 5
  where y = 10
        x = 10 * 5 + y
```
> 300

3.

```haskell
let x = 7
    y = negate x
    z = y * 10
in z / x + y
```

```haskell
mult3 = z / x + y
  where x = 7
        y = negate x
        z = y * 10
```

> -17

## Chapter Exercises

### Parenthesization

```haskell
-- example
2 + 2 * 3 - 3
2 + (2 * 3) - 3

-- 1
2 + 2 * 3 - 1
2 + (2 * 3) - 1

-- 2
(^) 10 $ 1 + 1
10 ^ (1 + 1)

-- 3
2 ^ 2 * 4 ^ 5 + 1
((2 ^ 2) * (4 ^ 5)) + 1
-- or
(+) 1 $ (*) ((^) 2 2) ((^) 4 5)
```

### Equivalent expressions

```haskell
-- 1 - yes
1 + 1
2

-- 2 - yes
10 ^ 2 -- = 100
10 + 9 * 10 -- = 10  + 90 = 100

-- 3 - no (subtraction is not commutative)
400 - 37 -- = 363
(-) 37 400 -- = -363

-- 4 - no (numerical types)
100 `div` 3 -- force integral dividison = 33
100 / 3 -- floating point division = 33.33336

-- 5 - no (prededence order)
2 * 5 + 18 -- = 28
2 * (5 + 18) -- = 46
```

### More fun with functions
```haskell
-- need to reorder first...
let z = 7
let y = z + 8
let x = y ^ 2
let waxOn = x * 5

(+10) waxOn
-- 1135
10 + waxOn
-- 1135
(+10) waxOn
-- 1135
(-) 15 waxOn
-- -1110
(-) waxOn 15
-- 1110
-- I guess the catch was the subtraction not being commutative

let triple x = x * 3
triple waxOn
-- 3375
-- I'm supposed to check my understanding, I guess the catch is that the x on the triple scope is independent of the global x, since the lexical scope changed, triple uses a local x and not the global one, whereas waxOn uses the one defined on prelude

let waxOff x = triple x

let waxOff' x = half . triple . square $ x
...
```
