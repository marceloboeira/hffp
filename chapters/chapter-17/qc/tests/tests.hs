import Test.QuickCheck
import Test.QuickCheck.Checkers
import Test.QuickCheck.Classes
import Test.Hspec
import Data.Monoid
import Control.Applicative

-- 1
data Bull = Fools | Twoo deriving (Eq, Show)

instance Arbitrary Bull where
  arbitrary = frequency [ (1, return Fools) , (1, return Twoo) ]

instance Semigroup Bull where
  (<>) _ _ = Fools

instance Monoid Bull where
  mempty = Fools
  mappend = (<>)

instance EqProp Bull where
  (=-=) = eq

type SSI = (String, String, Int)
trigger :: [SSI]
trigger = undefined

main :: IO ()
main = hspec $ do
  describe "#exercises" $ do
    it "#bad-monoid" $ do
      quickBatch (monoid Twoo)
    it "#applicative" $ do
      quickBatch $ applicative [("b", "w", 1 :: Int)]
    it "#applicative-undefined" $ do
      quickBatch $ applicative trigger
