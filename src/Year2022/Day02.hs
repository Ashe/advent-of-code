module Year2022.Day02 (
  part01,
  part02
) where

--------------------------------------------------------------------------------

-- Entry point of first puzzle for 02/2022
part01 :: [String] -> String
part01 values = show $ foldl addScores 0 values
  where addScores score line = score + getRoundScore (getRound line)


-- Entry point of second puzzle for 02/2022
part02 :: [String] -> String
part02 values = show $ foldl addScores 0 values
  where addScores score line = score + getRoundScore (getRoundAlternative line)

--------------------------------------------------------------------------------

-- The different moves available
data Move = Rock | Paper | Scissors deriving (Show, Eq)


-- A round of rock paper scissors between two players
data Round = Round Move Move


-- The state of a round (for player B)
data Outcome = Win | Lose | Draw deriving (Show, Eq)


-- Translates a round string into a pair of moves
getRound :: String -> Round
getRound line = Round a b
  where [a, b] = getMove . head <$> words line


-- Get a round given the proper strategy
getRoundAlternative :: String -> Round
getRoundAlternative line = Round a' b'
  where [a, b] = head <$> words line
        a' = getMove a
        b' = getMoveForOutcome (getOutcome b) a'


-- Translates a character into a move
getMove :: Char -> Move
getMove 'A' = Rock
getMove 'X' = Rock
getMove 'B' = Paper
getMove 'Y' = Paper
getMove 'C' = Scissors
getMove 'Z' = Scissors
getMove _ = Rock


-- Computes the score for a given round
getRoundScore :: Round -> Int
getRoundScore r@(Round _ b) = moveScore b + outcomeScore (getRoundOutcome r)


-- Points earned for a given move
moveScore :: Move -> Int
moveScore Rock = 1
moveScore Paper = 2
moveScore Scissors = 3


-- Points earned for a given outcome
outcomeScore :: Outcome -> Int
outcomeScore Win = 6
outcomeScore Draw = 3
outcomeScore Lose = 0


-- Determine the outcome of a match
getRoundOutcome :: Round -> Outcome
getRoundOutcome (Round Rock Paper) = Win
getRoundOutcome (Round Paper Scissors) = Win
getRoundOutcome (Round Scissors Rock) = Win
getRoundOutcome (Round a b)
  | a == b = Draw
  | otherwise = Lose


-- Translates a character into an intended outcome
getOutcome :: Char -> Outcome
getOutcome 'X' = Lose
getOutcome 'Y' = Draw
getOutcome 'Z' = Win
getOutcome _ = Lose


-- Given an intended outcome, determine what move needs to be made
getMoveForOutcome :: Outcome -> Move -> Move
getMoveForOutcome Win Rock = Paper
getMoveForOutcome Win Paper = Scissors
getMoveForOutcome Win Scissors = Rock
getMoveForOutcome Lose Rock = Scissors
getMoveForOutcome Lose Paper = Rock
getMoveForOutcome Lose Scissors = Paper
getMoveForOutcome Draw move = move
