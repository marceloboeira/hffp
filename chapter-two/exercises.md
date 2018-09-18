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
