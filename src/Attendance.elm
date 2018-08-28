{--
  Attendance.elm

  Module for taking attendance of who is and is not here.
--}
module Attendance exposing (..)

import Student exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import ExtraHtml exposing (..)


-- MODEL

-- UPDATE

type Msg 
    = MarkAsPresent Student
    | MarkAsAbsent Student

-- SUBSCRIPTION

-- VIEW

attendanceList : List Student -> List (Html msg)
attendanceList s =
    s 
    |> List.map fullName
    |> List.map (\name -> (div [] [(checkbox UpdateAttendance name)]))
    |> List.map List.singleton
    |> List.map (div [])