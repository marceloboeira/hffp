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
