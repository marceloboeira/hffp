module Addition where

import Test.Hspec
import Test.QuickCheck

sayHello :: IO ()
sayHello = putStrLn "hello!"

dividedBy :: Integral a => a -> a -> (a, a)
dividedBy num denom = go num denom 0
  where go n d count
          | n < d = (count, n)
          | otherwise = go (n - d) d (count + 1)


multWithSum :: (Ord a, Num a, Eq a) => a -> a -> a
multWithSum x y = go 0 y x
  where go result by inc
         | inc == 0 = result
         | otherwise = go (result + by) by (inc - 1)

trivialInt :: Gen Int
trivialInt = return 1

oneThroughThree :: Gen Int
oneThroughThree = elements [1,2,3]

main :: IO ()
main = hspec $ do
  describe "Addition" $ do
    it "1 + 1 is greater than 1" $ do
      (1 + 1) > 1 `shouldBe` True
    it "2 + 2 is equal to 4" $ do
      (2 + 2) `shouldBe` 4
  describe "dividedBy" $ do
    it "15 divided by 3 is 5" $ do
      (dividedBy 15 3) `shouldBe` (5, 0)
    it "22 divided by is 4 reminder 2" $ do
      (dividedBy 22 4) `shouldBe` (5, 2)
  describe "multWithSum" $ do
    it "1 * 1 equals to 1" $ do
      (multWithSum 1 1) `shouldBe` 1
    it "1 * 2 equals to 2" $ do
      (multWithSum 1 2) `shouldBe` 2
    it "2 * 1 equals to 2" $ do
      (multWithSum 2 1) `shouldBe` 2
    it "x + 1 is always greater than x" $ do
      property $ \x -> x + 1 > (x :: Int)
