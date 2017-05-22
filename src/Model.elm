module Model exposing (..)


type alias Model =
    { score : Score
    , root : Phrase
    , third : Phrase
    , fifth : Phrase
    , octave : Phrase
    , ticks : Int
    , clock : Int
    }



-- model =
--     { score =
--         [ Note 440 4 1
--         , Note 660 4 3
--         , Note 880 0.5 1
--         , Note 1320 0.5 2
--         , Note 1760 0.5 3
--         , Note 1320 0.5 4
--         ]
--     , voice = Phrase 440 HalfDotQuart
--     , ticks = 4
--     , clock = 1
--     }


model =
    { score =
        [ Note 440 4 1
        ]
    , root = Phrase "root" 440 Whole
    , third = Phrase "third" 386.31 Whole
    , fifth = Phrase "fifth" 660 Whole
    , octave = Phrase "octave" 880 Whole
    , ticks = 4
    , clock = 1
    }


type alias Score =
    List Note


type alias Phrase =
    { id : String
    , frequency : Float
    , pattern : Pattern
    }


type alias Note =
    { frequency : Float
    , duration : Float
    , tick : Int
    }


type Pattern
    = Whole
    | HalfDotQuart



-- | QuartHalfDot
-- | HalfHalf
-- | HalfQuartQuart
-- | QuartHalfQuart
-- | QuartQuartHalf
-- | Quarters
