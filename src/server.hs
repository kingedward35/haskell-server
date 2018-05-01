{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ExtendedDefaultRules #-}
import           Yesod

data App = App

mkYesod "App" [parseRoutes|
/ HomeR GET
/page1 Page1R GET
/page2 Page2R GET
/test TestR GET
/more MoreR GET
|]

myLayout :: Widget -> Handler Html
myLayout widget = do
    pc <- widgetToPageContent $ do
        widget
        toWidget [lucius| body { font-family: verdana } |]
    withUrlRenderer
        [hamlet|
            $doctype 5
            <html>
                <head>
                    <title>#{pageTitle pc}
                    <meta charset=utf-8>
                    ^{pageHead pc}
                <body>
                    <article>
                        ^{pageBody pc}
        |]

instance Yesod App where
    defaultLayout = myLayout

getHomeR :: Handler Html
getHomeR = defaultLayout
    [whamlet|
        <p>Hello World!
        <a href=@{Page1R}>Go to page 1!
    |]


getPage1R = defaultLayout [whamlet|<a href=@{Page2R}>Go to page 2!|]
getPage2R = defaultLayout [whamlet|<a href=@{HomeR}>Go home!|]
getTestR = return $ object ["msg" .= "Hello World" 
                           , "another msg" .= "Keep it moving!!"
                           ]

getMoreR = return $ object ["give" .= "Give me more! I need more!"]

main :: IO ()
main = warp 3000 App 