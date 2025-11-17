-- Functional core representation of the actual bracket
module Data.Bracket
  ( Config
  , Round(..)
  , Seed(..)
  , boustrophedonUnDivMod
  ) where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Data.Newtype (class Newtype)
import Data.Reflectable
  ( class Reflectable
  , reflectType
  )
import Type.Proxy (Proxy(..))

type Config =
  { perMatch :: Int
  -- , winners :: Int -- figuring out how to actually distribute that sounds like not for now
  -- , eliminationRounds :: Int -- more realistic but way unnecessary
  }

-- The first round is round 1
newtype Round :: Int -> Type
newtype Round outOf = Round Int
-- is this even a thing i can do i forgot
-- derive newtype instance forall (outOf :: Int). Eq (Round outOf)

-- 0-based
newtype Seed = Seed Int
derive newtype instance Eq Seed
derive instance Newtype Seed _
derive instance Generic Seed _

instance Show Seed where
  show = genericShow

-- Convert to counting backwards where finals are round 0
roundsLeft :: forall (outOf :: Int). Reflectable outOf Int => Round outOf -> Int
roundsLeft (Round x) = reflectType (Proxy@outOf) - x

-- for determining what seeds play in a match LMAO
boustrophedonUnDivMod :: Int -> Int -> Int -> Seed
boustrophedonUnDivMod divisor quotient remainder
  | quotient `mod` 2 == 0 = Seed $ quotient * divisor + remainder
  | otherwise = Seed $ (quotient + 1) * divisor - remainder - 1
