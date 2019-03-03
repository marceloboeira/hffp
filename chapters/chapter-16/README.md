# Chapter 16

## Exercises: Be Kind

```
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

```
fmap (+1) (Pls 2)
#=> Pls 3
```

## Exercises: Heavy Lifting

See `HeavyLifting.hs`.

(To test load the file and run `checkAll`).
