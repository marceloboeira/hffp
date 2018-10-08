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
