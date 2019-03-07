import Test.QuickCheck
import Test.QuickCheck.Gen.Unsafe
import Test.Hspec

functorIdentity :: (Functor f, Eq (f a)) => f a -> Bool
functorIdentity f = fmap id f == f

functorCompose :: (Functor f, Eq (f c)) => (a -> b) -> (b -> c) -> f a -> Bool
functorCompose f g x = (fmap g (fmap f x)) == (fmap (g . f) x)

-- 1
newtype Identity a = Identity a deriving (Eq, Show)

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = do
    i <- arbitrary
    return (Identity i)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

-- 2
data Pair a = Pair a a deriving (Eq, Show)

instance (Arbitrary a) => Arbitrary (Pair a) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    return (Pair i j)

instance Functor Pair where
  fmap f (Pair a b) = Pair (f a) (f b)

-- 3
data Two a b = Two a b deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    return (Two i j)

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

-- 4
data Three a b c = Three a b c deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    k <- arbitrary
    return (Three i j k)

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

-- 5
data Three' a b = Three' a b b deriving (Eq, Show)

instance Functor (Three' a) where
  fmap f (Three' a b b') = Three' a (f b) (f b')

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    k <- arbitrary
    return (Three' i j k)

-- 6
data Four a b c d = Four a b c d deriving (Eq, Show)

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    k <- arbitrary
    l <- arbitrary
    return (Four i j k l)

-- 7
data Four' a b = Four' a a a b deriving (Eq, Show)

instance Functor (Four' a) where
  fmap f (Four' a a2 a3 b) = Four' a a2 a3 (f b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
  arbitrary = do
    i <- arbitrary
    j <- arbitrary
    k <- arbitrary
    l <- arbitrary
    return (Four' i j k l)

-- 8
data Trivial = Trivial
-- Not possible to implement functor since there is no structure, only a value (can't unwrap/wrap). The kind is * rather than * -> *
-- e.g.:
-- Prelude> :k Trivial
-- Trivial :: *

data Trivial' a = Trivial' a
-- Whereas, Trivial' a, for instance, has a wraped, being then kind * -> *
-- e.g.:
-- Prelude> :k Trivial'
-- Trivial' :: * -> *

main :: IO ()
main = hspec $ do
  describe "#exercises" $ do
    describe "#example" $ do
      it "#identity" $ do
        quickCheck (functorIdentity :: String -> Bool)
      it "#composability" $ do
        quickCheck ((functorCompose (*2) (+5)) :: [Int] -> Bool)

    describe "#exercise-1-identity" $ do
      it "#identity" $ do
        quickCheck (functorIdentity :: Identity Int -> Bool)
      it "#composability" $ do
        quickCheck ((functorCompose (*2) (+5)) :: Identity Int -> Bool)

    describe "#exercise-2-pair-a-a" $ do
      it "#identity" $ do
        quickCheck (functorIdentity :: Pair Int -> Bool)
      it "#composability" $ do
        quickCheck ((functorCompose (*2) (+5)) :: Pair Int -> Bool)

    describe "#exercise-3-two-a-b" $ do
      it "#identity" $ do
        quickCheck (functorIdentity :: Two Int Int -> Bool)
      it "#composability" $ do
        quickCheck ((functorCompose (*2) (+5)) :: Two Int Int -> Bool)

    describe "#exercise-4-three-a-b-c" $ do
      it "#identity" $ do
        quickCheck (functorIdentity :: Three Int Int Int -> Bool)
      it "#composability" $ do
        quickCheck ((functorCompose (*2) (+5)) :: Three Int Int Int -> Bool)

    describe "#exercise-5-three'-a-b-b" $ do
      it "#identity" $ do
        quickCheck (functorIdentity :: Three' Int Int -> Bool)
      it "#composability" $ do
        quickCheck ((functorCompose (*2) (+5)) :: Three' Int Int -> Bool)

    describe "#exercise-6-four-a-b-c-d" $ do
      it "#identity" $ do
        quickCheck (functorIdentity :: Four Int Int Int Int -> Bool)
      it "#composability" $ do
        quickCheck ((functorCompose (*2) (+5)) :: Four Int Int Int Int -> Bool)

    describe "#exercise-7-four'-a-a-a-b" $ do
      it "#identity" $ do
        quickCheck (functorIdentity :: Four' Int Int -> Bool)
      it "#composability" $ do
        quickCheck ((functorCompose (*2) (+5)) :: Four' Int Int -> Bool)
