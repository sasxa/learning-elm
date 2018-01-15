module Tests exposing (..)

import Test exposing (..)
import Setup


tests : Test
tests =
    describe "elm-try app Tests"
        [ Setup.tests
        ]
