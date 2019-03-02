# Chapter 15

**Important** - Semigroup is a superclass of Monoid since base-4.11.0.0 (April of 2018), therefore all monoids exercises are not 100% like the book.

### Example Monoid

See `Booly.hs`.

```haskell
(False' :: Booly [Char]) <> (True' :: Booly [Char])
#=> False'

(True' :: Booly [Char]) <> (True' :: Booly [Char])
#=> True'
```

We have to force a type for `a` since it's not on the subtypes, the Semigroup/Monoid instance can't be inferred.

## Exercise: Optional Monoid

See `Option.hs`.

```haskell
Some "Hello" <> None <> Some " World!"
#=> Some "Hello World!"
```

## Listy orphan instance

See `Listy.hs`.

```haskell
(Listy ['m']) <>  (Listy ['7'])
#=> Listy "m7"
```

## Exercise: Madness

See `Madness.hs`.

```haskell
madlibbin' ("DON'T" :: Exclamation) ("loudly" :: Adverb) ("quickly" :: Noun) ("pretty" :: Adjective)

#=> "DON'T! she said loudly as she jumped into her car quickly and drove off with her pretty wife."
```
