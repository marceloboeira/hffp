import Data.List (elemIndex)

type Digit = Char

--
-- validButtons = "1234567890*#"
data Button = Digit

-- Valid presses: 1 and up
type Presses = Int
type Buttons = [Button]

data Phone = Phone Buttons

standardPhone :: Phone
standardPhone = Phone
  [ Button '1' "1",
    Button '2' "abc2",
    Button '3' "def3",
    Button '4' "ghi4",
    Button '5' "jkl5",
    Button '6' "mno6",
    Button '7' "pqrs7",
    Button '8' "tuv8",
    Button '9' "wxyz9",
    Button '*' "",
    Button '0' " 0",
    Button '#' "." ]

convo :: [String] convo =
       ["Wanna play 20 questions",
        "Ya",
        "U 1st haha",
        "Lol ok. Have u ever tasted alcohol",
        "Lol ya",
        "Wow ur cool haha. Ur turn",
        "Ok. Do u think I am pretty Lol",
        "Lol ya",
        "Just making sure rofl ur turn"]

reverseTaps :: Phone -> Char -> [(Digit, Presses)]
reverseTaps (Phone buttons) char = 
  find ( ) buttons
-- assuming the default phone definition
-- 'a' -> [('2', 1)]
-- 'A' -> [('*', 1), ('2', 1)]

buttonToPresses :: Button -> Char -> Maybe Presses
buttonToPresses (Button _ alphabet) char =
  case elem char alphabet of
    True -> elemIndex char alphabet
    False -> Nothing


-- cellPhonesDead :: DaPhone -> String -> [(Digit, Presses)]
-- cellPhonesDead = undefined

-- 3
fingerTaps :: [(Digit, Presses)] -> Presses
fingerTaps = undefined

-- 4
mostPopularLetter :: String -> Char
mostPopularLetter = undefined

-- 5
coolestLtr :: [String] -> Char
coolestLtr = undefined

coolestWord :: [String] -> String
coolestWord = undefined
