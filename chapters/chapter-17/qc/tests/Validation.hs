import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

data Validation err a = Failure' err | Success' a deriving (Eq, Show)

instance Functor (Validation err) where
  fmap _ (Failure' err) = Failure' err
  fmap f (Success' a) = Success' $ f a

instance Monoid e => Applicative (Validation e) where
  pure = Success'
  (<*>) (Success' f) (Success' v) = Success' (f v)
  (<*>) (Failure' e) (Failure' e') = Failure' (e <> e')
  (<*>) _ (Failure' e) = Failure' e
  (<*>) (Failure' e) _ = Failure' e

instance (Arbitrary e, Arbitrary a) => Arbitrary (Validation e a) where
  arbitrary = do
    a <- arbitrary
    e <- arbitrary
    oneof [return (Failure' e), return (Success' a)]

instance (Eq e, Eq a) => EqProp (Validation e a) where
  (=-=) = eq

main :: IO ()
main = hspec $ do
  describe "#exercises" $ do
    it "#Validation" $ do
      quickBatch $ applicative ((Success' ("a", "b", "c")) :: Validation (String, String, String) (String, String, String))
