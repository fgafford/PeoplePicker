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
import Strategies exposing (..)

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

{-/| group
  This function takes a Strategy, number of desired groups,
  list of students and returns them in fairly divided groups.
-}
-- group : Strategy -> Int -> Students -> List Group