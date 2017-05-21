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
                [ h3 [] [ text (showScore model.score) ] ]
            ]
        , div [ class "row" ]
            [ div [ class "columns" ]
                [ h3 [] [ text (showClock model.clock) ] ]
            ]
        , showPatttern model.voice
        ]


showPatttern : Phrase -> Html Msg
showPatttern voice =
    case voice.pattern of
        Model.Whole ->
            div [ class "row align-center" ]
                [ whole
                , rotateArrow
                ]

        Model.HalfDotQuart ->
            div [ class "row align-center" ]
                [ halfDot
                , quarter
                , rotateArrow
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


rotateArrow : Html Msg
rotateArrow =
    div [ class "column small-1" ]
        [ a [ class "expanded hollow warning button", onClick Rotate ] [ text "⮞" ]
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
