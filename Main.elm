import Bullet
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Player
import Signal
import State exposing (State, state)
import Window
import Level

view : (Int, Int) -> State -> Element
view (w, h) state =
  let
    w' = toFloat w
    h' = toFloat h

    groundY = 100 - h'/2
    leftX = 30 - w'/2

    offset = move (leftX, groundY)

    player =
      state.player
        |> Player.view
        |> offset

    bullets =
      state.bullets
        |> List.map Bullet.view
        |> List.map offset

    background = Level.background state.level (w, h) state.player.x
    floor = Level.floor state.level (w, h) state.player.x

    scene =
      background ::
      floor ::
      player ::
      bullets

  in
    collage w h scene

main : Signal Element
main = Signal.map2 view Window.dimensions state


