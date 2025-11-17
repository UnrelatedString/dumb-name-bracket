module Test.Main where

import Prelude

import Data.Array (zip)
import Data.Enum (enumFromTo)
import Data.Tuple (Tuple(..))
import Data.Traversable (for_)
import Effect (Effect)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.QuickCheck (quickCheck')
import Test.QuickCheck ((===))
import Test.Spec.Runner.Node (runSpecAndExitProcess)
import Test.Spec.Reporter.June.Pretty (prettyReporter)

import Data.Bracket
  ( Seed(..)
  , boustrophedonUnDivMod
  )

main :: Effect Unit
main = runSpecAndExitProcess [prettyReporter] do
  bracketSuite

bracketSuite :: Spec Unit
bracketSuite = describe "Core bracket logic" do
  describe "12 seeds are paired into 1v1v1s correctly" do
    for_ (enumFromTo 0 11 `zip` [0,1,2,3,7,6,5,4,8,9,10,11]) \(Tuple x seed) -> do
      let match = x `div` 3
      let slot = x `mod` 3
      it ("player " <> show slot <> " in match " <> show match) do
        boustrophedonUnDivMod 3 match slot `shouldEqual` Seed seed
