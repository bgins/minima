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
        -- , showPattern model.fifth.pattern
        -- , showPattern model.third.pattern
        -- , showPattern model.root.pattern
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
                -- (List.map (\a -> renderAction a) ps)
                (List.map (\a -> renderAction a) ps) ++ (rotateVoice voice)


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



-- rest : Html Msg
-- rest =
--     div [ class "column small-1" ] [ text "\x2002" ]


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



-- showPatttern : Voice -> Html Msg
-- showPatttern voice =
--     case voice.pattern of
--         Model.Whole ->
--             div [ class "row align-center" ]
--                 [ whole
--                 , rotateVoice voice
--                 ]
--         Model.HalfHalf ->
--             div [ class "row align-center" ]
--                 [ half
--                 , half
--                 , rotateVoice voice
--                 ]
--         Model.HalfRest ->
--             div [ class "row align-center" ]
--                 [ half
--                 , rest
--                 , rest
--                 , rotateVoice voice
--                 ]
--         Model.RestHalf ->
--             div [ class "row align-center" ]
--                 [ rest
--                 , rest
--                 , half
--                 , rotateVoice voice
--                 ]
--         Model.QuartRestQuartRest ->
--             div [ class "row align-center" ]
--                 [ quarter
--                 , rest
--                 , quarter
--                 , rest
--                 , rotateVoice voice
--                 ]
--         Model.RestQuartRestQuart ->
--             div [ class "row align-center" ]
--                 [ rest
--                 , quarter
--                 , rest
--                 , quarter
--                 , rotateVoice voice
--                 ]
--         Model.QuartRestRestRest ->
--             div [ class "row align-center" ]
--                 [ quarter
--                 , rest
--                 , rest
--                 , rest
--                 , rotateVoice voice
--                 ]
--         Model.RestQuartRestRest ->
--             div [ class "row align-center" ]
--                 [ rest
--                 , quarter
--                 , rest
--                 , rest
--                 , rotateVoice voice
--                 ]
--         Model.RestRestQuartRest ->
--             div [ class "row align-center" ]
--                 [ rest
--                 , rest
--                 , quarter
--                 , rest
--                 , rotateVoice voice
--                 ]
--         Model.RestRestRestQuart ->
--             div [ class "row align-center" ]
--                 [ rest
--                 , rest
--                 , rest
--                 , quarter
--                 , rotateVoice voice
--                 ]
--         Model.Rest ->
--             div [ class "row align-center" ]
--                 [ rest
--                 , rest
--                 , rest
--                 , rest
--                 , rotateVoice voice
--                 ]



-- showPattern : Model.Pattern -> Html Msg
-- showPattern pattern =
--     case List.head pattern of
--         Nothing ->
--             []
--         Model.Play duration ->
--             let
--                 length =
--                     "column small-" ++ toString (duration)
--             in
--                 [ div [ class length ]
--                     [ a [ class "expanded button" ] [ text "\x2002" ] -- unicode space here
--                     ] ,   showPattern (List.tail pattern) ]
--         Model.Rest duration ->
--             let
--                 length =
--                     "column small-" ++ toString (duration)
--             in
--                 div [ class length ] [ text "\x2002" ]
--                     :: showPattern (List.tail pattern)
-- showPattern : Model.Pattern -> Html Msg
-- showPattern pattern =
--     case pattern of
--         _ ->
--             []
--         p :: ps ->
--             case p of
--                 Model.Play duration ->
--                     let
--                         length =
--                             "column small-" ++ toString (duration)
--                     in
--                         div [ class length ]
--                             [ a [ class "expanded button" ] [ text "\x2002" ] -- unicode space here
--                             ]
--                             :: showPattern ps
--                 Model.Rest duration ->
--                     let
--                         length =
--                             "column small-" ++ toString (duration)
--                     in
--                         div [ class length ] [ text "\x2002" ]
--                             :: showPattern ps


-- showPattern : Model.Pattern -> Html Msg
-- showPattern pattern =
--     case pattern of
--         [] ->
--             div [ class "row align-center" ] []

--         ps ->
--             div [ class "row align-center" ]
--                 (List.map (\a -> renderAction a) ps)

-- showPattern : Model.Voice -> Html Msg
-- showPattern voice =
--     case .pattern voice of
--         [] ->
--             div [ class "row align-center" ] []

--         ps ->
--             div [ class "row align-center" ]
--                 -- List.concat [(List.map (\a -> renderAction a) ps) ++ [rotateVoice voice]]
--                 -- List.concat ((List.map (\a -> renderAction a) ps) :: [[rotateVoice voice]])
--                 (List.map (\a -> renderAction a) ps) ++ (rotateVoice voice)
