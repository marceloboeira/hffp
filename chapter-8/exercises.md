# Chapter 8

## Intermission

Write out the evaluation of the following.
It might be a little less noisy if you do so with the form that didn't use (.).

```haskell
applyTimes 5 (+1) 5
(+1) applyTimes 4 (+1) 5
((+1) . (+1)) applyTimes 4 (+1) 5
((+1) . (+1) . (+1)) applyTimes 3 (+1) 5
((+1) . (+1) . (+1) . (+1)) applyTimes 2 (+1) 5
((+1) . (+1) . (+1) . (+1) . (+1)) applyTimes 1 (+1) 5
((+1) . (+1) . (+1) . (+1) . (+1) . (+1)) applyTimes 0 (+1) 5
((+1) . (+1) . (+1) . (+1) . (+1) . (+1)) 5
```

## Chapter Exercises

### Review of Types

1. d) `[[Bool]]`
2. b) `[[3 == 3], [6 > 5], [3 < 4]]`
3. d) all of the above
4. b) `func "Hello" "World"`

### Reviewing currying

Given the following definitions, tell us what value results from further applications.

```haskell
cattyConny :: String -> String -> String
cattyConny x y = x ++ " mrow " ++ y

flippy :: String -> String -> String
flippy = flip cattyConny

appedCatty :: String -> String
appedCatty = cattyConny "woops"

frappe :: String -> String
frappe = flippy "haha"
```

```haskell
-- 1.
appedCatty "woohoo!" -- "woops mrow woohoo!"
-- 2.
frappe "1" -- "1 mrow haha"
-- 3.
frappe (appedCatty "2") -- "woops mrow 2 mrow haha"
-- 4.
appedCatty (frappe "blue") -- "woops mrow blue mrow haha"
-- 5.
cattyConny (frappe "pink") (cattyConny "green" (appedCatty "blue")) -- "pink mrow haha mrow green mrow woops mrow blue"
-- 6.
cattyConny (flippy "Pugs" "are") "awesome" -- "are mrow Pugs mrow awesome"
```
