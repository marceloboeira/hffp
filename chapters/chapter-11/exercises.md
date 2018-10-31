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


## For example

```haskell
data Example = MakeExample deriving Show
```

1. `MakeExample :: Example` && `Data constructor not in scope: Example`
2. `Deriving Show?`
3. See:

```haskell
data Example2 = MakeExample2 Int deriving Show
```

Checking the type
```
MakeExample2 :: Int -> Example2
```

## Logic Goats

`goats.hs`

## Pitty Bool

1. Cardinality is 4 (2 booleans)
```haskell
data BigSmall = Big Bool | Small Bool deriving (Eq, Show)
```

2. Cardinality is 258 (256 + 2)
```haskell
import Data.Int
data NumberOrBool = Numba Int8 | BoolyBool Bool deriving (Eq, Show)

-- parentheses due to syntactic
-- collision between (-) minus
-- and the negate function
let myNumba = Numba (-128)
```

## How Does Your Garden Grow

1. Given the type
```haskell
data FlowerType = Gardenia | Daisy | Rose | Lilac deriving Show
type Gardener = String
data Garden = Garden Gardener FlowerType deriving Show
```

What is the sum of products normal form of Garden?
```haskell
type Gardener = String
data Garden = Gardenia Gardener |
              Daisy  Gardener   |
              Rose Gardener     |
              Lilac Gardener deriving Show
```

## Programmers

`programmers.hs`

## Exponentiation in what order?

```haskell
data Quantum = Yes | No | Both deriving (Eq, Show)

convert0 :: Quantum -> Bool
convert0 Yes  = True
convert0 No   = True
convert0 Both = True

convert1 Yes  = False
convert1 No   = False
convert1 Both = False

convert2 Yes  = True
convert2 No   = True
convert2 Both = False

convert3 Yes  = True
convert3 No   = False
convert3 Both = True

convert4 Yes  = False
convert4 No   = True
convert4 Both = False

convert5 Yes  = True
convert5 No   = False
convert5 Both = False

convert6 Yes  = False
convert6 No   = True
convert6 Both = True

convert7 Yes  = False
convert7 No   = True
convert7 Both = False
```

## The Quad

```haskell
-- 1.
data Quad = One | Two | Three | Four deriving (Eq, Show)
eQuad :: Either Quad Quad
-- 4 + 4 = 8

-- 2.
prodQuad :: (Quad, Quad)
-- 4 * 4 = 16

-- 3.
funcQuad :: Quad -> Quad
-- 4^4 = 256

-- 4.
prodTBool :: (Bool, Bool, Bool)
-- 2 * 2 * 2 = 8

-- 5.
gTwo :: Bool -> Bool -> Bool
-- (2^2)^2 = 16

-- 6.
fTwo :: Bool -> Quad -> Quad
-- (2 ^ 4) ^ 4 = 65536
```

## Write Map for a BinaryTree / Convert a BinaryTree to List / Write foldr for BinaryTree

`Binary.hs`

## Chapter Exercises

1. a) Weekday is a type with five data constructors
2. c) `f :: Weekday -> String`
3. b) must begin with a capital letter
4. c) delivers the final element of xs

## Ciphers

See `Vigenere.hs`

## As Patterns / Language Exercises

See `As.hs`

## Hutton's Razor

See `Razor.hs`
