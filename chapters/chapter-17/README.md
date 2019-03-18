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

## Exercises: Constant Instance

See `Constant.hs`.

## Examples

See `qc/tests/tests.hs` for "You knew this was coming".

See `qc/tests/Apl1.hs` for "ZipList Monoid".

## Exercises: List Applicative Instance

See `qc/tests/ListApplicativeTest.hs`.

Small reasoning section (for my own record).
```haskell
-- The example expects

(Cons (+1) (Cons (*2) Nil)) <*> (Cons 1 (Cons 2 Nil))

-- to result in

(Cons 2 (Cons 3 (Cons 2 (Cons 4 Nil))))

-- For that, we need to write an applicative, let's split each step
-- Step 1: Unwrap the function and apply
-- If we were to have:
(+1) and (Cons 1 (Const 2 Nil))

-- We could use fmap direcly:
fmap (+1) (Cons 1 (Const 2 Nil))

-- That would return:
(Cons 2 (Cons 3 Nil))

-- Our applicative would look like
(<*>) (Cons f _) vs = f <$> vs

-- And it actually compiles, even though it doesn't contemplate all the applicative laws:
(Cons (+1) Nil) <*> (Cons 1 (Const 2 Nil))

-- Returns
(Cons 2 (Cons 3 Nil))

-- But
(Cons (+1) (Cons (*2) Nil)) <*> (Cons 1 (Cons 2 Nil))

-- Also returns:
(Cons 2 (Cons 3 Nil))

-- Which we know is not complete.

-- Step 2: Handle the tail of the left side, by recursively calling applicative
(<*>) (Cons f fs) vs
  = (f <$> v) ?? (fs <*> vs)
              |--|---|---|-> v is the right side attribute, the list of values
              |--|---|-----> we use applicative operator, to call it recursively until it hits the break conditions
              |--|---------> fs is the tail of the left side attribute, a (List a)
              |------------> We need to find a way to join the values

-- Step 3: Glue everything together
-- We can use <> (mappend) to join both lists, and then have the expected result:
(<*>) (Cons f fs) vs = (f <$> v) <> (fs <*> vs)

-- Now, this:
(Cons (+1) (Cons (*2) Nil)) <*> (Cons 1 (Cons 2 Nil))

-- Returns:
(Cons 2 (Cons 3 (Cons 2 (Cons 4 Nil))))

(\____/)
( ͡ ͡° ͜ ʖ ͡ ͡°)
\╭☞ \╭☞
```

## Exercises: ZipList Applicative Instance

See `qc/tests/ZipListApplicativeTest.hs`.
