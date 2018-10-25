-- Types
type Size = Integer
data Price = Price Integer deriving (Eq, Show)
data Manufacturer = Mini | Mazda | Tata deriving (Eq, Show)
data Airline = PapuAir | CatapultsR'Us | TakeYourChancesUnited deriving (Eq, Show)
data Vehicle = Car Manufacturer Price | Plane Airline Size deriving(Eq, Show)

-- Data
myCar = Car Mini (Price 14000)
urCar = Car Mazda (Price 20000)
clownCar = Car Tata (Price 7000)
doge = Plane PapuAir 100

-- Exercises

-- 1. Vehicle

-- 2.
isCar :: Vehicle -> Bool
isCar (Car _ _) = True
isCar _ = False

isPlane :: Vehicle -> Bool
isPlane (Plane _ _) = True
isPlane _ = False

areCars :: [Vehicle] -> [Bool]
areCars = map (isCar)

-- 3.

getManu :: Vehicle -> Manufacturer
getManu (Car m _) = m


-- 4. Exception: chapters/chapter-11/vehicle.hs:32:1-21: Non-exhaustive patterns in function getManu
--
-- 5. The main changes are related to position and amount of attributes
