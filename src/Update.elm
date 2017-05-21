module Update exposing (..)

import Time exposing (Time)
import Model exposing (..)
import Ports exposing (..)
import Update.Extra exposing (updateModel)


type Msg
    = Tick Time
    | Rotate


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            { model
                | clock = increment model.clock
            }
                ! [ Cmd.batch (playNotes model.score model.clock) ]

        Rotate ->
            model
                ! []
                |> updateModel (\model -> { model | voice = rotate model.voice })
                |> updateModel (\model -> { model | score = read model.voice model.score })


playNotes : Score -> Int -> List (Cmd msg)
playNotes score clock =
    List.filter (\n -> .tick n == clock) score
        |> List.map play


increment : Int -> Int
increment clock =
    case clock of
        4 ->
            1

        _ ->
            clock + 1


read : Phrase -> Score -> Score
read voice score =
    case voice.pattern of
        Whole ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 4 1 ]

        HalfDotQuart ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 3 1 ]
                |> (++) [ Note (.frequency voice) 1 4 ]


filterFrequency : Phrase -> Score -> Score
filterFrequency phrase score =
    List.filter (\n -> .frequency n /= .frequency phrase) score


rotate : Phrase -> Phrase
rotate voice =
    case voice.pattern of
        Whole ->
            { voice | pattern = HalfDotQuart }

        HalfDotQuart ->
            { voice | pattern = Whole }


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
