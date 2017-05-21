module View exposing (..)

import Html exposing (..)
import Model exposing (Model, Phrase)
import Update exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text (showPhrase model.phrase) ]
        , h3 [] [ text (showClock model.clock) ]
        ]


showPhrase : Phrase -> String
showPhrase phrase =
    List.map .frequency phrase
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
