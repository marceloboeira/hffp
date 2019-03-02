data Booly a = False' | True' deriving (Eq, Show)

-- Semigroup is a superclass of Monoid since base-4.11.0.0 (April of 2018)
instance Semigroup a => Semigroup (Booly a) where
  (<>) False' _ = False'
  (<>) _ False' = False'
  (<>) True' True' = True'

instance Monoid a => Monoid (Booly a) where
  mempty = False'
  mappend = (<>)
