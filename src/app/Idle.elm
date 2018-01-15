module Idle exposing (State)

{-| This program keeps track of your idle sessions. It will start
a "Session" when webpage is not visible or out of focus and
end "Session" when webpage becomes visible or comes into focus again.


# <https://ellie-app.com/3np98Th49a1/1>

I created this to learn how subscriptions work in Elm.

-}

import Html exposing (Html, div, p, text)
import Json.Encode
import PageVisibility
import Task
import Time exposing (Time, second, inSeconds)


-- MODEL


type alias Session =
    { startTime : Time
    , endTime : Time
    }


type alias State =
    List Session


type Msg
    = Noop
    | VisibilityChange PageVisibility.Visibility
    | StartSession Time
    | EndSession Time



-- HELPER FUNCTIONS


duration : Session -> Time
duration { endTime, startTime } =
    let
        delta =
            endTime - startTime
    in
        clamp 0 delta delta



-- SUBSCRIPTIONS


subscriptions : State -> Sub Msg
subscriptions model =
    PageVisibility.visibilityChanges VisibilityChange



-- UPDATE


update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    case msg of
        Noop ->
            ( state, Cmd.none )

        VisibilityChange PageVisibility.Visible ->
            ( state, Task.perform EndSession Time.now )

        VisibilityChange PageVisibility.Hidden ->
            ( state, Task.perform StartSession Time.now )

        StartSession time ->
            ( startSession time state, Cmd.none )

        EndSession time ->
            ( endSession time state, Cmd.none )


startSession : Time -> State -> State
startSession time state =
    Session time 0 :: state


endSession : Time -> State -> State
endSession time state =
    let
        session : Maybe Session
        session =
            List.head state
    in
        case session of
            Just session ->
                { session | endTime = time } :: List.drop 1 state

            Nothing ->
                state



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


view : State -> Html Msg
view state =
    div [] (List.map (\x -> p [] [ text (toJSON x) ]) state)



-- VIEW HELPERS


toJSON : Session -> String
toJSON session =
    let
        value =
            Json.Encode.object
                [ ( "start", encodeToInt <| session.startTime )
                , ( "end", encodeToInt <| session.endTime )
                , ( "duration", encodeToString <| duration <| session )
                ]
    in
        Json.Encode.encode 0 value


encodeToInt : Time -> Json.Encode.Value
encodeToInt time =
    time
        |> inSeconds
        |> round
        |> Json.Encode.int


encodeToString : Time -> Json.Encode.Value
encodeToString time =
    time
        |> inSeconds
        |> toString
        |> (++) " seconds"
        |> Json.Encode.string
--}
