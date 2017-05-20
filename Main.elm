port module Instrument exposing (..)

import Html exposing (..)
import Time exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { phrase : Phrase
    , ticks : Int
    , clock : Int
    }


type alias Phrase =
    List Note


type alias Note =
    { frequency : Float
    , duration : Float
    , tick : Int
    }


model =
    { phrase =
        [ Note 440 2 1
        , Note 660 1 1
        , Note 880 1 1
        , Note 660 0.5 2
        , Note 660 1.5 3
        , Note 440 0.5 4
        ]
    , ticks = 4
    , clock = 1
    }


init : ( Model, Cmd Msg )
init =
    ( model
    , Cmd.none
    )



-- UPDATE


type Msg
    = Tick Time


port play : Note -> Cmd msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            { model
                | clock = increment model.clock
            }
                ! [ Cmd.batch (playNote model.phrase model.clock) ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text (showPhrase model.phrase) ]
        , h3 [] [ text (showClock model.clock) ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick



-- CMDS


playNote : Phrase -> Int -> List (Cmd msg)
playNote phrase clock =
    List.filter (\n -> .tick n == clock) phrase
        |> List.map play



-- |> play


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


showPhrase : Phrase -> String
showPhrase phrase =
    List.map .frequency phrase
        |> List.map toString
        |> String.join ", "



-- hack to show clock correctly


showClock : Int -> String
showClock clock =
    case clock % 4 of
        1 ->
            toString 4

        _ ->
            toString (clock - 1)
