module Update exposing (..)

import List.Extra exposing (..)
import Time exposing (Time)
import Model exposing (..)
import Ports exposing (..)


type Msg
    = Tick Time
    | Play
    | Pause
    | Rotate Voice Direction


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            { model
                | clock = increment model.clock model.ticks
            }
                ! [ Cmd.batch (playNotes model.score model.clock) ]

        Play ->
            { model | clock = 1 } ! []

        Pause ->
            { model | clock = 0 } ! []

        Rotate voice direction ->
            case voice.id of
                "one" ->
                    { model
                        | one = rotate voice direction
                        , score = read voice direction model.score
                    }
                        ! []

                "two" ->
                    { model
                        | two = rotate voice direction
                        , score = read voice direction model.score
                    }
                        ! []

                "three" ->
                    { model
                        | three = rotate voice direction
                        , score = read voice direction model.score
                    }
                        ! []

                "four" ->
                    { model
                        | four = rotate voice direction
                        , score = read voice direction model.score
                    }
                        ! []

                _ ->
                    model ! []


increment : Int -> Int -> Int
increment clock ticks =
    case clock of
        0 ->
            0

        _ ->
            (clock % ticks) + 1


playNotes : Score -> Int -> List (Cmd msg)
playNotes score clock =
    List.filter (\n -> .tick n == clock) score
        |> List.map play



-- READ


read : Voice -> Direction -> Score -> Score
read voice direction score =
    (readPattern 1 voice (.pattern (rotate voice direction)) score)
        ++ (filterFrequency voice score)


readPattern : Int -> Voice -> Pattern -> Score -> Score
readPattern count voice pattern score =
    case pattern of
        [] ->
            []

        p :: ps ->
            case p of
                Model.Play n ->
                    (Note (.frequency voice) n count)
                        :: readPattern (n + count) voice ps score

                Model.Rest n ->
                    readPattern (n + count) voice ps score


filterFrequency : Voice -> Score -> Score
filterFrequency voice score =
    List.filter (\n -> .frequency n /= .frequency voice) score



-- ROTATE


rotate : Voice -> Direction -> Voice
rotate voice direction =
    case elemIndex voice.pattern patterns of
        Just n ->
            case direction of
                Model.Left ->
                    { voice | pattern = getPatternAt ((n - 1) % List.length patterns) }

                Model.Right ->
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
