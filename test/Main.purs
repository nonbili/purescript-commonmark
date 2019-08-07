module Test.Main where

import Prelude

import CommonMark (renderString, newParser, newHtmlRenderer, parse, render)
import Data.Traversable (sequence_)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Jest (expectToEqual, test)

cases :: Array (Tuple String String)
cases =
  [ Tuple "# head" "<h1>head</h1>\n"
  , Tuple
      "<https://purescript.org>"
      "<p><a href=\"https://purescript.org\">https://purescript.org</a></p>\n"
  ]

main :: Effect Unit
main = do
  test "renderString" $ do
    sequence_ $ cases <#> \(Tuple input output) ->
      expectToEqual (renderString input) output

  test "parse and render" $ do
    let
      parser = newParser
      renderer = newHtmlRenderer
    sequence_ $ cases <#> \(Tuple input output) -> do
      let
        parsed = parse input parser
      expectToEqual (render parsed renderer) output
