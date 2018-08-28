module ExtraHtml exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

checkbox : msg -> String -> Html msg
checkbox msg name = 
    label []
        [ input [ type_ "checkbox", onClick msg ] []
        , text name
        ]