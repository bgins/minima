module Main exposing (..)

import Html exposing (Html)
import Time exposing (every, second)
import Model exposing (Model, model)
import Update exposing (..)
import View exposing (view)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( model
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick
