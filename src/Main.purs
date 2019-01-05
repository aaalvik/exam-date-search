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
import Pux.DOM.Events (onClick, onChange, DOMEvent, targetValue)
import Pux.DOM.HTML (HTML)
import Pux.DOM.HTML.Attributes (style)
import Pux.Renderer.React (renderToDOM)
import Text.Smolder.HTML (div, h1, input)
import Text.Smolder.HTML.Attributes (type', value)
import Text.Smolder.Markup (text, (!), (#!))

data Event
  = NoOp
  | SearchStrChange DOMEvent


type State =
  { searchStr :: String
  , subject :: Maybe Subject 
  }

type Subject = String 


foreign import formatTime :: String -> String


initialState :: State
initialState =
  { searchStr: ""
  , subject: Nothing 
  }


foldp :: Event -> State -> { state :: State, effects :: Array (Aff (Maybe Event)) }
foldp NoOp state = { state, effects: [] }
foldp (SearchStrChange event) state = 
  { state: state { searchStr = targetValue event }, effects: [] }


view :: State -> HTML Event
view {searchStr, subject} = do
  div ! style Styles.header $ do
    h1
      -- ! style Styles.headerTitle
      $ text "Eksamenssøk for UiB"
  div ! style Styles.content $ do
    input ! type' "text" ! value searchStr #! onChange SearchStrChange
    viewSubject subject


viewSubject :: Maybe Subject -> HTML Event 
viewSubject maybeSubject =
  case maybeSubject of 
    Just subject -> 
      div ! style Styles.date $ text subject
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
