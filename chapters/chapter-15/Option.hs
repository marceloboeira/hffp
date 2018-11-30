data Option a = None | Some a deriving (Eq, Show)

-- Semigroup is a superclass of Monoid since base-4.11.0.0 (April of 2018)
instance Semigroup a => Semigroup (Option a) where
  (<>) None None = None
  (<>) (Some a) None = Some a
  (<>) None (Some b) = Some b
  (<>) (Some a) (Some b) = Some (a <> b)

instance Monoid a => Monoid (Option a) where
  mempty = None
  mappend = (<>)
