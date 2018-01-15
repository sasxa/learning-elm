module Updates exposing (..)

import Types exposing (Model, Msg(..))
import Stack


debugMessage : String -> data -> Model -> ( Model, Cmd Msg )
debugMessage label data model =
    let
        _ =
            Debug.log label data
    in
        ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

        UrlChange location ->
            debugMessage "location" location model

        Stack.Msg.AddStackItem ->
            Stack.update Stack.Msg.AddStackItem model.stack



-- ( model, Cmd.none )
