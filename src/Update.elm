module Update exposing (..)

import Time exposing (Time)
import Model exposing (..)
import Ports exposing (..)


type Msg
    = Tick Time
    | Play
    | Pause
    | Rotate Phrase
    | Read Phrase


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


read : Phrase -> Score -> Score
read voice score =
    case .pattern (rotate voice) of
        Whole ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 4 1 ]

        HalfHalf ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 2 1 ]
                |> (++) [ Note (.frequency voice) 2 3 ]

        HalfRest ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 2 1 ]

        RestHalf ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 2 3 ]

        QuartRestQuartRest ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 1 1 ]
                |> (++) [ Note (.frequency voice) 1 3 ]

        RestQuartRestQuart ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 1 2 ]
                |> (++) [ Note (.frequency voice) 1 4 ]

        QuartRestRestRest ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 1 1 ]

        RestQuartRestRest ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 1 2 ]

        RestRestQuartRest ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 1 3 ]

        RestRestRestQuart ->
            filterFrequency voice score
                |> (++) [ Note (.frequency voice) 1 4 ]

        Rest ->
            filterFrequency voice score


filterFrequency : Phrase -> Score -> Score
filterFrequency phrase score =
    List.filter (\n -> .frequency n /= .frequency phrase) score


rotate : Phrase -> Phrase
rotate voice =
    case voice.pattern of
        Whole ->
            { voice | pattern = HalfHalf }

        HalfHalf ->
            { voice | pattern = HalfRest }

        HalfRest ->
            { voice | pattern = RestHalf }

        RestHalf ->
            { voice | pattern = QuartRestQuartRest }

        QuartRestQuartRest ->
            { voice | pattern = RestQuartRestQuart }

        RestQuartRestQuart ->
            { voice | pattern = QuartRestRestRest }

        QuartRestRestRest ->
            { voice | pattern = RestQuartRestRest }

        RestQuartRestRest ->
            { voice | pattern = RestRestQuartRest }

        RestRestQuartRest ->
            { voice | pattern = RestRestRestQuart }

        RestRestRestQuart ->
            { voice | pattern = Rest }

        Rest ->
            { voice | pattern = Whole }
