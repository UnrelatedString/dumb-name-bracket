-- Functional core representation of the actual bracket
module Data.Bracket
  ( Config
  , Round(..)
  , Seed(..)
  , boustrophedonUnDivMod
  ) where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Int (pow)
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

matchesIn :: forall (outOf :: Int). Reflectable outOf Int => Round outOf -> Int
matchesIn = pow 2 <<< roundsLeft

-- for determining what seeds play in a match LMAO
boustrophedonUnDivMod :: Int -> Int -> Int -> Seed
boustrophedonUnDivMod matches quotient remainder
  | quotient `mod` 2 == 0 = Seed $ quotient * matches + remainder
  | otherwise = Seed $ (quotient + 1) * matches - remainder - 1

seedsInMatch :: Round 
