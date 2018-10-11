-- 1.
data TisAnInteger = TisAn Integer

instance Eq TisAnInteger where
  (==) (TisAn x) (TisAn y) = x == y

-- 2.
data TwoIntegers = Two Integer Integer

instance Eq TwoIntegers where
  (==) (Two x y) (Two x' y') = x == x' && y == y'

-- 3.
data StringOrInt = TisAnInt Int | TisAString String

instance Eq StringOrInt where
  (==) (TisAnInt x) (TisAnInt x') = x == x'
  (==) (TisAString s) (TisAString s') = s == s'
  (==) _ _ = False

-- 4.
data Pair a = Pair a a

instance Eq a => Eq (Pair a) where
  (==) (Pair va vb) (Pair va' vb') = va == va' && vb == vb'

-- 5.
data Tuple a b = Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
  (==) (Tuple va vb) (Tuple va' vb') = va == va' && vb == vb'

-- 6.
data Which a = ThisOne a | ThatOne a

instance (Eq a) => Eq (Which a) where
  (==) (ThisOne v) (ThisOne v') = v == v'
  (==) (ThatOne v) (ThatOne v') = v == v'
  (==) _ _ = False

-- 7.
data EitherOr a b = Hello a | Goodbye b

instance (Eq a, Eq b) => Eq (EitherOr a b) where
  (==) (Hello v) (Hello v') = v == v'
  (==) (Goodbye v) (Goodbye v') = v == v'
  (==) _ _ = False
