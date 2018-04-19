module DateUtils exposing (isAfter)

import Date exposing (..)
import Time exposing (Time)

asInt : Month -> Int
asInt m =
  case m of
    Jan -> 1
    Feb -> 2
    Mar -> 3
    Apr -> 4
    May -> 5
    Jun -> 6
    Jul -> 7
    Aug -> 8
    Sep -> 9
    Oct -> 10
    Nov -> 11
    Dec -> 12

currentAge : Date -> Int
currentAge d = 1

