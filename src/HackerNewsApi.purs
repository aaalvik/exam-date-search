module HackerReader.HackerNewsApi where

import Prelude

import Effect.Aff (Aff)
import Data.Either (Either)
import Foreign (MultipleErrors)
import Data.String as Str
import Network.HTTP.Affjax as Affjax
import Network.HTTP.Affjax.Response as Response
import Simple.JSON as SimpleJson

type QueryResult = 
  { hits :: Array Story }

type Story = 
  { created_at :: String
  , objectID :: String
  , points :: Int
  , title :: String
  , url :: String }

hackerNewsApi :: String
hackerNewsApi = "https://hn.algolia.com/api/v1/search"

hackerNewsStoryIds :: Array Int
hackerNewsStoryIds = [14701199, 4289910, 11174806, 7943303, 12429681, 12571904, 5098981, 7160242, 13577486, 10930298, 11097514, 9503580, 10640478]

storiesUrl :: Array Int -> String
storiesUrl storyIds = hackerNewsApi <> "?tags=story,(" <> storyTags <> ")"
  where storyTags = Str.joinWith "," (mkStoryTag <$> storyIds)

mkStoryTag :: Int -> String
mkStoryTag id = "story_" <> show id

fetchHackerNewsStories :: Aff (Either MultipleErrors (Array Story))
fetchHackerNewsStories = do
  result <- Affjax.get Response.string $ storiesUrl hackerNewsStoryIds
  let (decoded :: Either MultipleErrors QueryResult) = SimpleJson.readJSON result.response
  pure $ map _.hits decoded
