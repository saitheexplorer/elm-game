module Input where

import Signal
import Keyboard
import Time

type alias Keys =
  { x : Int
  , y : Int
  , space : Bool
  }

mergeKeys : {x : Int, y : Int} -> Bool -> Keys
mergeKeys keys spacebar =
  { x = keys.x
  , y = keys.y
  , space = spacebar
  }

input : Signal (Float, Keys)
input =
  let
    delta = Signal.map (\t -> t/20) (Time.fps 30)
    keys = Signal.map2 mergeKeys Keyboard.arrows Keyboard.space
  in
    Signal.sampleOn delta (Signal.map2 (,) delta keys)
