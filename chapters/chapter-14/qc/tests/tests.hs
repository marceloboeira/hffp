module WordNumberTest where

import Test.QuickCheck
import Test.QuickCheck.Gen (oneof, frequency)
import Test.Hspec
import WordNumber (digitToWord, digits, wordNumber)
import Data.List (sort)
import Data.Char (chr, toUpper)

-- Functions to test
-- 1
half x = x / 2
halfIdentity = (*2) . half

divisor :: Gen Float
divisor = arbitrary `suchThat` (/= 0)

-- 2
listOrdered :: (Ord a) => [a] -> Bool
listOrdered xs = snd $ foldr go (Nothing, True) xs
  where go _ status@(_, False) = status
        go y (Nothing, t) = (Just y, t)
        go y (Just x, t) = (Just y, x >= y)

genList :: (Arbitrary a, Eq a) => Gen [a]
genList = do
  a <- arbitrary
  b <- arbitrary `suchThat` (/= a)
  c <- arbitrary `suchThat` (`notElem` [a, b])
  return [a, b, c]

-- 3
plusAssociative :: (Eq a, Num a) => a -> a -> a -> Bool
plusAssociative x y z = x + (y + z) == (x + y) + z

plusCommutative :: (Eq a, Num a) => a -> a -> Bool
plusCommutative x y = x + y == y + x

-- 4
multiplicationAssociative :: (Eq a, Num a) => a -> a -> a -> Bool
multiplicationAssociative x y z = (x * y) * z == x * (y * z)

multiplicationCommutative :: (Eq a, Num a) => a -> a  -> Bool
multiplicationCommutative x y = x * y == y * x

-- 5
quotrem :: Integer -> Integer -> Bool
quotrem x y = (quot x y) * y + (rem x y) == x

divmod :: Integer -> Integer -> Bool
divmod x y = (div x y) * y + (mod x y) == x

nonZeroInteger :: Gen Integer
nonZeroInteger = arbitrary `suchThat` (> 0)

-- 6
powerAssociative :: (Eq a, Integral a) => a -> a -> a -> Bool
powerAssociative x y z = (x ^ y) ^ z == x ^ (y ^ z)

powerCommutative :: (Eq a, Integral a) => a -> a -> Bool
powerCommutative x y = (x ^ y) == (y ^ x)

-- 7
reverseIdentity :: (Eq a) => [a] -> Bool
reverseIdentity x = (reverse . reverse) x == id x

-- 8
dollarCombinator :: Eq b => (a -> b) -> a -> Bool
dollarCombinator f a = ($) f a == f a

dotCombinatorAssociative :: (Int -> Int) -> (Int -> Int) -> (Int -> Int) -> Int -> Bool
dotCombinatorAssociative f g h x = ((f . g) . h) x == (f . (g . h)) x

-- 9 (down there)

-- 10
takeLength n xs = length (take n xs) == n

-- 11
readShowIdentity x = (read (show x)) == x

-- Idempotence
twice f = f . f
fourTimes = twice . twice

capitalizeWord :: String -> String
capitalizeWord [] = []
capitalizeWord (x:xs) = (toUpper x) : xs

-- Generators
data Fool = Foolse | Frooe deriving (Eq, Show)
data Fool' = Foolse' | Frooe' deriving (Eq, Show)

instance Arbitrary Fool where
  arbitrary = do
    oneof [return $ Foolse, return $ Frooe]

instance Arbitrary Fool' where
  arbitrary =
    frequency [(2, return $ Foolse'), (1, return $ Frooe')]

