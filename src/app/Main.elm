module Main exposing (..)

import Types exposing (Model, Flags, initialState, Msg(..))
import Navigation exposing (Location)
import Updates exposing (update)
import Views exposing (view)
import Stack


{--SIGNATURES FOR PROGRAM

    init : Flags -> Location -> ( Model, Cmd Msg )
    update : Msg -> Model -> ( Model, Cmd Msg )
    view : Model -> Html Msg

--}
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.map StackMsg (Stack.subscriptions model.stack)



-- Sub.none
-- INIT


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    update (UrlChange location) (initialState flags location)



-- MAIN


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        -- Navigation.program UrlChange
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
