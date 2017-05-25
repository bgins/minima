module Update exposing (..)

import List.Extra exposing (..)
import Time exposing (Time)
import Model exposing (..)
import Ports exposing (..)


type Msg
    = Tick Time
    | Play
    | Pause
    | Rotate Voice
    | Read Voice


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            { model
                | clock = increment model.clock
            }
                ! [ Cmd.batch (playNotes model.score model.clock) ]

        Play ->
            { model | clock = 1 } ! []

        Pause ->
            { model | clock = 0 } ! []

        Rotate voice ->
            case voice.id of
                "root" ->
                    { model
                        | root = rotate voice
                        , score = read voice model.score
                    }
                        ! []

                "third" ->
                    { model
                        | third = rotate voice
                        , score = read voice model.score
                    }
                        ! []

                "fifth" ->
                    { model
                        | fifth = rotate voice
                        , score = read voice model.score
                    }
                        ! []

                "octave" ->
                    { model
                        | octave = rotate voice
                        , score = read voice model.score
                    }
                        ! []

                _ ->
                    { model | octave = rotate voice } ! []

        Read voice ->
            { model | score = read voice model.score } ! []


increment : Int -> Int
increment clock =
    case clock of
        0 ->
            0

        4 ->
            1

        _ ->
            clock + 1


playNotes : Score -> Int -> List (Cmd msg)
playNotes score clock =
    List.filter (\n -> .tick n == clock) score
        |> List.map play


read : Voice -> Score -> Score
read voice score =
    (readPattern 0 voice (.pattern (rotate voice)) score)
        ++ (filterFrequency voice score)


readPattern : Int -> Voice -> Pattern -> Score -> Score
readPattern count voice pattern score =
    case count of
        5 ->
            []

        _ ->
            case pattern of
                [] ->
                    []

                p :: ps ->
                    case p of
                        Model.Play n ->
                            (Note (.frequency voice) n (n + count))
                                :: readPattern (n + count) voice ps score

                        Model.Rest n ->
                            readPattern (n + count) voice ps score


filterFrequency : Voice -> Score -> Score
filterFrequency voice score =
    List.filter (\n -> .frequency n /= .frequency voice) score


rotate : Voice -> Voice
rotate voice =
    case elemIndex voice.pattern patterns of
        Just n ->
            { voice | pattern = getPatternAt ((n + 1) % List.length patterns) }

        Nothing ->
            { voice | pattern = voice.pattern }


getPatternAt : Int -> Pattern
getPatternAt index =
    case patterns !! index of
        Just pattern ->
            pattern

        Nothing ->
            []
