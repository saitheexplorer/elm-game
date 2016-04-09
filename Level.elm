module Level where

import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)

background : Int -> (Int, Int) -> Float -> Form
background level (w, h) x =
  let
    w' = toFloat w
    h' = toFloat h

  in
    "/assets/img/level/background_" ++ toString level ++ ".gif"
      |> fittedImage (round (w' * 1.5)) (round (h' * 1.5))
      |> toForm
      |> moveX (x / -25)

floor : Int -> (Int, Int) -> Float -> Form
floor level (w, h) x =
  let
    h' = toFloat h
  in
    "/assets/img/level/floor_" ++ toString level ++ ".gif"
      |> tiledImage (w * 100) 50
      |> toForm
      |> move (0, 24 - h'/2)


main : Element
main =
  collage 500 500 [
    background 1 (500, 500) 0
  , floor 1 (500, 500) 0
  ]
