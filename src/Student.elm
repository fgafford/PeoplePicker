module Student exposing (..)

import Date exposing (..)
-- import Json.Decode.Extra exposing (date)

type alias Student = 
  { firstName: String
  , lastName: String
  , birthdate: Date
  , sex: Sex
  }

type Sex = Male | Female

type alias MarshalledStudent = 
  { firstName: String
  , lastName: String
  , birthdate: Int
  , sex: String
  }

-- marshal : Student -> MarshalledStudent

unmarshal : MarshalledStudent -> Student
unmarshal student = 
  let 
    -- birthdate = 
    --   case (fromString student.birthdate)
    --     OK date -> 
    --       date
    --     Err ->
    --       Date.Now

    birthdate = (fromString (toString student.birthdate)) |> Result.withDefault (fromTime 0)
  in 
    {
      firstName = student.firstName
      , lastName = student.lastName
      , birthdate = birthdate
      , sex = Male
    }

fullName : Student -> String
fullName kid =
  kid.firstName ++ " " ++ kid.lastName

-- age : Student -> Int


-- hasBirthdaySoon: Student -> Bool