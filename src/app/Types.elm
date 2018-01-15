module Types exposing (..)

import Navigation exposing (Location)
import Stack


-- MESSAGES: All app messages


type Msg
    = Noop
    | UrlChange Location
    | StackMsg Stack.Msg.AddStackItem



-- FLAGS: Input value from javascript
{-
   if I change data structure in javascript
   compiler will not complain (it doesn't know about it)
   but there will be a runtime error
-}


type alias Flags =
    String



-- MODEL: Top level app state


type alias Model =
    { flags : Flags
    , location : Location
    , stack : Stack.State
    }


initialState : Flags -> Location -> Model
initialState flags location =
    Model flags location []
