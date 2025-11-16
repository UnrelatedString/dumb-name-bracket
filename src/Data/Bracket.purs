-- Functional core representation of the actual bracket
module Data.Bracket
  ( Config
  ) where

import Prelude

type Config =
  { perMatch :: Int
  -- , winners :: Int -- figuring out how to actually distribute that sounds like not for now
  -- , eliminationRounds :: Int -- more realistic but way unnecessary
  }

