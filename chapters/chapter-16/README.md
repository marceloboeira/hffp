# Chapter 16

## Exercises: Be Kind

```haskell
1
a -> a
:k a = *

2
a -> b a -> T (b a)
:k b = * -> *
:k T = * -> *

3
c a b -> c b a
:k c = * -> * -> *
```

## FixMePls

See `FixMePls.hs`.

```haskell
fmap (+1) (Pls 2)
#=> Pls 3
```

## Exercises: Heavy Lifting

See `HeavyLifting.hs`.

(To test load the file and run `checkAll`).

## Example (Two & Or)

See `Two.hs` & `Or.hs`.

```haskell
-- Two - always fmap to "b", "a" remains the same
fmap (+1) (Two 10 20)
#=> Two 10 21

-- Or - always map to "second", first remains the same
fmap (+1) (First 10)
First 10
fmap (+1) (Second 10)
Second 11
```

## Exercises: Instance of Functor

See `qc/tests/tests.hs`.
