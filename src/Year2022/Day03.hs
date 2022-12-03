module Year2022.Day03 (
  part01,
  part02
) where

import Data.List (intersect)
import Data.Maybe (fromMaybe)
import Data.Set (fromList, intersection)

--------------------------------------------------------------------------------

-- Entry point of first puzzle for 03/2022
part01 :: [String] -> String
part01 values = show . sum $ getScoreForRucksack <$> rucksacks
  where rucksacks = toRucksack <$> values


-- Entry point of second puzzle for 03/2022
part02 :: [String] -> String
part02 values = show . sum $ getScoreForGroup <$> rucksacks
  where rucksacks = fmap toRucksack <$> groups values
        groups vs = case vs of
          [] -> []
          (a : b : c : xs) -> [a, b, c] : groups xs
          xs -> [xs]

--------------------------------------------------------------------------------

-- Data type representing a rucksack with two compartments
data Rucksack = Rucksack [Char] [Char] deriving (Eq, Show)


-- Get a rucksack from a string
toRucksack :: String -> Rucksack
toRucksack string = Rucksack comp1 comp2
  where (comp1, comp2) = splitAt middle string
        middle = length string `div` 2


-- Get priorities of a list of duplicates
getScoreForRucksack :: Rucksack -> Int
getScoreForRucksack (Rucksack a b) = foldl sumPriorities 0 duplicates
  where duplicates = fromList $ a `intersect` b
        sumPriorities score char = score + getScore char


-- Determines the score for a given character
getScore :: Char -> Int
getScore char = fromMaybe 0 $ lookup char scores
  where scores = zip ['a'..'z'] [1..26] ++ zip ['A'..'Z'] [27..52]


-- Retrives common element of a group of rucksacks
getScoreForGroup :: [Rucksack] -> Int
getScoreForGroup rucksacks = foldl (\s cs -> s + getScore cs) 0 common
  where sets = (\(Rucksack a b) -> fromList (a ++ b)) <$> rucksacks
        common = foldl intersection (fromList $ ['a'..'z'] ++ ['A'..'Z']) sets
