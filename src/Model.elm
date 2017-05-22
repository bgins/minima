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


model =
    { score =
        [ Note 440 4 1
        , Note 386.31 2 1
        , Note 386.31 2 3
        , Note 660 1 2
        , Note 660 1 4
        , Note 880 1 1
        , Note 880 1 3
        ]
    , root = Phrase "root" 440 Whole
    , third = Phrase "third" 386.31 HalfHalf
    , fifth = Phrase "fifth" 660 RestQuartRestQuart
    , octave = Phrase "octave" 880 QuartRestQuartRest
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
    | HalfHalf
    | HalfRest
    | RestHalf
    | QuartRestQuartRest
    | RestQuartRestQuart
    | QuartRestRestRest
    | RestQuartRestRest
    | RestRestQuartRest
    | RestRestRestQuart

