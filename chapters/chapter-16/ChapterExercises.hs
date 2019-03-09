{-# LANGUAGE FlexibleInstances #-}
import Data.Array

-- Write a Functor
-- 1.
data Bool = False | True deriving (Eq, Show)
-- No functor to map on, same case as "Trivial"

-- 2.
data BoolAndSomethingElse a = False' a | True' a deriving (Eq, Show)

instance Functor BoolAndSomethingElse where
  fmap f (False' a) = False' $ f a
  fmap f (True' a) = True' $ f a

-- 3.
data BoolAndMaybeSomethingElse a = Falsish | Truish a deriving (Eq, Show)

instance Functor BoolAndMaybeSomethingElse where
  fmap _ Falsish = Falsish
  fmap f (Truish a) = Truish $ f a

--4.
newtype Mu f = InF { outF :: f (Mu f) }
-- :k Mu = (* -> *) -> * - not sure what to do

--5.
data D = D (Array Word Word) Int Int
-- :k D = *  rather than (* -> *)


------------------------------------------------------

-- Rearrange
-- 1.

-- data Sum a b = First a | Second b
data Sum b a = First a | Second b

instance Functor (Sum e) where
  fmap f (First a) = First (f a)
  fmap _ (Second b) = Second b

-- 2.
-- data Company a b c = DeepBlue a c | Something b
data Company a c b = DeepBlue a c | Something b

instance Functor (Company a c) where
  fmap f (Something b) = Something (f b)
  fmap _ (DeepBlue a c) = DeepBlue a c

-- 3.

-- data More a b = L a b a | R b a b deriving (Eq, Show)
data More b a = L a b a | R b a b deriving (Eq, Show)

instance Functor (More b) where
  fmap f (L a b a') = L (f a) b (f a')
  fmap f (R b a b') = R b (f a) b'


------------------------------------------------------

-- Write Functor

-- 1.
data Quant a b = Finance | Desk a | Bloor b  deriving (Eq, Show)

instance Functor (Quant a) where
  fmap _ (Finance) = Finance
  fmap _ (Desk a) = Desk a
  fmap f (Bloor b) = Bloor $ f b

-- 2.
data K a b = K a deriving(Eq, Show)

instance Functor (K a) where
  fmap _ (K a) = K a

-- 3.
newtype Flip f a b = Flip (f b a) deriving (Eq, Show)

instance Functor (Flip K a) where
  fmap f (Flip (K a)) = (Flip (K (f a)))

-- 4.
data EvilGoateeConst a b = GoatyConst b deriving (Eq, Show)

instance Functor (EvilGoateeConst a) where
  fmap f (GoatyConst b) = GoatyConst $ f b

-- 5.
data LiftItOut f a = LiftItOut (f a) deriving (Eq, Show)

instance Functor f => Functor (LiftItOut f) where
  fmap f (LiftItOut (fa)) = LiftItOut (fmap f (fa))

-- 6.
data Parappa f g a = DaWrappa (f a) (g a) deriving (Eq, Show)

instance (Functor f, Functor g) => Functor (Parappa f g) where
  fmap f (DaWrappa fa ga) = DaWrappa (fmap f fa) (fmap f ga)

-- 7.
data IgnoreOne f g a b = IgnoringSomething (f a) (g b)

instance (Functor g) => Functor (IgnoreOne f g a) where
  fmap f (IgnoringSomething fa gb) = IgnoringSomething fa (fmap f gb)

-- 8.
data Notorious g o a t = Notorious (g o) (g a) (g t)

instance (Functor g) => Functor (Notorious g o a) where
  fmap f (Notorious go ga gt) = Notorious go ga (fmap f gt)

-- 9.
data List a = Nil | Cons a (List a)

instance Functor List where
  fmap f Nil = Nil
  fmap f (Cons a l) = Cons (f a) (fmap f l)

-- 10.
data GoatLord a = NoGoat
                | OneGoat a
                | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)

instance Functor GoatLord where
  fmap _ NoGoat = NoGoat
  fmap f (OneGoat a) = OneGoat (f a)
  fmap f (MoreGoats ga ga' ga'') = MoreGoats (fmap f ga) (fmap f ga') (fmap f ga'')

-- 11.
data TalkToMe a = Halt | Print String a | Read (String -> a)

instance Functor TalkToMe where
  fmap _ Halt = Halt
  fmap f (Print s a) = Print s (f a)
  fmap f (Read g) = Read (f . g)
