module Player where

import Direction exposing (Direction)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Input exposing (Keys)

type alias Player =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  , dir : Direction.Direction
  , isShooting : Bool
  , canFall : Bool
  }

initial : Player
initial =
  { x = 0
  , y = 0
  , vx = 0
  , vy = 0
  , dir = Direction.Right
  , isShooting = False
  , canFall = True
  }

walk : Keys -> Player -> Player
walk keys player =
  { player |
      vx = toFloat keys.x * 5
    , dir =
        if keys.x < 0 then Direction.Left
        else if keys.x > 0 then Direction.Right
        else player.dir
  }

shoot : Keys -> Player -> Player
shoot keys player =
  { player | isShooting = keys.space }

jump : Keys -> Player -> Player
jump keys player =
  if keys.y > 0 && player.vy == 0 then { player | vy = 6.0 }
  else player

update : Keys -> Player -> Player
update keys player =
  player
    |> walk keys
    |> jump keys
    |> shoot keys

view : Player -> Form
view player =
  let
    verb =
      if player.y > 0 && player.isShooting then "jump_shoot"
      else if player.y > 0 then "jump"
      else if player.vx /= 0 then "run"
      else if player.isShooting then "shoot"
      else "stand"

    dir =
      case player.dir of
        Direction.Left -> "left"
        Direction.Right -> "right"
  in
    "/assets/img/player/" ++ verb ++ "_" ++ dir ++ ".gif"
      |> image 120 120
      |> toForm
      |> move (player.x, player.y)

main : Element
main =
  collage 400 400 [ view initial ]
