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
    , phraseLeft : Phrase
    , sustain : Float
    }


type alias Phrase =
    List Note


type alias Note =
    { frequency : Float
    , duration : Float
    }


model =
    { phrase =
        [ Note 440 1
        , Note 660 0.25
        , Note 880 0.25
        , Note 660 0.5
        ]
    , phraseLeft = []
    , sustain = 0
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
                | phraseLeft = loop model.phrase model.phraseLeft
                , sustain = duration (List.head model.phraseLeft)
            }
                ! [ playNote model.phraseLeft ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text (showPhrase model.phrase) ]
        , h3 [] [ text (showPhrase model.phraseLeft) ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    every (second * model.sustain) Tick



-- CMDS


playNote : Phrase -> Cmd msg
playNote phraseLeft =
    case List.head phraseLeft of
        Just a ->
            play a

        Nothing ->
            Cmd.none


loop : Phrase -> Phrase -> Phrase
loop phrase phraseLeft =
    case phraseLeft of
        [] ->
            phrase

        [ a ] ->
            phrase

        n :: ns ->
            ns


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
