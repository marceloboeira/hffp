-- import Test.Hspec
-- import Test.QuickCheck
-- import Test.QuickCheck.Checkers
-- import Test.QuickCheck.Classes

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

--main = hspec $ do
--  describe "#exercises" $ do
--    it "#ListApplicative" $ do
--      quickBatch (applicative lA)
