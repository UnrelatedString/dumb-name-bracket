-- | Homebrewing rudimentary Peano numerals because type-level Ints are too powerful
-- | and the existing library infrastructure for Peano numerals is ultra unmaintained

module Type.Peano
  ( Peano
  , One
  , Succ
  , class Predecessor
  ) where

-- | Kind of typelevel Peano naturals
data Peano

foreign import data One :: Peano

foreign import data Succ :: Peano -> Peano

class Predecessor :: 
