module Views exposing (..)

import Html exposing (Html, div, text)
import Types exposing (Model, Msg(..))
import Stack


view : Model -> Html Msg
view model =
    div []
        [ text (toString model)
        , Html.map StackMsg (Stack.view model.stack)
        ]
