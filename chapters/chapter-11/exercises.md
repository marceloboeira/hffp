# Chapter 11

## Dog Types

```haskell
data Doggies a = Husky a | Mastiff a deriving (Eq, Show)
```

```haskell
data PugType = PugData
data HuskyType a = HuskyData
data DogueDeBordeaux doge = DogueDeBordeaux doge
```
Given the datatypes defined in the above sections,

1. type constructor
2. `Doggies :: (* -> *)` since its waiting for a type
3. `Doggies String :: *`
4. `Husky 10 :: Num a => Doggies a`
5. `Husky 10 :: Doggies a`
6. `Mastiff "Scooby Doo" :: Doggies [Char]`?
7. Both, it depends if you are referring to it on a type level or term level.
8. `DogueDeBordeaux :: doge -> DogueDeBordeaux doge`
9. `DogueDeBordeaux "doggie!" :: DogueDeBordeaux [Char]`

## Vehicles

`vehicle.hs`

## Cardinality

1.

`data PugType = PugData` ->  Cardinality is 1

2.

```haskell
data Airline =
             PapuAir
           | CatapultsR'Us
           | TakeYourChancesUnited
```

Cardinality is 3.

3.

Int16? (2^16)
Cardinality is `65.536`

4.

* Int is actually Int64 (Cadinality is 1,844674407370955e19)
* Integer is not bounded, it is essentially infinite (limited by the
available memory)

5.

8 -> 8 bits = 2^8 = 256

The 8 means that we use 8 bits to store the number, so In16 uses 16, Int32 uses 32, In64 uses 64.