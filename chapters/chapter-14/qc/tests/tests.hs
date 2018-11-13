module WordNumberTest where

import Test.Hspec
import WordNumber (digitToWord, digits, wordNumber)

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
