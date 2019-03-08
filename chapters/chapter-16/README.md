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

## Exercises: Possibly & Sum

See `IgnoringPossibilities.hs` for the examples.

See `Possibly.hs` for the Maybe exercise.

```haskell
fmap (+1) LolNope
#=> LolNope

fmap (+1) Yeppers 10
#=> Yeppers 11

-- Lifted twice
(fmap . fmap) (+1) [LolNope, Yeppers 10, Yeppers 20, LolNope]
#=> [LolNope,Yeppers 11,Yeppers 21,LolNope]
```

See `Sum.hs` for the Either exercise.

1.
```haskell
fmap (+1) (Left 10)
#=> Left 10

fmap (+1) (Right 10)
#=> Right 11

-- Lifted twice
(fmap . fmap) (+1) [Left 10, Right 20, Left 20]
#=> [Left 10,Right 21,Left 20]
```

2. Why is a Functor instance that applies the function only to First, Either's Left, impossible?

In practice, because of the kind, it has to be `* -> *` and trying to create a functor for `Either` would result on `* -> * -> *`.
Theoretically, it doens't make much sense to have a functor for Either if it applies the same way to `Left` and `Right`, so we would expect the behavior to be different on each.
