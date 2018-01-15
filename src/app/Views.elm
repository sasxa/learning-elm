module Views exposing (..)

import Html exposing (Html, div, text)
import Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div [] [ text (toString model) ]
