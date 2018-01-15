module Setup exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)


tests : Test
tests =
    let
        sanityTests =
            describe "1 + 1"
                [ test "1 + 1 = 2" <|
                    \_ -> Expect.equal (1 + 1) 2
                ]
    in
        describe "Tests Setup"
            [ sanityTests
            ]
