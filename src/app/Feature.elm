module Feature exposing (..)

import Html exposing (Html)


-- MODEL


type alias State =
    { title : String
    }


type Msg
    = DoThing
    | DoStuff



-- VIEW


view : State -> Html Msg
view model =
    Html.text "A Feature"



-- UPDATE


update : Msg -> State -> ( State, Cmd Msg )
update msg model =
    case msg of
        DoThing ->
            ( model, Cmd.none )

        DoStuff ->
            ( model, Cmd.none )
