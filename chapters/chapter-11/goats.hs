{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances #-}

class TooMany a where
  tooMany :: a -> Bool

instance TooMany Int where
  tooMany n = n > 42

newtype Goats = Goats Int deriving (Eq, Show, TooMany)

-- 1
instance TooMany (Int, String) where
  tooMany (n, _) = n > 42

newtype Boots = Snowboots (Int, String) deriving (Eq, Show, TooMany)

-- 2
-- Has to be commented out since it affect solution 3
--instance TooMany (Int, Int) where
--  tooMany (n, m) = (n+m) > 42

newtype Guitars = Strings (Int, Int) deriving (Eq, Show, TooMany)

-- 3
instance (Num a, TooMany a) => TooMany (a, a) where
  tooMany (n, m) = tooMany (n + m)
