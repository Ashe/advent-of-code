module Year2022.Day01 (
  part01,
  part02
) where

import Data.List (insert)
import Text.Read (readMaybe)

--------------------------------------------------------------------------------

-- Entry point of first puzzle for 01/2022
part01 :: [String] -> String
part01 values = show $ maximum (current : totals)
  where (totals, current) = foldl calcTotals ([], 0) values


-- Entry point of second puzzle for 01/2022
part02 :: [String] -> String
part02 values = show $ sum $ foldl (updateTotals 3) [] totals
  where totals = let (ts, c) = foldl calcTotals ([], 0) values in c : ts
        updateTotals n ts value
          | length ts < n = insert value ts
          | null ts = []
          | value > minimum ts = drop 1 $ insert value ts
          | otherwise = ts

--------------------------------------------------------------------------------

-- Calculate totals of each sublist
calcTotals :: ([Int], Int) -> String -> ([Int], Int)
calcTotals (totals, currentTotal) [] = (currentTotal : totals, 0)
calcTotals (totals, currentTotal) string =
  case readMaybe string of
    Just value -> (totals, currentTotal + value)
    _ -> (currentTotal : totals, 0)
