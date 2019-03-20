import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes
import Control.Applicative (liftA3)

-- First Batch
-- 1.
lP :: a -> [a]
lP = pure

lA :: [(a -> b)] -> [a] -> [b]
lA = (<*>)

-- 2.
ioP :: a -> IO a
ioP = pure

ioA :: IO (a -> b) -> IO a -> IO b
ioA = (<*>)

-- 3.
tP :: (Monoid a, Monoid c) => a -> (c, a)
tP = pure

tA :: (Monoid a, Monoid c) => (c, (a -> b)) -> (c, a) -> (c, b)
tA = (<*>)

-- 4.
fP :: a -> (f -> a)
fP = pure

fA :: (f -> (a -> b)) -> (f -> a) -> (f -> b)
fA = (<*>)

-- Second Batch

-- 1.
data Pair a = Pair a a deriving (Eq, Show)

instance Functor Pair where
  fmap f (Pair v v') = Pair (f v) (f v')

instance Applicative Pair where
  pure v = Pair v v
  (<*>) (Pair f f') (Pair v v') = Pair (f v) (f' v')

instance (Eq a) => EqProp (Pair a) where
  (=-=) = eq

instance Arbitrary a => Arbitrary (Pair a) where
  arbitrary = do
    a <- arbitrary
    a' <- arbitrary
    return (Pair a a')

-- 2.
data Two a b = Two a b deriving (Eq, Show)

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

-- need a monoid because of the mempty / combine a and a'
instance Monoid a => Applicative (Two a) where
  pure x = Two mempty x
  (<*>) (Two a f) (Two a' b) = Two (a <> a') (f b)

instance (Eq a, Eq b) => EqProp (Two a b) where
  (=-=) = eq

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)

-- 3.
data Three a b c = Three a b c deriving (Eq, Show)

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

instance (Monoid a, Monoid b) => Applicative (Three a b) where
  pure x = Three mempty mempty x
  (<*>) (Three a b f) (Three a' b' v) = Three (a <> a') (b <> b') (f v)

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where
  (=-=) = eq

instance (Arbitrary a, Arbitrary b, Arbitrary c) => Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

-- 4.
data Three' a b = Three' a b b deriving (Eq, Show)

instance Functor (Three' a) where
  fmap f (Three' a b b') = Three' a (f b) (f b')

instance (Monoid a) => Applicative (Three' a) where
  pure x = Three' mempty x x
  (<*>) (Three' a f f') (Three' a' v v') = Three' (a <> a') (f v) (f' v')

instance (Eq a, Eq b) => EqProp (Three' a b) where
  (=-=) = eq

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three' a b c)

-- 5.
data Four a b c d = Four a b c d deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) =>
  Arbitrary (Four a b c d) where
    arbitrary = do
      a <- arbitrary
      b <- arbitrary
      c <- arbitrary
      d <- arbitrary
      return (Four a b c d)

instance Functor (Four a b c) where
  fmap f (Four a b c d) = Four a b c (f d)

instance (Monoid a, Monoid b, Monoid c) => Applicative (Four a b c) where
  pure x = Four mempty mempty mempty x
  (<*>) (Four a b c f) (Four a' b' c' v) = Four (a <> a') (b <> b') (c <> c') (f v)

instance (Eq a, Eq b, Eq c, Eq d) => EqProp (Four a b c d) where
  (=-=) = eq

-- 6.
data Four' a b = Four' a a a b deriving (Eq, Show)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Four' a b) where
    arbitrary = do
      a <- arbitrary
      a' <- arbitrary
      a'' <- arbitrary
      b <- arbitrary
      return (Four' a a' a'' b)

instance Functor (Four' a) where
  fmap f (Four' a a' a'' b) = Four' a a' a'' (f b)

instance (Monoid a) => Applicative (Four' a) where
  pure x = Four' mempty mempty mempty x
  (<*>) (Four' a b c d) (Four' e f g h) = Four' (a <> e) (b <> f) (c <> g) (d h)

instance (Eq a, Eq b) => EqProp (Four' a b) where
  (=-=) = eq

stops :: String
stops = "pbtdkg"

vowels :: String
vowels = "aeiou"

combos :: [a] -> [b] -> [c] -> [(a, b, c)]
combos = liftA3 (,,)

main = hspec $ do
  describe "#exercises" $ do
    it "#pair-a-a" $ do
      quickBatch $ applicative (Pair ("a", "b", "c") ("a", "b", "c"))
    it "#two-a-b" $ do
      quickBatch $ applicative (Two ("a", "b", "c") ("a", "b", "c"))
    it "#three-a-b-c" $ do
      quickBatch $ applicative (Three ("a", "b", "c") ("a", "b", "c") ("a", "b", "c"))
    it "#three'-a-b-b" $ do
      quickBatch $ applicative (Three' ("a", "b", "c") ("a", "b", "c") ("a", "b", "c"))
    it "#four-a-b-c-d" $ do
      quickBatch $ applicative (Four ("a", "b", "c") ("a", "b", "c") ("a", "b", "c") ("a", "b", "c"))
    it "#four'-a-a-a-b" $ do
      quickBatch $ applicative (Four' ("a", "b", "c") ("a", "b", "c") ("a", "b", "c") ("a", "b", "c"))
