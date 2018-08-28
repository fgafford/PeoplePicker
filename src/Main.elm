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

import ExtraHtml exposing (..)

-- MODEL

type alias Model =
    { allStudents: List Student
    , present: List Student
    , groups: Dict String Group
    , now: Time
    , mdl: Material.Model
    }



init : ( Model, Cmd Msg )
init =
    ( { allStudents = []
      , present = []
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
    | UpdateAttendance Student
    | Mdl (Material.Msg Msg)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StudentsReceived raw ->
            ({ model | allStudents = (List.map unmarshal raw) }, getTime)
        SetTime time ->
            ({ model | now = time }, Cmd.none)
        UpdateAttendance s ->
            updateStudentsAttendenceStatus model s
        Mdl msg_ ->
            Material.update Mdl msg_ model



{- updateStudentsAttendenceStatus
    If student is not in list.... add them
    If student is in list... remove them
-}
updateStudentsAttendenceStatus : Model -> Student -> (Model, Cmd Msg)
updateStudentsAttendenceStatus model student = 
    case (studentPresent model student) of
        False ->
            ({ model | present = student :: model.present}, Cmd.none)
        True ->
            ({model | present = (List.filter (\s -> (studentPresent model s) && s /= student) model.present)}, Cmd.none) {-- TODO: remove them from list here --}

studentPresent : Model -> Student -> Bool
studentPresent model s = 
            List.filter (\x -> x == s) model.present
            |> (\l -> 1 == (List.length l))


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
        , span [ id "selector"] 
            [ (button model "All Students")
            , (button model "Present Students")
            ] 
        , div [ id "totals"] 
            [ studentStats model.allStudents]
        -- , div [ id "studentList" ]  
        --     (studentDetailsList model model.allStudents)
        , div [ id "attendanceList"]
            (attendanceList model.allStudents)
        , div [id "takeAttendence"] 
            [ button model "Take Attendance"]

        , div [ id "studentList" ]  
             (studentDetailsList model model.present)
        ]

button : Model -> String -> Html Msg
button m t = 
        span [ id "selector"] 
            [ Button.render Mdl [ 0 ] m.mdl
                [ css "margin" "0 24px"
                 , Button.raised
                 , Button.primary
                ]
                [ text t]
            ]  
            |> Material.Scheme.top

{--
    Show a detailed list of Students
--}
studentDetailsList : Model -> List Student -> List (Html Msg)
studentDetailsList m s = 
    s |> List.map (studentInfo m.now)

attendanceList : List Student -> List (Html Msg)
attendanceList students =
    students
    |> List.map (\s -> (div [] [(checkbox (UpdateAttendance s) (fullName s))]))
    |> List.map (\html -> (div [] [html]))

{--
    summaryView

    HTML statistics overview of a list of students.
--}
summaryView : Model -> List Student -> Html Msg
summaryView m s = 
      div
        []
        [ div []
          [ text "Students: "
          , text (toString s)
          ]
          , hr [][]
          , div [] [ text "Ages: "
                     , text (s
                        |> List.map (age m.now)
                        |> List.map (Maybe.withDefault 0)
                        |> List.map toString
                        |> toString)
          ]
        ]