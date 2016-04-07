module Bullet where

import List
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)

import Types

type alias Bullet =
  { x : Float
  , y : Float
  , vx : Float
  , x0 : Float
  , dir : Types.Direction
  }

physics : Float -> Bullet -> Bullet
physics dt bullet =
  let
    vx =
      case bullet.dir of
        Types.Left -> bullet.vx * -1
        Types.Right -> bullet.vx
  in
    { bullet | x = bullet.x + dt * vx }

shoot : Types.Keys -> Types.Model -> List Bullet -> List Bullet
shoot keys player bullets =
  if keys.space /= True then bullets
  else
    { x = player.x
    , y = player.y
    , vx = 8
    , x0 = player.x
    , dir = player.dir
    } :: bullets

update : (Float, Types.Keys) -> Types.Model -> List Bullet -> List Bullet
update (dt, keys) player bullets =
  bullets
    |> shoot keys player
    |> List.filter (\b -> abs (b.x - b.x0) < 200)
    |> List.map (physics dt)

view : Bullet -> Form
view bullet =
  let
    dir =
      case bullet.dir of
        Types.Left -> "left"
        Types.Right -> "right"

    offset =
      case bullet.dir of
        Types.Left -> -25
        Types.Right -> 25

  in
    "/assets/img/player/bullet_" ++ dir ++ ".gif"
      |> image 25 25
      |> toForm
      |> move (bullet.x + offset, bullet.y)
