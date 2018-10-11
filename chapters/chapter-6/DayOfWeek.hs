data DayOfWeek = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday deriving Show

data Date = Date DayOfWeek Int deriving Show

instance Eq DayOfWeek where
  (==) Monday Monday = True
  (==) Tuesday Tuesday = True
  (==) Wednesday Wednesday = True
  (==) Thursday Thursday = True
  (==) Friday Friday = True
  (==) Saturday Saturday = True
  (==) Sunday Sunday = True
  (==) _ _ = False

instance Eq Date where
  (==) (Date weekday dayOfMonth) (Date weekday' dayOfMonth') =
    weekday == weekday' && dayOfMonth == dayOfMonth'
