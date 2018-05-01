module Main where

import Prelude
import Control.Monad.Eff.Console (log)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Aff (launchAff)
import Network.HTTP.Affjax (get)

main = launchAff do
  -- res <- get "http://jsonplaceholder.typicode.com/todos"
  res <- get "http://localhost:3000/test"
  liftEff $ log $ "GET /api response: " <> res.response
