module Update exposing (..)

import Time exposing (Time)
import Model exposing (..)
import Ports exposing (..)


-- type Msg
--     = Tick Time


type Msg
    = Tick Time
    | Rotate Pattern



-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     case msg of
--         Tick time ->
--             { model
--                 | clock = increment model.clock
--             }
--                 ! [ Cmd.batch (playNote model.phrase model.clock) ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            { model
                | clock = increment model.clock
            }
                ! [ Cmd.batch (playNotes model.score model.clock) ]

        -- Rotate pattern phrase ->
        --     { model
        --         | score = read pattern phrase model.score
        --         , voice = rotate model.voice pattern
        --     }
        --         ! [ Cmd.none ]
        Rotate pattern ->
            { model
                | score = read pattern model.voice model.score
                , voice = rotate model.voice pattern
            }
                ! [ Cmd.none ]



-- playNote : Phrase -> Int -> List (Cmd msg)
-- playNote phrase clock =
--     List.filter (\n -> .tick n == clock) phrase
--         |> List.map play


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


read : Pattern -> Phrase -> Score -> Score
read pattern phrase score =
    case pattern of
        Whole ->
            filterFrequency phrase score
                |> (++) [Note (.frequency phrase) 4 1 ]

        HalfDotQuart ->
            filterFrequency phrase score
                |> (++) [Note (.frequency phrase) 3 1 ]
                |> (++) [ Note (.frequency phrase) 1 4 ]

filterFrequency : Phrase -> Score -> Score
filterFrequency phrase score =
            List.filter (\n -> .frequency n /= .frequency phrase) score



-- clean out note events, add in new ones
-- how to handle rests? Separate function?


rotate : Phrase -> Pattern -> Phrase
rotate voice pattern =
    case pattern of
        Whole ->
            { voice | pattern = HalfDotQuart }

        HalfDotQuart ->
            { voice | pattern = HalfDotQuart }


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
