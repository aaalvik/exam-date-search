module ExamSearch.Main where

import Prelude hiding (div)

import Effect (Effect)
import Effect.Class (liftEffect)
import CSS (marginBottom, px)
import ExamSearch.Styles as Styles
import Effect.Aff (Aff)
import Effect.Console (log)
import Data.Array as Array
import Data.Either (Either(Left,Right))
import Data.Foldable (for_)
import Data.Maybe (Maybe(Just, Nothing))
import Pux as Pux
import Pux.DOM.Events (onClick)
import Pux.DOM.HTML (HTML)
import Pux.DOM.HTML.Attributes (key, style)
import Pux.Renderer.React (renderToDOM)
import Signal (constant)
import Text.Smolder.HTML (div, h1, span)
import Text.Smolder.Markup (text, (!), (#!))

data Event
  = NoOp


type State =
  { searchString :: String
  , examDate :: Maybe ExamDate 
  }

type ExamDate = String 


foreign import formatTime :: String -> String


initialState :: State
initialState =
  { searchString: ""
  , examDate: Nothing 
  }


foldp :: Event -> State -> { state :: State, effects :: Array (Aff (Maybe Event)) }
foldp NoOp state = { state, effects: [] }


view :: State -> HTML Event
view {searchString, examDate} = do
  div ! style Styles.header $ do
    h1
      -- ! style Styles.headerTitle
      $ text "Eksamenssøk for UiB"
  div ! style Styles.content $ viewDate examDate


viewDate :: Maybe ExamDate -> HTML Event 
viewDate maybeDate =
  case maybeDate of 
    Just date -> 
      div ! style Styles.date $ text date
    Nothing -> 
      div ! style Styles.date $ text "___"


main :: Effect Unit
main = do
  app <- Pux.start
    { initialState
    , view
    , foldp
    , inputs: []
    }
  renderToDOM "#app" app.markup app.input
