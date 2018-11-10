type Name = String
type Age = Integer
data Person = Person Name Age deriving Show

data PersonInvalid = NameEmpty | AgeTooLow | PersonInvalidUnknown String deriving (Eq, Show)

mkPerson :: Name -> Age -> Either PersonInvalid Person
mkPerson name age
  | name /= "" && age > 0 = Right $ Person name age
  | name == "" = Left NameEmpty
  | not (age > 0) = Left AgeTooLow
  | otherwise = Left $ PersonInvalidUnknown $ "Name was: " ++ show name ++ " Age was: " ++ show age

gimmePerson :: IO ()
gimmePerson = do
  name <- getLine
  age <- getLine
  case (mkPerson name (read age :: Integer)) of
    Left NameEmpty -> putStrLn "Name can't be empty"
    Left AgeTooLow -> putStrLn "Age can't be smaller than 1"
    Left (PersonInvalidUnknown s) -> putStrLn $ "Unknown error: " ++ show s
    Right (Person n a) -> putStrLn $ "Thanks, " ++ show n ++ " age " ++ show a
