module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Test.Unit (suite, test)
import Test.Unit.Assert (equal)
import Test.Unit.Main (runTest)

-- main :: forall e. Eff (console :: CONSOLE | e) Unit
-- main = do
--   log "You should add some tests."

main = runTest do 
  suite "Hello" do 
    test "World!" do 
      equal (1 + 1) 2
    test "Far Out!" do
      equal (2 + 2) 4
