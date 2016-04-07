module View where

import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)

import Types exposing ( Model, State )

getSprite : Model -> Element
getSprite model =
  let
    verb =
      if model.y > 0 then "jump"
      else if model.vx /= 0 then "run"
      else if model.isShooting then "shoot"
      else "stand"

    dir =
      case model.dir of
        Types.Left -> "left"
        Types.Right -> "right"
  in
    "/assets/img/player/" ++ verb ++ "_" ++ dir ++ ".gif"
      |> image 120 120

view : (Int, Int) -> State -> Element
view (w, h) state =
  let
    w' = toFloat w
    h' = toFloat h

    model = state.model
    player = getSprite model

    groundY = 100 - h'/2
    leftX = 30 - w'/2

    position =
      (model.x + leftX , model.y + groundY)
  in
    collage w h [
      fittedImage w h "/assets/img/level/background.gif"
        |> toForm
    , tiledImage w 50 "/assets/img/level/platform.gif"
        |> toForm
        |> move (0, 24 - h'/2)
    , player
        |> toForm
        |> move position
    ]
