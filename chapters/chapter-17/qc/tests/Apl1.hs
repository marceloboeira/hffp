import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

instance Semigroup a => Semigroup (ZipList a) where
  (<>) = liftA2 (<>)

instance Monoid a => Monoid (ZipList a) where
  mempty = pure mempty -- ZipList []
  mappend = (<>)

instance Eq a => EqProp (ZipList a) where
  (=-=) = eq

main :: IO ()
main = hspec $ do
  describe "#exercises" $ do
    it "#zipList monoid" $ do
      quickBatch $ monoid $ ZipList [1 :: Sum Int]
