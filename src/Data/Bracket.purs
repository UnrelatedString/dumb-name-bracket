-- Functional core representation of the actual bracket
module Data.Bracket
  ( Config
  , Round(..)
  ) where

import Prelude
import Data.Reflectable (reflectType)
import Type.Proxy (Proxy(..))

type Config =
  { perMatch :: Int
  -- , winners :: Int -- figuring out how to actually distribute that sounds like not for now
  -- , eliminationRounds :: Int -- more realistic but way unnecessary
  }

-- The first round is round 1
newtype Round :: Int -> Type
newtype Round outOf = Round Int

-- Convert to counting backwards where finals are round 0
roundsLeft :: forall (outOf :: Int). Round outOf -> Int
roundsLeft (Round x) = reflectType (Proxy@outOf) - x
