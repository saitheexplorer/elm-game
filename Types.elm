module Types where

type Direction = Left | Right

type alias Keys = {x: Int, y: Int, space: Bool}

type alias Model =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  , dir : Direction
  , isShooting : Bool
  }
