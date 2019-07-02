module Main exposing (init, main, subscriptions)

import Browser
import Html exposing (Html)
import Model exposing (Model, model)
import Time exposing (every)
import Update exposing (..)
import View exposing (view)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( model
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    every 1000 Tick
