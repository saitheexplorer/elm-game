import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Color exposing (..)
import Signal
import Keyboard
import Time
import Debug
import Window

import Types exposing ( Model, Keys )
import View exposing ( view )
import Input exposing ( input )

robot : Model
robot =
  { x = 0
  , y = 0
  , vx = 0
  , vy = 0
  , dir = Types.Right
  , isShooting = False
  }

walk : Keys -> Model -> Model
walk keys model =
  { model |
      vx = toFloat keys.x * 5
    , dir =
        if keys.x < 0 then Types.Left
        else if keys.x > 0 then Types.Right
        else model.dir
  }

shoot : Keys -> Model -> Model
shoot keys model =
  { model |
      isShooting = keys.space
  }

jump : Keys -> Model -> Model
jump keys model =
  if keys.y > 0 && model.vy == 0 then
    { model | vy = 6.0 }
  else model

gravity : Float -> Model -> Model
gravity dt model =
  { model |
      vy = if model.y > 0 then model.vy - dt/4 else 0
  }

physics : Float -> Model -> Model
physics dt model =
  { model |
      x = max 0 (model.x + dt * model.vx)
    , y = max 0 (model.y + dt * model.vy)
  }

update : (Float, Keys) -> Model -> Model
update (dt, keys) model =
  let
    log = Debug.watch "keys" (model.isShooting)
  in
    model
      |> gravity dt
      |> walk keys
      |> jump keys
      |> shoot keys
      |> physics dt

-- SIGNALS

main : Signal Element
main =
  let
    state = Signal.foldp update robot input
  in
    Signal.map2 view Window.dimensions state

