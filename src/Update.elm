module Update exposing (..)

import Time exposing (Time)
import Model exposing (..)
import Ports exposing (..)


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            { model
                | clock = increment model.clock
            }
                ! [ Cmd.batch (playNote model.phrase model.clock) ]


playNote : Phrase -> Int -> List (Cmd msg)
playNote phrase clock =
    List.filter (\n -> .tick n == clock) phrase
        |> List.map play


increment : Int -> Int
increment clock =
    case clock of
        4 ->
            1

        _ ->
            clock + 1


frequency : Maybe Note -> Float
frequency note =
    case note of
        Just note ->
            note.frequency

        Nothing ->
            30000


duration : Maybe Note -> Float
duration note =
    case note of
        Just note ->
            note.duration

        Nothing ->
            0
