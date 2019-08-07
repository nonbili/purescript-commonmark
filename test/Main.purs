module Test.Main where

import Prelude

import CommonMark (renderString, newParser, newHtmlRenderer, parse, render)
import Data.Traversable (sequence_)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Class (liftEffect)
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
    sequence_ $ cases <#> \(Tuple input output) -> do
      html <- liftEffect $ renderString input
      expectToEqual html output

  test "parse and render" $ do
    parser <- liftEffect newParser
    renderer <- liftEffect newHtmlRenderer
    sequence_ $ cases <#> \(Tuple input output) -> do
      parsed <- liftEffect $ parse input parser
      html <- liftEffect $ render parsed renderer
      expectToEqual html output