main :: IO ()
main = hspec $ do
  describe "digitToWord" $ do
    it "returns zero for 0" $ do
      digitToWord 0 `shouldBe` "zero"
    it "returns one for 1" $ do
      digitToWord 1 `shouldBe` "one"
    it "returns one for 2" $ do
      digitToWord 2 `shouldBe` "two"
    it "returns one for 3" $ do
      digitToWord 3 `shouldBe` "three"
    it "returns one for 4" $ do
      digitToWord 4 `shouldBe` "four"
    it "returns one for 5" $ do
      digitToWord 5 `shouldBe` "five"
    it "returns one for 6" $ do
      digitToWord 6 `shouldBe` "six"
    it "returns one for 7" $ do
      digitToWord 7 `shouldBe` "seven"
    it "returns one for 8" $ do
      digitToWord 8 `shouldBe` "eight"
    it "returns one for 9" $ do
      digitToWord 9 `shouldBe` "nine"
  describe "digits" $ do
    it "returns [1] for 1" $ do
      digits 1 `shouldBe` [1]
    it "returns [1, 0, 0] for 100" $ do
      digits 100 `shouldBe` [1, 0, 0]
    it "returns [1, 0, 1] for 101" $ do
      digits 100 `shouldBe` [1, 0, 0]
    it "returns [1, 1, 8, 2, 7, 3, 1] for 1182731" $ do
      digits 1182731 `shouldBe` [1, 1, 8, 2, 7, 3, 1]
  describe "wordNumber" $ do
    it "one-zero-zero given 100" $ do
      wordNumber 100 `shouldBe` "one-zero-zero"
    it "nine-zero-zero-one for 9001" $ do
      wordNumber 9001 `shouldBe` "nine-zero-zero-one"
    it "seven-seven-seven for 777" $ do
      wordNumber 777 `shouldBe` "seven-seven-seven"

    describe "Exercises" $ do
      -- 1
      it "#half" $ do
        forAll divisor (\x -> (half x) * 2 == x)
      it "#halfIdentity" $ do
        forAll divisor (\x -> (halfIdentity x) == x)

      -- 2
      it "#listOrdered" $ do
        forAll (genList :: Gen [Int]) (\x -> listOrdered $ sort x)
      it "#listOrdered Unsorted" $ do
        forAll (genList :: Gen [Int]) (\x -> (not $ listOrdered x) || (sort x == x))

      -- 3
      it "#sumCommutative" $ do
        forAll (arbitrary :: Gen Int) plusCommutative
      it "#sumAssociative" $ do
        forAll (arbitrary :: Gen Int) plusAssociative

      -- 4
      it "#multiplicationCommutative" $ do
        forAll (arbitrary :: Gen Int) multiplicationCommutative
      it "#multiplicationAssociative" $ do
        forAll (arbitrary :: Gen Int) multiplicationAssociative

      -- 5
      it "#quotrem" $ do
        forAll nonZeroInteger $ \x ->
          forAll nonZeroInteger $ \y -> (quotrem x y)
      it "#divmod" $ do
        forAll nonZeroInteger $ \x ->
          forAll nonZeroInteger $ \x y -> (divmod x y)

      -- 6
      -- Fails since it's not Associative
      it "#powerAssociative" $ do
        forAll (arbitrary `suchThat` (> 0) :: Gen Int) $ \x y z -> powerAssociative x y z
      -- Fails since it's not Commutative
      it "#powerCommutative" $ do
        forAll (arbitrary `suchThat` (> 0) :: Gen Int) $ \x y -> powerCommutative x y

      -- 7
      it "#reverseIdentity" $ do
        forAll (genList :: Gen [Int]) reverseIdentity

      -- 8
      it "#dollarCombinator" $ do
        forAll (arbitrary `suchThat` (> 0) :: Gen Int) $ \x -> dollarCombinator chr x
      it "#dotCombinatorAssociative" $ do
        forAll (arbitrary :: Gen Int) $ \f g h x -> dotCombinatorAssociative (+f) (+g) (+h) x

      -- 9
      it "#foldOr++" $ do
        forAll (arbitrary :: Gen [Int]) $ \x y -> (foldr (:)) x y == ((++) y x)
      it "#foldOrConcat" $ do
        forAll (arbitrary :: Gen [[Int]]) $ \x -> foldr (++) [] x == concat x

      -- 10
      it "#takeLength" $ do
        forAll (genList :: Gen [Int]) $ \x ->
          forAll (arbitrary `suchThat` (\x -> x > 0 && x < 3) :: Gen Int) $ \y -> takeLength y x

      -- 11
      it "#readShowIdentity" $ do
        forAll (arbitrary :: Gen [Char]) readShowIdentity

      -- Idempotence
      it "#twice" $ do
        forAll (arbitrary :: Gen [Char]) $ \x ->
          (capitalizeWord x == twice capitalizeWord x) && (capitalizeWord x == fourTimes capitalizeWord x)
      it "#fourTimes" $ do
        forAll (arbitrary :: Gen [Char]) $ \x ->
          (sort x == twice sort x) && (sort x == fourTimes sort x)

      -- Fool
      it "#Fool" $ do
        forAll (arbitrary :: Gen Fool) $ \x -> x == Frooe || x == Foolse
      it "#Fool'" $ do
        forAll (arbitrary :: Gen Fool') $ \x -> x == Frooe' || x == Foolse'
