module Model exposing (..)


type alias Model =
    { score : Score
    , voice : Phrase
    , ticks : Int
    , clock : Int
    }


-- model =
--     { phrase =
--         [ Note 440 4 1
--         , Note 660 4 3
--         , Note 880 0.5 1
--         , Note 1320 0.5 2
--         , Note 1760 0.5 3
--         , Note 1320 0.5 4
--         ]
--     , ticks = 4
--     , clock = 1
--     }

model =
    { score =
        [ Note 440 4 1
        , Note 660 4 3
        , Note 880 0.5 1
        , Note 1320 0.5 2
        , Note 1760 0.5 3
        , Note 1320 0.5 4
        ]
    , ticks = 4
    , clock = 1
    }


type alias Score =
    List Note

type alias Phrase =
    { frequency : Float
    , pattern : Pattern
    -- , some identifier to access dom element
    }


type alias Note =
    { frequency : Float
    , duration : Float
    , tick : Int
    }



-- type alias Phrase =
--     List Note


type Pattern
    = Whole
    | HalfDotQuart
    | QuartHalfDot
    | HalfHalf
    | HalfQuartQuart
    | QuartHalfQuart
    | QuartQuartHalf
    | Quarters



-- | Nothing


-- type alias Whole =
--     List Maybe Note


-- type alias HalfDotQuart =
--     List Maybe Note


-- type alias QuartHalfDot =
--     List Maybe Note


-- type alias HalfHalf =
--     List Maybe Note


-- type alias HalfQuartQuart =
--     List Maybe Note


-- type alias QuartHalfQuart =
--     List Maybe Note


-- type alias QuartQuartHalf =
--     List Maybe Note


-- type alias Quarters =
--     List Maybe Note
