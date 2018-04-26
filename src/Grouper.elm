{-
  The Grouper:
      /`·.¸
     /¸...¸`:·
 ¸.·´  ¸   `·.¸.·´)
: © ):´;      ¸  {
 `·.¸ `·  ¸.·´\`·¸)
     `\\´´\¸.·´

 This module is responcible for spliting persons into
 groups that are as equal as possible (fair-division).
-}
module Grouper exposing (..)

import Student exposing (..)

-- MODEL

type alias Group =
    { name: String
    , students: List Student
    , previouslySelected: List Student
    }

emptyGroup: Group
emptyGroup = 
  ( { name = "Empty"
    , students = []
    , previouslySelected = []
  })


group : Int -> Int
group a = a