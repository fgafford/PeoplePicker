port module Main exposing (..)

import Student exposing (..)

import Html exposing (..)
-- import Html.Attributes


-- MODEL


type alias Model =
    { students: List Student
    }


init : ( Model, Cmd Msg )
init =
    ( { students = []}
    , Cmd.none
    )



-- UPDATE


type Msg
    = StudentsReceived (List MarshalledStudent)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StudentsReceived raw ->
            ( { model | students = (List.map unmarshal raw) }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ text "Students: "
        , text (toString model.students)
        ]





-- SUBSCRIPTIONS

-- port for listening for a msg from JavaScript
port loadUsers : (List MarshalledStudent -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
    loadUsers StudentsReceived


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
