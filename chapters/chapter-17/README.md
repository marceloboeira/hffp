# Chapter 17

## Exercises: Lookups

See `Lookup.hs`.

Interesting bits:
  - How the combination of `<$>` and `<*>` work?

```haskell

(++) <$> (Just "foo") <*> (Just "bar")
#=> Just "foobar"

((++) <$> (Just "foo")) <*> (Just "foo")
#=> Just "foobar"

:t (++) <$> (Just "foo")
(++) <$> (Just "foo") :: Maybe ([Char] -> [Char])

-- returns a Maybe with a Function... a wrapped function, soon:
wrapped = (++) <$> (Just "foo")
wrapped <*> (Just "bar")
#=> Just "foobar"

-- what about...
pure (++) <*> (Just "foo") <*> (Just "bar")
#=> Just "foobar"

-- basically...
wrapped = (++) <$> (Just "foo")
wrapped' = pure (++) <*> (Just "foo")

-- they are the same...

wrapped <*> (Just "bar")
#=> Just "foobar"

wrapped' <*> (Just "bar")
#=> Just "foobar"
```

## Exercises: Identity Instance

See `Identity.hs`.

```haskell
-- functor-wise
fmap (+10) (Identity 20)
#=> Identity 30

(+10) <$> (Identity 20)
#=> Identity 30

-- applicative-wise
Identity (+10) <*> Identity 20
#=> Identity 30

-- with pure
pure (+) <*> Identity 10 <*> Identity 20
#=> Identity 30
```
