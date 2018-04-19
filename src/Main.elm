port module Main exposing (..)

import Student exposing (..)


import Html exposing (..)
import Time exposing (Time)
import Task


-- MODEL

type alias Model =
    { students: List Student
    , groups: List (List Student)
    , now: Maybe Time
    }


init : ( Model, Cmd Msg )
init =
    ( { students = []
      , groups = [[]]
      , now = Nothing 
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = StudentsReceived (List MarshalledStudent)
    | SetTime (Maybe Time)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StudentsReceived raw ->
            ({ model | students = (List.map unmarshal raw) }, getTime)
        SetTime time ->
            ({ model | now = time }, Cmd.none)



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ text "Students: "
        , text (toString model)
        ]





-- SUBSCRIPTIONS

-- port for listening for a msg from JavaScript
port loadUsers : (List MarshalledStudent -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
    loadUsers StudentsReceived


getTime : Cmd Msg
getTime = 
    Task.perform (Just >> SetTime) Time.now


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
