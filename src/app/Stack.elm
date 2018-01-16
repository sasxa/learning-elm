-- module Stack exposing (State, Msg(..), update, init, view, subscriptions)


module Stack exposing (..)

{--| Generic Stack Container.
Can be used for multiple toast notifications

Based on: https://github.com/billperegoy/elm-flash
-}

import Html.Attributes exposing (class)
import Process
import Task
import Time exposing (Time, second)


-- TODO: Remove these imports

import Time
import Html exposing (Html, div, p, text)


-- MODEL


type alias Item =
    { duration : Time
    , view : Html Msg
    }


type alias State =
    List Item


type Msg
    = AddStackItem Time (Html Msg)
    | RemoveStackItem Item



-- UPDATE


update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    case msg of
        RemoveStackItem item ->
            let
                stack =
                    List.filter (\x -> x /= item) state
            in
                ( stack, Cmd.none )

        AddStackItem time view ->
            let
                item =
                    Item time view
            in
                ( item :: state, queueCmd item )


queueCmd : Item -> Cmd Msg
queueCmd item =
    case item.duration of
        0 ->
            Cmd.none

        _ ->
            Process.sleep (item.duration * second)
                |> Task.perform (\_ -> RemoveStackItem item)



{--MAIN  --}


main : Program Never State Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( State, Cmd Msg )
init =
    ( [], Cmd.none )


subscriptions : State -> Sub Msg
subscriptions model =
    Time.every (second * 1) (\time -> AddStackItem 5 (itemView time))


itemView : Time -> Html Msg
itemView time =
    p [] [ text ("Hey " ++ toString (Time.inSeconds time)) ]


view : State -> Html Msg
view state =
    div [ class "stack-container" ] (List.map (\x -> x.view) state)
--}
