port module Main exposing (..)

import Student exposing (..)


import Html exposing (..)
import Time exposing (Time)
import Task


-- MODEL

type alias Model =
    { students: List Student
    , groups: List (List Student)
    , now: Time
    }


init : ( Model, Cmd Msg )
init =
    ( { students = []
      , groups = [[]]
      , now = 1524222102.0 
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = StudentsReceived (List MarshalledStudent)
    | SetTime Time

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
        [ div []
          [
            text "Students: "
            , text (toString model.students)
          ]
          , hr [][]
          , div [] [
              text "Ages: "
              , text (model.students
                        |> List.map (age model.now)
                        |> List.map (Maybe.withDefault 0)
                        |> List.map toString
                        |> toString)
          ]
        ]




-- SUBSCRIPTIONS

-- port for listening for a msg from JavaScript
port loadUsers : (List MarshalledStudent -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model =
    loadUsers StudentsReceived


getTime : Cmd Msg
getTime = 
    Task.perform SetTime Time.now


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
