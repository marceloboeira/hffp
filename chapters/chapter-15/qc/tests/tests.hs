import Test.QuickCheck
import Test.Hspec

monoidAssoc :: (Eq m, Monoid m) => m -> m -> m -> Bool
monoidAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

monoidLeftId :: (Eq m, Monoid m) => m -> Bool
monoidLeftId a = (mempty <> a) == a

monoidRightId :: (Eq m, Monoid m) => m -> Bool
monoidRightId a = (a <> mempty) == a

main :: IO ()
main = hspec $ do
  describe "#monoid" $ do
    it "#associativity" $ do
      quickCheck (monoidAssoc :: String -> String -> String -> Bool)

    it "#leftIdentity" $ do
      quickCheck (monoidLeftId :: String -> Bool)

    it "#rightIdentity" $ do
      quickCheck (monoidRightId :: String -> Bool)
