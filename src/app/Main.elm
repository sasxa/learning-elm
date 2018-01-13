module Main exposing (..)

import Html exposing (program)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Updates exposing (update)
import Views exposing (view)


init : ( Model, Cmd Msg )
init =
    ( Model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
