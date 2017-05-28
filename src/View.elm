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
        , controls
        , debugScore model.score
        , debugClock model.clock
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



-- DEBUG


debugScore : Score -> Html Msg
debugScore score =
    div [ class "row" ]
        [ div [ class "columns" ]
            [ h3 [] [ text (showScore score) ] ]
        ]


debugClock : Int -> Html Msg
debugClock clock =
    div [ class "row" ]
        [ div [ class "columns" ]
            [ h3 [] [ text (showClock clock) ] ]
        ]


showScore : Score -> String
showScore score =
    List.map .frequency score
        |> List.map toString
        |> String.join ", "


showClock : Int -> String
showClock clock =
    case (clock < 2) of
        True ->
            toString 4

        False ->
            toString (clock - 1)
