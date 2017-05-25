module Model exposing (..)


type alias Model =
    { score : Score
    , root : Voice
    , third : Voice
    , fifth : Voice
    , octave : Voice
    , ticks : Int
    , clock : Int
    }


model =
    { score =
        [ Note 440 4 1
        , Note 550 1 1
        , Note 550 1 3
        , Note 660 1 2
        , Note 880 1 2
        , Note 880 1 4
        ]
    -- { score =
    --     [ Note 440 1 1
    --     , Note 550 1 2
    --     , Note 660 1 3
    --     , Note 880 1 4
    --     ]
    , root = Voice "root" 440 [ Play 4 ]
    , third = Voice "third" 550 [ Play 1, Rest 1, Play 1, Rest 1]
    , fifth = Voice "fifth" 660 [ Rest 1, Play 1, Rest 1, Rest 1 ]
    , octave = Voice "octave" 880 [ Rest 1, Play 1, Rest 1, Play 1 ]
    -- , root = Voice "root" 440 [ Play 1, Rest 1, Rest 1, Rest 1 ]
    -- , third = Voice "third" 550 [ Rest 1, Play 1, Rest 1, Rest 1 ]
    -- , fifth = Voice "fifth" 660 [ Rest 1, Rest 1, Play 1, Rest 1 ]
    -- , octave = Voice "octave" 880 [ Rest 1, Rest 1, Rest 1, Play 1 ]
    , ticks = 4
    , clock = 0
    }


type alias Score =
    List Note


type alias Voice =
    { id : String
    , frequency : Float
    , pattern : List Action
    }


type alias Note =
    { frequency : Float
    , duration : Int
    , tick : Int
    }


type Action
    = Play Int
    | Rest Int

type alias Pattern =
    List Action

patterns : List Pattern
patterns =
    [ [ Play 4 ]
    , [ Play 2, Play 2 ]
    , [ Play 2, Rest 2 ]
    , [ Rest 2, Play 2 ]
    , [ Play 1, Rest 1, Play 1, Rest 1 ]
    , [ Rest 1, Play 1, Rest 1, Play 1 ]
    , [ Play 1, Rest 1, Rest 1, Rest 1 ]
    , [ Rest 1, Play 1, Rest 1, Rest 1 ]
    , [ Rest 1, Rest 1, Play 1, Rest 1 ]
    , [ Rest 1, Rest 1, Rest 1, Play 1 ]
    , [ Rest 4 ]
    ]



 -- { score =
 --        [ Note 440 4 1
 --        , Note 386.31 2 1
 --        , Note 386.31 2 3
 --        , Note 660 1 2
 --        , Note 660 1 4
 --        , Note 880 1 1
 --        , Note 880 1 3
 --        ]
    -- , root = Voice "root" 440 [ Play 4 ]
    -- , third = Voice "third" 386.31 [ Play 2, Play 2 ]
    -- , fifth = Voice "fifth" 660 [ Rest 1, Play 1, Rest 1, Play 1 ]
    -- , octave = Voice "octave" 880 [ Play 1, Rest 1, Play 1, Rest 1 ]
