module Main where

import System.Environment

import Paths_advent_of_code

import qualified Year2022.Day01 as Day01
import qualified Year2022.Day02 as Day02
import qualified Year2022.Day03 as Day03

--------------------------------------------------------------------------------

-- Entry point of program
main :: IO ()
main = do
  args <- getArgs
  case args of

    -- Output to file
    (year : day : part : ('-' : 'o' : '=' : output) : params) -> do
      let (y, d, p) = (read year, read day, read part)
      input <- if null params then readInputs y d p else pure params
      writeFile (output ++ ".txt") $ doPuzzle y d p input

    -- Print puzzle to terminal
    (year : day : part : params) -> do
      let (y, d, p) = (read year, read day, read part)
      input <- if null params then readInputs y d p else pure params
      putStrLn $ "Answer: " ++ doPuzzle y d p input

    -- Print usage
    _ -> do
      putStrLn "Usage: [year] [day] [part]"
      putStrLn "e.g. 2022 01 01."

-- Utility functions
--------------------------------------------------------------------------------

-- Get the input as a series of lines
readInputs :: Int -> Int -> Int -> IO [String]
readInputs y d part = do
  let path = "inputs/" ++ show y ++ "-" ++ show d ++ "-" ++ show part ++ ".txt"
  file <- getDataFileName path
  contents <- readFile file
  pure $ lines contents

-- Puzzles
--------------------------------------------------------------------------------

-- Do a specific puzzle for a given year
doPuzzle :: Int -> Int -> Int -> [String] -> String
doPuzzle 2022 1 1 = Day01.part01
doPuzzle 2022 1 2 = Day01.part02
doPuzzle 2022 2 1 = Day02.part01
doPuzzle 2022 2 2 = Day02.part02
doPuzzle 2022 3 1 = Day03.part01
doPuzzle 2022 3 2 = Day03.part02
doPuzzle y d p = const $ show y ++ "/" ++ show d ++ " part " ++ show p
  ++ ": puzzle not found."
