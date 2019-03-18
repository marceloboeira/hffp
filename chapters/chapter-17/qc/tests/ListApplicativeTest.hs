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

instance Eq a => EqProp (List a) where
  xs =-= ys = xs' `eq` ys'
    where
      xs' = take' 100 xs
      ys' = take' 100 ys

append :: List a -> List a -> List a
append Nil ys = ys
append (Cons x xs) ys = Cons x $ xs `append` ys

fold :: (a -> b -> b) -> b -> List a -> b
fold _ i Nil = i
fold f i (Cons x xs) = f x (fold f i xs)

concat' :: List (List a) -> List a
concat' = fold append Nil

flatMap :: (a -> List b) -> List a -> List b
flatMap f as = concat' (f <$> as)

take' :: Int -> List a -> List a
take' _ Nil = Nil
take' n (Cons x xs)
  | n <= 0 = Nil
  | otherwise = Cons x (take' (n - 1) xs)

main :: IO ()
main = hspec $ do
  describe "#exercises" $ do
    it "#ListApplicative" $ do
      quickBatch (applicative (Cons ("a", "b", 1 :: Int) Nil))
