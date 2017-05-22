module Update exposing (..)

import Time exposing (Time)
import Model exposing (..)
import Ports exposing (..)
import Update.Extra exposing (updateModel, andThen, sequence)


type Msg
    = Tick Time
    | Rotate Phrase
    | Read Phrase



-- | RotateUI Phrase
-- | Read Phrase


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            { model
                | clock = increment model.clock
            }
                ! [ Cmd.batch (playNotes model.score model.clock) ]

        -- Rotate voice ->
        --     model
        --         ! []
        --         |> updateModel (\model -> { model | root = rotate model.root })
        --         |> updateModel (\model -> { model | score = read model.root model.score })
        Rotate voice ->
            case voice.id of
                "root" ->
                    { model
                        | root = rotate voice
                        , score = read voice model.score
                    }
                        ! []

                "third" ->
                    { model | third = rotate voice } ! []

                "fifth" ->
                    { model | fifth = rotate voice } ! []

                "octave" ->
                    { model | octave = rotate voice } ! []

                _ ->
                    { model | octave = rotate voice } ! []

        Read voice ->
            { model | score = read voice model.score } ! []



-- Rotate voice ->
--     model
--         ! []
--         |> updateModel
--             (case voice.id of
--                 "root" ->
--                     (\model -> { model | root = rotate voice })
--                 "third" ->
--                     (\model -> { model | third = rotate voice })
--                 "fifth" ->
--                     (\model -> { model | fifth = rotate voice })
--                 "octave" ->
--                     (\model -> { model | octave = rotate voice })
--                 _ ->
--                     (\model -> { model | octave = rotate voice })
--             )
--         |> updateModel (\model -> { model | score = read voice model.score })
-- Rotate voice ->
--     model
--         ! []
--         |> sequence update
--             [ (RotateUI voice)
--             , (Read voice)
--             ]
-- RotateUI voice ->
--     case voice.id of
--         "root" ->
--             { model | root = rotate voice } ! []
--         "third" ->
--             { model | third = rotate voice } ! []
--         "fifth" ->
--             { model | fifth = rotate voice } ! []
--         "octave" ->
--             { model | octave = rotate voice } ! []
--         _ ->
--             { model | octave = rotate voice } ! []
-- Read voice ->
--     { model | score = read voice model.score } ! []


increment : Int -> Int
increment clock =
    case clock of
        4 ->
            1

        _ ->
            clock + 1


playNotes : Score -> Int -> List (Cmd msg)
playNotes score clock =
    List.filter (\n -> .tick n == clock) score
        |> List.map play



-- read : Phrase -> Score -> Score
-- read voice score =
--     case voice.pattern of
--         Whole ->
--             filterFrequency voice score
--                 |> (++) [ Note (.frequency voice) 4 1 ]
--         HalfDotQuart ->
--             filterFrequency voice score
--                 |> (++) [ Note (.frequency voice) 3 1 ]
--                 |> (++) [ Note (.frequency voice) 1 4 ]


read : Phrase -> Score -> Score
read voice score =
    case .pattern (rotate voice) of
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
