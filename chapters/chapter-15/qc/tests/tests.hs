import Test.QuickCheck
import Test.Hspec

monoidAssoc :: (Eq m, Monoid m) => m -> m -> m -> Bool
monoidAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

monoidLeftId :: (Eq m, Monoid m) => m -> Bool
monoidLeftId a = (mempty <> a) == a

monoidRightId :: (Eq m, Monoid m) => m -> Bool
monoidRightId a = (a <> mempty) == a

data Bull = Falls | Thrue deriving (Eq, Show)

instance Arbitrary Bull where
  arbitrary = frequency [ (1, return Falls)
                        , (1, return Thrue)
                        ]

instance Semigroup Bull where
  (<>) _ _ = Falls

instance Monoid Bull where
  mempty = Falls
  mappend = (<>)

data Option a = None | Some a deriving (Eq, Show)

instance Semigroup a => Semigroup (Option a) where
  (<>) None None = None
  (<>) (Some a) None = Some a
  (<>) None (Some b) = Some b
  (<>) (Some a) (Some b) = Some (a <> b)

instance Monoid a => Monoid (Option a) where
  mempty = None
  mappend = (<>)

newtype First' a = First' { getFirst' :: Option a } deriving (Eq, Show)

instance Semigroup a => Semigroup (First' a) where
  (<>) (First' o) (First' o') = First' (o <> o')

instance Monoid a => Monoid (First' a) where
  mempty = First' None
  mappend = (<>)

instance Arbitrary a => Arbitrary (First' a) where
  arbitrary = do
    a <- arbitrary
    oneof [return (First' (Some a)), return (First' None)]

main :: IO ()
main = hspec $ do
  describe "#monoid" $ do
    it "#associativity" $ do
      quickCheck (monoidAssoc :: String -> String -> String -> Bool)

    it "#leftIdentity" $ do
      quickCheck (monoidLeftId :: String -> Bool)

    it "#rightIdentity" $ do
      quickCheck (monoidRightId :: String -> Bool)

  describe "#bull" $ do
    it "#associativity" $ do
      quickCheck (monoidAssoc :: Bull -> Bull -> Bull -> Bool)

    it "#leftIdentity" $ do
      quickCheck (monoidLeftId :: Bull -> Bool)

    it "#rightIdentity" $ do
      quickCheck (monoidRightId :: Bull -> Bool)

  describe "#first" $ do
    it "#associativity" $ do
      quickCheck (monoidAssoc :: First' String -> First' String -> First' String -> Bool)

    it "#leftIdentity" $ do
      quickCheck (monoidLeftId :: First' String -> Bool)

    it "#rightIdentity" $ do
      quickCheck (monoidRightId :: First' String -> Bool)
