module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (Model, Voice, Score)
import Update exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ title
        , showPattern model.octave
        , showPattern model.fifth
        , showPattern model.third
        , showPattern model.root
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


showPattern : Model.Voice -> Html Msg
showPattern voice =
    case .pattern voice of
        [] ->
            div [ class "row align-center" ] []

        ps ->
            div [ class "row align-center" ]
                ((List.map (\a -> renderAction a) ps) ++ [ rotateVoice voice ])


renderAction : Model.Action -> Html Msg
renderAction action =
    case action of
        Model.Play duration ->
            case duration of
                4 ->
                    whole

                2 ->
                    half

                1 ->
                    quarter

                _ ->
                    div [] []

        Model.Rest duration ->
            case duration of
                4 ->
                    wholeRest

                2 ->
                    halfRest

                1 ->
                    quarterRest

                _ ->
                    div [] []


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


wholeRest : Html Msg
wholeRest =
    div [ class "column small-4" ] [ text "\x2002" ]


halfRest : Html Msg
halfRest =
    div [ class "column small-2" ] [ text "\x2002" ]


quarterRest : Html Msg
quarterRest =
    div [ class "column small-1" ] [ text "\x2002" ]


rotateVoice : Voice -> Html Msg
rotateVoice voice =
    div [ class "column small-1" ]
        [ a [ class "expanded hollow warning button fa fa-chevron-right", onClick (Rotate voice) ] []
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



-- hack to show clock correctly


showClock : Int -> String
showClock clock =
    case clock % 4 of
        1 ->
            toString 4

        _ ->
            toString (clock - 1)
