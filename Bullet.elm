module Bullet where

import Direction exposing (Direction)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List
import Player exposing (Player)

import Debug

type alias Bullet =
  { x : Float
  , y : Float
  , vx : Float
  , vy : Float
  , x0 : Float
  , dir : Direction.Direction
  , canFall : Bool
  }

shoot : Player -> List Bullet -> List Bullet
shoot player bullets =
  let
    direction = if player.dir == Direction.Left then -1 else 1
  in
    { x = player.x
    , y = player.y
    , vx = 8.0 * direction
    , vy = 0
    , x0 = player.x
    , dir = player.dir
    , canFall = False
    } :: bullets

isNotExpired : Bullet -> Bool
isNotExpired b =
  let
    lifespan = 250
    traveled = b.x - b.x0 |> abs
  in traveled < lifespan && b.x /= 0

filter : List Bullet -> List Bullet
filter = List.filter isNotExpired

view : Bullet -> Form
view bullet =
  let
    dir =
      case bullet.dir of
        Direction.Left -> "left"
        Direction.Right -> "right"

    offset =
      case bullet.dir of
        Direction.Left -> -25
        Direction.Right -> 25

  in
    "/assets/img/player/bullet_" ++ dir ++ ".gif"
      |> image 25 25
      |> toForm
      |> move (bullet.x + offset, bullet.y)

bullet : Bullet
bullet =
  { x = 0
  , y = 0
  , vx = 1.0
  , vy = 0.0
  , x0 = 1
  , dir = Direction.Right
  , canFall = False
  }

main : Element
main =
  collage 400 400 [ view bullet ]
