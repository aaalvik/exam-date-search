{-# LANGUAGE OverloadedStrings #-}
module Main where


import qualified Data.Aeson as Aeson
import AWSLambda
import Text.HTML.Scalpel
import Control.Applicative

main :: IO ()
main = print $ scrapeStringLike exampleHtml allSubjects 
-- main = lambdaMain handler


  
handler :: Aeson.Value -> IO [Int]
handler evt = do
  putStrLn "This should go to logs"
  print evt
  pure [1, 2, 3]


url = "https://www.uib.no/student/eksamensplan/matnat#v-r-2019"


data Subject = Subject 
    { title :: String 
    --, date :: String
    } deriving Show



-- allSubjects :: Scraper String [Subject]
allSubjects :: Scraper String [Subject]
allSubjects = 
    chroot ("div" @: ["id" @= "v-r-2019"]) $ 
        chroot ("div" @: [hasClass "ui-accordion-content"]) $
            chroot ("div" @: [hasClass "item-list"]) $
                chroots "li" subject
    where     
        subject :: Scraper String Subject 
        subject = do
            title <- getTitle
            -- typeOfExam <- ...
            -- date <- chroot ("dl" @: [hasClass "uib-study-exam-assessment"]) $ text "dd"
            return $ Subject title -- date

        getTitle :: Scraper String String 
        getTitle = do 
            chroot ("h3" @: [hasClass "exam-list-title"]) $
                text "a"


exampleHtml :: String
exampleHtml = "<html>\
\    <body>\
\        <div id='v-r-2019'>\
\            <div class='ui-accordion-content'>\
\                <div class='item-list'>\
\                    <ul class='faculty-exam-list'>\
\                        <li>\
\                            <h3 class='exam-list-title'>\
\                                <a>INF122</a>\
\                                Funksjonell programmering\
\                            </h3>\
\                        </li>\
\                        <li>\
\                            <h3 class='exam-list-title'>\
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