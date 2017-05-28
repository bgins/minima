module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (Model, Voice, Score, Direction)
import Update exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ title
        , showRow model.octave
        , showRow model.fifth
        , showRow model.third
        , showRow model.root
        , instructions model.clock
        ]


title : Html Msg
title =
    div [ class "row" ]
        [ div [ class "columns" ]
            [ h1 [] [ text "minima" ] ]
        ]


controls : Html Msg
controls =
    div [ class "row align-center" ]
        [ div [ class "column small-1" ]
            [ a [ class "expanded hollow button fa fa-pause", onClick Pause ] []
            ]
        , div [ class "column small-1" ]
            [ a [ class "expanded hollow button fa fa-play", onClick Play ] []
            ]
        ]


instructions : Int -> Html Msg
instructions clock =
    div [ class "row align-center" ]
        [ div [ class "column small-6" ]
            [ p []
                [ text "Minima is a playground for experimenting with minimalist musical patterns. Press "
                , a [ class "control fa fa-play", onClick Play ] []
                , text "to start the music and"
                , a [ class "control fa fa-pause", onClick Pause ] []
                , text "to stop it."
                , text " Select patterns with the "
                , a [ class "control secondary fa fa-chevron-left" ] []
                , text "and  "
                , a [ class "control secondary fa fa-chevron-right" ] []
                , text "buttons. Minima has four beats, and the current beat is "
                , span [ class "clock" ] [ text (showClock clock) ]
                , text ". Have fun and I hope you enjoy!"
                ]
            ]
        ]


showRow : Model.Voice -> Html Msg
showRow voice =
    case .pattern voice of
        [] ->
            div [ class "row align-center" ] []

        ps ->
            div [ class "row align-center" ]
                ((rotateVoice voice Model.Left)
                    :: (List.map (\a -> renderAction a) ps)
                    ++ [ rotateVoice voice Model.Right ]
                )


renderAction : Model.Action -> Html Msg
renderAction action =
    let
        width duration =
            "column small-" ++ toString duration
    in
        case action of
            Model.Play duration ->
                div [ class (width duration) ]
                    [ a [ class "expanded button" ] [ text "\x2002" ] -- unicode space here
                    ]

            Model.Rest duration ->
                div [ class (width duration) ]
                    [ text "\x2002" ]


rotateVoice : Voice -> Direction -> Html Msg
rotateVoice voice direction =
    div [ class "column small-1" ]
        [ case direction of
            Model.Left ->
                a [ class "expanded hollow secondary button fa fa-chevron-left", onClick (Rotate voice direction) ] []

            Model.Right ->
                a [ class "expanded hollow secondary button fa fa-chevron-right", onClick (Rotate voice direction) ] []
        ]


showClock : Int -> String
showClock clock =
    case clock of
        0 ->
            "0"

        1 ->
            "4"

        _ ->
            toString (clock - 1)



-- DEBUG
-- debugScore : Score -> Html Msg
-- debugScore score =
--     div [ class "row" ]
--         [ div [ class "columns" ]
--             [ h3 [] [ text (showScore score) ] ]
--         ]
-- debugClock : Int -> Html Msg
-- debugClock clock =
--     div [ class "row" ]
--         [ div [ class "columns" ]
--             [ h3 [] [ text (showClock clock) ] ]
--         ]
-- showScore : Score -> String
-- showScore score =
--     List.map .frequency score
--         |> List.map toString
--         |> String.join ", "
-- showClock : Int -> String
-- showClock clock =
--     case (clock < 2) of
--         True ->
--             toString 4
--         False ->
--             toString (clock - 1)
