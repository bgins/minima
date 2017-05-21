module Model exposing (..)

type alias Model =
    { phrase : Phrase
    , ticks : Int
    , clock : Int
    }


type alias Phrase =
    List Note



-- type Phrase
--     = Four
--     | ThreeOne
--     | OneThree
--     | TwoTwo
--     | TwoOneOne
--     | OneTwoOne
--     | OneOneTwo
--     | OneOneOneOne
-- | Nothing


type alias Note =
    { frequency : Float
    , duration : Float
    , tick : Int
    }


model =
    { phrase =
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


