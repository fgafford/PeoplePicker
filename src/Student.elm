module Student exposing (..)

import Date exposing (..)
import Time exposing (Time)
import Result exposing (toMaybe)
import DateUtils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL

type alias Student = 
  { firstName: String
  , lastName: String
  , birthdate: Maybe Date
  , sex: Sex
  }

type Sex = Male | Female

type alias MarshalledStudent = 
  { firstName: String
  , lastName: String
  , birthdate: String
  , sex: String
  }


-- FUNCTIONS

marshal : Student -> MarshalledStudent
marshal student = 
  let
      sex = case student.sex of
              Male ->
                "M"
              Female ->
                "F"
      birthdate = case student.birthdate of
              Just bdate ->
                (toString (year bdate)) ++ "-" ++ (toString (month bdate)) ++ "-" ++ (toString (day bdate))
              Nothing ->
                ""
  in
    {
      firstName = student.firstName
      , lastName = student.lastName
      , birthdate = birthdate
      , sex = sex
    }      

unmarshal : MarshalledStudent -> Student
unmarshal student = 
  let
    sex = case student.sex of
      "Male" -> 
        Male
      "M" -> 
        Male
      "Female" -> 
        Female
      "F" -> 
        Female
      _ -> 
        Female
  in
    {
      firstName = student.firstName
      , lastName = student.lastName
      , birthdate = toMaybe (fromString student.birthdate)
      , sex = sex
    }

fullName : Student -> String
fullName kid =
  kid.firstName ++ " " ++ kid.lastName

age : Time -> Student -> Maybe Int
age now s = 
  case s.birthdate of 
    Just b ->
      Just <| currentAge b now
    Nothing ->
      Nothing


-- hasBirthdaySoon: Student -> Bool


-- VIEW
  
studentInfo : Student ->  Html msg
studentInfo s = 
  div [ id "studentInfo" ] 
      [ ul [ class "studentAttrsList" ]
          [ li [ class "studentAttr" ] [ text <| "Name: " ++ s.firstName ++ " " ++ s.lastName]
          , li [ class "studentAttr" ] [ text <| "Sex: " ++ (toString s.sex) ]
          , li [ class "studentAttr" ] [ text <| "Age: " ++ "0" ]
          ]
      ]
