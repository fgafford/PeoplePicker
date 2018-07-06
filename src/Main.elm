port module Main exposing (..)

import Student exposing (..)
import Grouper exposing (..)
import Dict exposing (..)

import Time exposing (Time)
import Task

import Html exposing (..)
import Html.Attributes exposing (..)

import Material
import Material.Scheme
import Material.Button as Button
import Material.Options as Options exposing (css)

-- MODEL

type alias Model =
    { students: List Student
    , groups: Dict String Group
    , now: Time
    , mdl: Material.Model
    }



init : ( Model, Cmd Msg )
init =
    ( { students = []
      , groups = singleton "Empty" emptyGroup
      , now = 1524222102.0
      , mdl = Material.model
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = StudentsReceived (List MarshalledStudent)
    | SetTime Time
    | Mdl (Material.Msg Msg)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StudentsReceived raw ->
            ({ model | students = (List.map unmarshal raw) }, getTime)
        SetTime time ->
            ({ model | now = time }, Cmd.none)
        Mdl msg_ ->
            Material.update Mdl msg_ model



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


-- VIEW



view : Model -> Html Msg 
view model =
    section [ id "main" ]
        [ h2 [ id "title" ] [ text "People Picker" ]
        , div [ id "totals"] [ studentStats model.students]
        , div [ id "studentList" ]  
            (model.students 
                |> List.map (studentInfo model.now))
        , div 
            [id "takeAttendence"] 
            [ Button.render Mdl [ 0 ] model.mdl
                [ css "margin" "0 24px"
                 , Button.raised
                 , Button.primary
                ]
                [ text "Take Attendance"]
            ]  |> Material.Scheme.top 
        ]
    
testView : Model -> Html Msg
testView model = 
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