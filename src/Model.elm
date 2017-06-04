module Model exposing (..)


type alias Model =
    { score : Score
    , one : Voice
    , two : Voice
    , three : Voice
    , four : Voice
    , ticks : Int
    , clock : Int
    }


model =
    { score =
        [ Note 385 2 1
        , Note 385 2 3
        , Note 440 4 1
        , Note 660 1 2
        , Note 660 1 4
        , Note 880 1 1
        , Note 880 1 3
        ]
    , one = Voice "one" 385 [ Play 2, Play 2 ] -- 7/8
    , two = Voice "two" 440 [ Play 4 ] -- 1/1
    , three = Voice "three" 660 [ Rest 1, Play 1, Rest 1, Play 1 ] -- 3/2
    , four = Voice "four" 880 [ Play 1, Rest 1, Play 1, Rest 1 ] -- 2/1
    , ticks = 4
    , clock = 0
    }



-- SCORE


type alias Score =
    List Note


type alias Note =
    { frequency : Float
    , duration : Int
    , tick : Int
    }



-- VOICE


type alias Voice =
    { id : String
    , frequency : Float
    , pattern : Pattern
    }


type alias Pattern =
    List Action


type Action
    = Play Int
    | Rest Int


type Direction
    = Left
    | Right


patterns : List Pattern
patterns =
    [ [ Play 4 ]
    , [ Play 2, Play 2 ]
    , [ Play 2, Rest 2 ]
    , [ Rest 2, Play 2 ]
    , [ Play 1, Rest 1, Play 1, Rest 1 ]
    , [ Rest 1, Play 1, Rest 1, Play 1 ]
    , [ Play 1, Rest 3 ]
    , [ Rest 1, Play 1, Rest 2 ]
    , [ Rest 2, Play 1, Rest 1 ]
    , [ Rest 3, Play 1 ]
    , [ Rest 4 ]
    ]



-- major chord
-- { score =
--     [ Note 440 4 1
--     , Note 550 1 1
--     , Note 550 1 3
--     , Note 660 1 2
--     , Note 880 1 2
--     , Note 880 1 4
--     ]
-- , one = Voice "one" 440 [ Play 4 ]
-- , two = Voice "two" 550 [ Play 1, Rest 1, Play 1, Rest 1 ]
-- , three = Voice "three" 660 [ Rest 1, Play 1, Rest 1, Rest 1 ]
-- , four = Voice "four" 880 [ Rest 1, Play 1, Rest 1, Play 1 ]
