module Update exposing (Msg(..), filterFrequency, getPatternAt, increment, playNotes, read, readPattern, rotate, update)

import List.Extra exposing (elemIndex, getAt)
import Model exposing (..)
import Ports exposing (..)
import Time exposing (Posix)


type Msg
    = Tick Posix
    | Play
    | Pause
    | Rotate Voice Direction


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            ( { model
                | clock = increment model.clock model.ticks
              }
            , Cmd.batch (playNotes model.score model.clock)
            )

        Play ->
            ( { model | clock = 1 }
            , Cmd.none
            )

        Pause ->
            ( { model | clock = 0 }
            , Cmd.none
            )

        Rotate voice direction ->
            case voice.id of
                "one" ->
                    ( { model
                        | one = rotate voice direction
                        , score = read voice direction model.score
                      }
                    , Cmd.none
                    )

                "two" ->
                    ( { model
                        | two = rotate voice direction
                        , score = read voice direction model.score
                      }
                    , Cmd.none
                    )

                "three" ->
                    ( { model
                        | three = rotate voice direction
                        , score = read voice direction model.score
                      }
                    , Cmd.none
                    )

                "four" ->
                    ( { model
                        | four = rotate voice direction
                        , score = read voice direction model.score
                      }
                    , Cmd.none
                    )

                _ ->
                    ( model
                    , Cmd.none
                    )


increment : Int -> Int -> Int
increment clock ticks =
    case clock of
        0 ->
            0

        _ ->
            modBy ticks clock + 1


playNotes : Score -> Int -> List (Cmd msg)
playNotes score clock =
    List.filter (\n -> .tick n == clock) score
        |> List.map play



-- READ


read : Voice -> Direction -> Score -> Score
read voice direction score =
    readPattern 1 voice (.pattern (rotate voice direction)) score
        ++ filterFrequency voice score


readPattern : Int -> Voice -> Pattern -> Score -> Score
readPattern count voice pattern score =
    case pattern of
        [] ->
            []

        p :: ps ->
            case p of
                Model.Play n ->
                    Note (.frequency voice) n count
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
                    { voice | pattern = getPatternAt (modBy (List.length patterns) (n - 1)) }

                Model.Right ->
                    { voice | pattern = getPatternAt (modBy (List.length patterns) (n + 1)) }

        Nothing ->
            { voice | pattern = voice.pattern }


getPatternAt : Int -> Pattern
getPatternAt index =
    case getAt index patterns of
        Just pattern ->
            pattern

        Nothing ->
            []
