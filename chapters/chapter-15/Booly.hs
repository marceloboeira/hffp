data Booly = False' | True' deriving (Eq, Show)

-- Semigroup is a superclass of Monoid since base-4.11.0.0 (April of 2018)
instance Semigroup Booly where
  (<>) False' _ = False'
  (<>) _ False' = False'
  (<>) True' True' = True'

instance Monoid Booly where
  mempty = False'
  mappend = (<>)
