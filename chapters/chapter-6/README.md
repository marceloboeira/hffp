# Chapter 6

## Eq Instances

--> See "EqInstances.hs"

## Tuple Experiment

```haskell
let ones x = snd (divMod x 10)

quotRem 10 (-3) (-3,1)
divMod 10 (-3) (-4,-2)
```

## Will They Work?

1.
Yes, returns 5
```haskell
max (length [1, 2, 3]) (length [8, 9, 10, 11, 12])
```
2.
Yes, returns LT
```haskell
compare (3 * 4) (3 * 5)
```

3.
No, while there are 2 different types
```haskell
compare "Julie" True
```

4.
Yes, returns false since 8 is not > 9
```haskell
(5 + 3) > (3 + 6) -- # False
```

## Chapter Exercises

### Multiple Choice

1. c) makes equality tests possible

2. c) is a superclass of Eq

3. a) Ord a => a -> a -> Bool

4. c) the type of x is a tuple

5. a) Int and Integer numbers

### Does it typecheck?

1.
```haskell
data Person = Person Bool deriving Show

printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)
```
No, it's missing the dering. (Added)

2.
```haskell
data Mood = Blah | Woot deriving Show

settleDown x = if x == Woot then Blah else x
```
No, it's missing the equality so that you can compare on the settleDown function

3.

If you were able to get `settleDown` to typecheck:

a) What values are acceptable inputs to that function?
`settleDown :: Mood -> Mood`

b) What will happen if you try to run `settleDown 9`? Why?
`Fail, since 9 is not a Mood`

c) What will happen if you try to run `Blah > Woot`? Why?
`Return false, since Ord is not implemented`

4.
```haskell
type Subject = String
type Verb = String
type Object = String
data Sentence = Sentence Subject Verb Object deriving (Eq, Show)

s1 = Sentence "dogs" "drool"
s2 = Sentence "Julie" "loves" "dogs"
```

`Sentence` requires 3 `Strings`, s1 is missing the `Object`.

### Given a datatype declaration...

```haskell
data Rocks = Rocks String deriving (Eq, Show)
data Yeah = Yeah Bool deriving (Eq, Show)
data Papu = Papu Rocks Yeah deriving (Eq, Show)
```

1.
```haskell
phew = Papu "chases" True
```
No, missing the constructors for Rocks and Yeah.

2.
```haskell
truth = Papu (Rocks "chomskydoz") (Yeah True)
```
Yes.

3.
```haskell
equalityForall :: Papu -> Papu -> Bool
equalityForall p p' = p == p'
```
Yes. It implements `Eq`.

4.
```haskell
comparePapus :: Papu -> Papu -> Bool
comparePapus p p' = p > p'
```
No, since it doens't implement `Ord`.

## Match the Types

1.
```haskell
i :: Num a => a
i = 1
-- with
i :: a -- works
```
Yes, it accepts, since `a` it's even more generic than `Num a`.

2.
```haskell
f :: Float
f = 1.0
--
f :: Num a => a
```
Yes, it accepts, since `Num a` it's even more generic than `Float`.

3.
```haskell
f :: Float
f = 1.0
--
f :: Fractional a => a
```
Yes, it accepts, since `Fractional a` it's even more generic than `Float`.

4.
```haskell
f :: Float
f = 1.0
--
f :: RealFrac a => a
```
Yes, it accepts, since `RealFrac a` it's even more generic than `Float`.

5.
```haskell
freud :: a -> a
freud x = x
--
freud :: Ord a => a -> a
```
It accepts, but since no operations is performed, Ord a just reduced the scopes.

6.
```haskell
freud':: a -> a
freud' x = x
--
freud' :: Int -> Int
```
It accepts, but since no operations is performed, Int just reduced the scopes.

7.
```haskell
myX = 1 :: Int

sigmund :: Int -> Int
sigmund x = myX
--
sigmund :: a -> a
```
No, since `a -> a` would imply on myX being of any type.

8.
```haskell
myX = 1 :: Int
sigmund' :: Int -> Int
sigmund' x = myX
--
sigmund' :: Num a => a -> a
```
No, since `a -> a` would imply on myX being of any `Num a`, int is .


9.
```haskell
import Data.List

jung :: Ord a => [a] -> a
jung xs = head (sort xs)
--
jung :: [Int] -> Int
```
Yes, but it narrows down to only one type.

10.
```haskell
young :: [Char] -> Char
young xs = head (sort xs)
--
young :: Ord a => [a] -> a
```
Yes, it amplifies the polymorphism of the function.

11.
```haskell
mySort :: [Char] -> [Char]
mySort = sort

signifier :: [Char] -> Char
signifier xs = head (mySort xs)
--
signifier :: Ord a => [a] -> a
```
No, since the `mySort` function already narrowed the scope of the polymorphism down to `[Char]` types.

## Type-Kwon-Do Two: Electric Typealoo

1.
```haskell
chk :: Eq b => (a -> b) -> a -> b -> Bool
chk f x y = (f x) == y
```
e.g.:
```haskell
f x = "something"
chk f 1 "something" -- returns True
```

2.
```haskell
arith :: Num b => (a -> b) -> Integer -> a -> b
arith f i a = (f a) * (fromIntegral i)
```

e.g.:
```haskell
fn x = x + 10
arith fn 10 10 -- returns 200
```
