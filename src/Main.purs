module Main where

import Prelude

import Effect (Effect)
import DOM.HTML.Indexed.InputType as InputType
import Halogen as H
import Halogen.HTML as HTML
import Halogen.HTML.Events as Events
import Halogen.HTML.Properties as Prop
import Halogen.Aff (runHalogenAff, awaitBody)
import Halogen.VDom.Driver (runUI)

main :: Effect Unit
main = runHalogenAff do
  body <- awaitBody
  runUI root unit body

type Action = Unit

-- going to try just doing a mono-component Elm style thing for now and. see how it goes
type State =
  {
  }

root
  :: forall query input output m.
  H.Component query input output m
root = H.mkComponent
  { initialState
  , render
  , eval: H.mkEval H.defaultEval
  }

initialState :: forall a. a -> State
initialState _ =
  {
  }

render :: forall m. State -> H.ComponentHTML Action () m
render _ = HTML.div_
  [ HTML.p_ [HTML.text "waow"]
  ]
