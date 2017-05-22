module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (Model, Phrase, Score)
import Update exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [ class "row" ]
            [ div [ class "columns" ]
                [ h1 [] [ text "mimina" ] ]
            ]
        , showPatttern model.octave
        , showPatttern model.fifth
        , showPatttern model.third
        , showPatttern model.root
        , div [ class "row align-center" ]
            [ div [ class "column small-2" ]
                [ a [ class "expanded hollow button", onClick Pause ] [ text "Pause" ]
                ]
            , div [ class "column small-2" ]
                [ a [ class "expanded hollow button", onClick Play ] [ text "Play" ]
                ]
            ]
        , div [ class "row" ]
            [ div [ class "columns" ]
                [ h3 [] [ text (showScore model.score) ] ]
            ]
        , div [ class "row" ]
            [ div [ class "columns" ]
                [ h3 [] [ text (showClock model.clock) ] ]
            ]
        ]


showPatttern : Phrase -> Html Msg
showPatttern voice =
    case voice.pattern of
        Model.Whole ->
            div [ class "row align-center" ]
                [ whole
                , rotateVoice voice
                ]

        Model.HalfHalf ->
            div [ class "row align-center" ]
                [ half
                , half
                , rotateVoice voice
                ]

        Model.HalfRest ->
            div [ class "row align-center" ]
                [ half
                , rest
                , rest
                , rotateVoice voice
                ]

        Model.RestHalf ->
            div [ class "row align-center" ]
                [ rest
                , rest
                , half
                , rotateVoice voice
                ]

        Model.QuartRestQuartRest ->
            div [ class "row align-center" ]
                [ quarter
                , rest
                , quarter
                , rest
                , rotateVoice voice
                ]

        Model.RestQuartRestQuart ->
            div [ class "row align-center" ]
                [ rest
                , quarter
                , rest
                , quarter
                , rotateVoice voice
                ]

        Model.QuartRestRestRest ->
            div [ class "row align-center" ]
                [ quarter
                , rest
                , rest
                , rest
                , rotateVoice voice
                ]

        Model.RestQuartRestRest ->
            div [ class "row align-center" ]
                [ rest
                , quarter
                , rest
                , rest
                , rotateVoice voice
                ]

        Model.RestRestQuartRest ->
            div [ class "row align-center" ]
                [ rest
                , rest
                , quarter
                , rest
                , rotateVoice voice
                ]

        Model.RestRestRestQuart ->
            div [ class "row align-center" ]
                [ rest
                , rest
                , rest
                , quarter
                , rotateVoice voice
                ]

        Model.Rest ->
            div [ class "row align-center" ]
                [ rest
                , rest
                , rest
                , rest
                , rotateVoice voice
                ]


whole : Html Msg
whole =
    div [ class "column small-4" ]
        [ a [ class "expanded button" ] [ text "\x2002" ] -- unicode space here
        ]


halfDot : Html Msg
halfDot =
    div [ class "column small-3" ]
        [ a [ class "expanded button" ] [ text "\x2002" ]
        ]


half : Html Msg
half =
    div [ class "column small-2" ]
        [ a [ class "expanded button" ] [ text "\x2002" ]
        ]


quarter : Html Msg
quarter =
    div [ class "column small-1" ]
        [ a [ class "expanded button" ] [ text "\x2002" ]
        ]


rest : Html Msg
rest =
    div [ class "column small-1" ] [ text "\x2002" ]


rotateVoice : Phrase -> Html Msg
rotateVoice voice =
    div [ class "column small-1" ]
        [ a [ class "expanded hollow warning button", onClick (Rotate voice) ] [ text "⮞" ]
        ]



-- showPhrase : Phrase -> String
-- showPhrase phrase =
--     List.map .frequency phrase
--         |> List.map toString
--         |> String.join ", "


showScore : Score -> String
showScore score =
    List.map .frequency score
        |> List.map toString
        |> String.join ", "



-- hack to show clock correctly


showClock : Int -> String
showClock clock =
    case clock % 4 of
        1 ->
            toString 4

        _ ->
            toString (clock - 1)
