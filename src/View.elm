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
                [ div [ class "column small-4" ]
                    [ a [ class "expanded button" ] []
                    ]
                , div [ class "column small-1" ]
                    [ a [ class "expanded warning button", onClick Rotate ] []
                    ]
                ]

        Model.HalfDotQuart ->
            div [ class "row align-center" ]
                [ div [ class "column small-3" ]
                    [ a [ class "expanded button" ] []
                    ]
                , div [ class "column small-1" ]
                    [ a [ class "expanded button" ] []
                    ]
                , div [ class "column small-1" ]
                    [ a [ class "expanded warning button", onClick Rotate ] []
                    ]
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
