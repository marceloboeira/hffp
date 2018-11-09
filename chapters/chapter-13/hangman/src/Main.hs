module Main where

import Control.Monad (forever)
import Data.Char (toLower)
import Data.Maybe (isJust)
import Data.List (intersperse)
import System.Exit (exitSuccess)
import System.Random (randomRIO)

allWords :: IO [String]
allWords = do
  dictionary <- readFile "data/dictionary.txt"
  return (lines dictionary)

minWordLength :: Int
minWordLength = 5

maxWordLength :: Int
maxWordLength = 9

gameWords :: IO [String]
gameWords = do
  aw <- allWords
  return (filter respectLength aw)
  where respectLength s =
          let l = length (s :: String)
           in l >= minWordLength && l < maxWordLength

randomWord :: [String] -> IO String
randomWord wl = do
  randomIndex <- randomRIO (0, (length wl) - 1)
  return $ wl !! randomIndex

randomWord' :: IO String
randomWord' = gameWords >>= randomWord

data Puzzle = Puzzle String [Maybe Char] [Char] [Char]

instance Show Puzzle where
  show (Puzzle _ discovered correctGuess wrongGuess) =
    (intersperse ' ' $ fmap renderPuzzleChar discovered) ++ " Guessed so far: " ++ (correctGuess ++ wrongGuess)


freshPuzzle :: String -> Puzzle
freshPuzzle s =  Puzzle s (map (const Nothing) s) [] []

charInWord :: Puzzle -> Char -> Bool
charInWord (Puzzle s _ _ _) c = elem c s

alreadyGuessed :: Puzzle -> Char -> Bool
alreadyGuessed (Puzzle _ _ g w) c = elem c (g ++ w)

renderPuzzleChar :: Maybe Char -> Char
renderPuzzleChar Nothing = '_'
renderPuzzleChar (Just c) = c

fillInCharacter :: Bool -> Puzzle -> Char -> Puzzle
fillInCharacter correct (Puzzle word filledInSoFar s s') c =
  case correct of
    True -> Puzzle word newFilledInSoFar (c : s) s'
    False -> Puzzle word newFilledInSoFar s (c : s')
  where zipper guessed wordChar guessChar =
          if wordChar == guessed
          then Just wordChar
          else guessChar
        newFilledInSoFar = zipWith (zipper c) word filledInSoFar

gameOver :: Puzzle -> IO ()
gameOver (Puzzle wordToGuess _ _ mistakes) =
  if (length mistakes) >= 7 then
    do putStrLn "You lose!"
       putStrLn $ "The word was: " ++ wordToGuess
       exitSuccess
   else return ()

gameWin :: Puzzle -> IO ()
gameWin (Puzzle _ filledInSoFar _ _) =
  if all isJust filledInSoFar then
    do putStrLn "You win!"
       exitSuccess
  else return ()

handleGuess :: Puzzle -> Char -> IO Puzzle
handleGuess puzzle guess = do
  putStrLn $ "Your guess was: " ++ [guess]
  case (charInWord puzzle guess, alreadyGuessed puzzle guess) of
    (_, True) -> do
     putStrLn "You already guessed that character, pick something else!"
     return puzzle
    (True, _) -> do
      putStrLn "This character was in the word, filling in the word accordingly"
      return (fillInCharacter True puzzle guess)
    (False, _) -> do
      putStrLn "This character wasn't in the word, try again."
      return (fillInCharacter False puzzle guess)

runGame :: Puzzle -> IO ()
runGame puzzle = forever $ do
  gameWin puzzle
  gameOver puzzle
  putStrLn $ "Current puzzle is: " ++ show puzzle
  putStr "------"
  putStr "Guess a letter: "
  guess <- getLine
  case guess of
    [c] -> handleGuess puzzle c >>= runGame
    _   -> putStrLn "Your guess must be a single character"

main :: IO ()
main = do
  word <- randomWord'
  let puzzle = freshPuzzle (fmap toLower word)
  runGame puzzle
