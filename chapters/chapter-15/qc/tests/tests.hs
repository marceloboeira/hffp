import Test.QuickCheck
import Test.QuickCheck.Gen.Unsafe
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

-- Chapter Exercises
-- Semigroup Exercises
-- 1.
semigroupAssoc :: (Eq s, Semigroup s) => s -> s -> s -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
  (<>) _ _ = Trivial

instance Arbitrary Trivial where
  arbitrary = return Trivial

-- 2.
newtype Identity a = Identity a deriving (Eq, Show)

instance Semigroup a => Semigroup (Identity a) where
  (<>) (Identity i) (Identity i') = Identity (i <> i')

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    i <- arbitrary
    return (Identity i)

-- 3.
data Two a b = Two a b deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
  (<>) (Two a' b') (Two a'' b'') = Two (a' <> a'') (b' <> b'')

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    return (Two i j)

-- 4.
data Three a b c = Three a b c deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c) => Semigroup (Three a b c) where
  (<>) (Three a' b' c') (Three a'' b'' c'') = Three (a' <> a'') (b' <> b'') (c' <> c'')

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    k <- arbitrary
    return (Three i j k)

-- 5.
data Four a b c d = Four a b c d deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c, Semigroup d) => Semigroup (Four a b c d) where
  (<>) (Four a' b' c' d') (Four a'' b'' c'' d'') = Four (a' <> a'') (b' <> b'') (c' <> c'') (d' <> d'')

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    k <- arbitrary
    l <- arbitrary
    return (Four i j k l)

-- 6.
newtype BoolConj = BoolConj Bool deriving (Eq, Show)

instance Semigroup BoolConj where
  (<>) (BoolConj True) (BoolConj True) = BoolConj True
  (<>) (BoolConj _) (BoolConj _) = BoolConj False

instance Arbitrary BoolConj where
  arbitrary = frequency [ (1, return (BoolConj True))
                        , (1, return (BoolConj False))
                        ]

-- 7.
newtype BoolDisj = BoolDisj Bool deriving (Eq, Show)

instance Semigroup BoolDisj where
  (<>) (BoolDisj False) (BoolDisj False) = BoolDisj False
  (<>) (BoolDisj _) (BoolDisj _) = BoolDisj True

instance Arbitrary BoolDisj where
  arbitrary = frequency [ (1, return (BoolDisj True))
                        , (1, return (BoolDisj False))
                        ]

-- 8.
data Or a b = Fst a | Snd b deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Or a b) where
  (<>) (Snd i) _ = Snd i
  (<>) (Fst _) (Snd i) = Snd i
  (<>) _ (Fst i) = Fst i

instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    frequency [ (1, return (Fst i))
              , (1, return (Snd j))
              ]
-- 9.
newtype Combine a b = Combine { unCombine :: (a -> b) }

instance (Show a, Show b) => Show (Combine a b) where
  show _ = "Combine"

instance (Semigroup a, Semigroup b) => Semigroup (Combine a b) where
  (<>) (Combine f) (Combine f') = Combine (\i -> (f i) <> (f' i))

instance (CoArbitrary a, Arbitrary b) => Arbitrary (Combine a b) where
  arbitrary = fmap Combine $ promote (\n -> coarbitrary n arbitrary)

combineAssoc :: (Combine String String) -> (Combine String String) -> (Combine String String) -> String -> Bool
combineAssoc a b c s = (unCombine (a <> (b <> c)) s) == (unCombine ((a <> b) <> c) s)

-- 10.
newtype Comp a = Comp { unComp :: (a -> a) }

instance (Show a) => Show (Comp a) where
  show _ = "Comp"

instance (Semigroup a) => Semigroup (Comp a) where
  (<>) (Comp f) (Comp f') = Comp (f . f')

instance (CoArbitrary a, Arbitrary a) => Arbitrary (Comp a) where
  arbitrary = fmap Comp $ promote (\n -> coarbitrary n arbitrary)

compAssoc :: (Comp String) -> (Comp String) -> (Comp String) -> String -> Bool
compAssoc a b c s = (unComp (a <> (b <> c)) s) == (unComp ((a <> b) <> c) s)

-- 11.
data Validation a b = Failure' a | Success' b deriving (Eq, Show)

instance (Semigroup a) => Semigroup (Validation a b) where
  (<>) (Failure' s) (Failure' s') = Failure' (s <> s')
  (<>) (Success' s) (_) = Success' s
  (<>) (_) (Success' s) = Success' s

instance (Arbitrary a, Arbitrary b) => Arbitrary (Validation a b) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    frequency [ (1, return (Success' i))
              , (1, return (Failure' j))
              ]

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

  -- Chapter Exercises
  describe "#semigroup" $ do
    describe "#1-trivial" $ do
      it "#associativity" $ do
        quickCheck (semigroupAssoc :: Trivial -> Trivial -> Trivial -> Bool)
    describe "#2-identity" $ do
      it "#associativity" $ do
        quickCheck (semigroupAssoc :: Identity String -> Identity String -> Identity String -> Bool)
    describe "#3-two" $ do
      it "#associativity" $ do
        quickCheck (semigroupAssoc :: Two String String -> Two String String -> Two String String -> Bool)
    describe "#4-three" $ do
      it "#associativity" $ do
        quickCheck (semigroupAssoc :: Three String String String -> Three String String String -> Three String String String -> Bool)
    describe "#5-four" $ do
      it "#associativity" $ do
        quickCheck (semigroupAssoc :: Four String String String String -> Four String String String String -> Four String String String String -> Bool)
    describe "#6-bool-conj" $ do
      it "#associativity" $ do
        quickCheck (semigroupAssoc :: BoolConj -> BoolConj -> BoolConj -> Bool)
    describe "#7-bool-disj" $ do
      it "#associativity" $ do
        quickCheck (semigroupAssoc :: BoolDisj -> BoolDisj -> BoolDisj -> Bool)
    describe "#8-or" $ do
      it "#associativity" $ do
        quickCheck (semigroupAssoc :: Or String String -> Or String String -> Or String String -> Bool)
    describe "#9-combine" $ do
      it "#associativity" $ do
        quickCheck (combineAssoc)
    describe "#10-comp" $ do
      it "#associativity" $ do
        quickCheck (compAssoc)
    describe "#11-validation" $ do
      it "#associativity" $ do
        quickCheck (semigroupAssoc :: Validation String Int -> Validation String Int -> Validation String Int -> Bool)
