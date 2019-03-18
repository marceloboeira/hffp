import Test.Hspec
import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes

data List a = Nil | Cons a (List a) deriving (Eq, Show)

instance Semigroup (List a) where
  (<>) Nil x = x
  (<>) x Nil = x
  (<>) (Cons x xs) ys = Cons x (xs <> ys)

instance Monoid (List a) where
  mempty = Nil
  mappend = (<>)

instance Functor List where
  fmap _ Nil = Nil
  fmap f (Cons a l) = Cons (f a) (fmap f l)

instance Applicative List where
  pure x = Cons x Nil
  (<*>) Nil _ = Nil
  (<*>) _ Nil = Nil
  (<*>) (Cons f lf) v = (f <$> v) <> (lf <*> v)

instance Arbitrary a => Arbitrary (List a) where
  arbitrary = Cons <$> arbitrary <*> arbitrary

take' :: Int -> List a -> List a
take' _ Nil = Nil
take' n (Cons x xs)
  | n <= 0 = Nil
  | otherwise = Cons x (take' (n - 1) xs)

newtype ZipList' a = ZipList' (List a) deriving (Eq, Show)

instance Eq a => EqProp (ZipList' a) where
  xs =-= ys = xs' `eq` ys'
    where xs' = let (ZipList' l) = xs in take' 3000 l
          ys' = let (ZipList' l) = ys in take' 3000 l

instance Semigroup (ZipList' a) where
  (<>) (ZipList' x) (ZipList' y) = ZipList' (x <> y)

instance Functor ZipList' where
  fmap f (ZipList' xs) = ZipList' $ fmap f xs

instance Applicative ZipList' where
  pure x = ZipList' (Cons x Nil)
  (<*>) (ZipList' Nil) _ = ZipList' Nil
  (<*>) _ (ZipList' Nil) = ZipList' Nil
  (<*>) (ZipList' (Cons f fs)) (ZipList' (Cons v vs)) = ZipList' (Cons (f v) Nil) <> ((ZipList' fs) <*> (ZipList' vs))

instance Arbitrary a => Arbitrary (ZipList' a) where
  arbitrary = ZipList' <$> arbitrary

main :: IO ()
main = hspec $ do
  describe "#exercises" $ do
    it "#ZipListApplicative" $ do
      quickBatch $ applicative (ZipList' (Cons ("a", "b", 1 :: Int) Nil))
