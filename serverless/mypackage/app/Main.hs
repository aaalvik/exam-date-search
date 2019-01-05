{-# LANGUAGE OverloadedStrings #-}
module Main where


import qualified Data.Aeson as Aeson
import AWSLambda
import Text.HTML.Scalpel
import Control.Applicative

main :: IO ()
main = lambdaMain handler


  
handler :: Aeson.Value -> IO [Int]
handler evt = do
  putStrLn "This should go to logs"
  print evt
  pure [1, 2, 3]


url = "https://www.uib.no/student/eksamensplan/matnat#v-r-2019"


scrapeSubject :: String -> IO (Maybe Subject)
scrapeSubject searchStr = scrapeURL url subject 
    where 
        subject :: Scraper String Subject 
        subject = do 
            date <- text $ "span" @: [hasClass "date"] -- TODO FIX
            return $ Subject "TEST"


data Subject = Subject { name :: String }


exampleHtml :: String
exampleHtml = "<html>\
\    <body>\
\        <div id='v-r-2019'>\
\            <div class='ui-accordion-content'>\
\                <div class='item-list'>\
\                    <ul class='faculty-exam-list'>\
\                        <li>\
\                            <h3 class='exam-list-title>\
\                                <a>INF122</a>\
\                                Funksjonell programmering\
\                            </h3>\
\                        </li>\
\                        <li>\
\                            <h3 class='exam-list-title>\
\                                <a>INF220</a>\
\                                Programspesifikasjon\
\                            </h3>\
\                        </li>\
\                    </ul>\
\                </div>\
\            </div>\
\        </div>\
\    </body>\
\</html>"