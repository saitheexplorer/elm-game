module State where

import Graphics.Element exposing (Element, show)
import Bullet exposing (Bullet)
import Input exposing (Keys)
import Maybe
import Player exposing (Player)
import Signal

import Debug

type alias State =
  { player : Player
  , bullets : List Bullet
  , level : Int
  }

initial : State
initial =
  { player = Player.initial
  , bullets = []
  , level = 1
  }

physics dt body =
  { body |
      x = max 0 (body.x + dt * body.vx)
    , y = max 0 (body.y + dt * body.vy)
  }

gravity dt body =
  let
    inAir = body.y > 0
    vy' = body.vy - dt/4
  in
    { body | vy = if inAir && body.canFall then vy' else 0 }

update : (Float, Keys) -> State -> State
update (dt, keys) state =
  let
    newPlayer =
      Player.update keys state.player
        |> physics dt
        |> gravity dt

    bullets' =
      if keys.space /= True then state.bullets
      else Bullet.shoot state.player state.bullets

    newBullets =
      bullets'
        |> List.map (physics dt)
        |> Bullet.filter
  in
    { state |
      player = newPlayer
    , bullets = newBullets
    }

state : Signal State
state = Signal.foldp update initial Input.input

main : Signal Element
main =
  Signal.map show state

