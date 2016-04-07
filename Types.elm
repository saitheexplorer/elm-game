module Types where

type Direction = Left | Right

type alias Keys = {x: Int, y: Int, space: Bool}

type alias Body b =
  { b |
      x : Float
    , y : Float
    , vx : Float
    , vy : Float
    , dir : Direction
  }

type alias Model =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  , dir : Direction
  , isShooting : Bool
  }

type alias Bullet =
  { x : Float
  , y : Float
  , vx : Float
  , x0 : Float
  , dir : Direction
  }

type alias State =
  { model : Model
  , bullets : List Bullet
  }
