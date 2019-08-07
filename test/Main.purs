module Test.Main where

import Prelude

import CommonMark (newHtmlRenderer, newParser, parse, render, renderString, safe, smart)
import Data.Options ((:=))
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
    parser <- liftEffect $ newParser mempty
    renderer <- liftEffect $ newHtmlRenderer mempty
    sequence_ $ cases <#> \(Tuple input output) -> do
      parsed <- liftEffect $ parse input parser
      html <- liftEffect $ render parsed renderer
      expectToEqual html output

  test "smart parse" $ do
    parser <- liftEffect $ newParser $
      smart := true
    renderer <- liftEffect $ newHtmlRenderer mempty
    let
      input = "a -- b"
      output = "<p>a – b</p>\n"

    parsed <- liftEffect $ parse input parser
    html <- liftEffect $ render parsed renderer
    expectToEqual html output

  test "safe render" $ do
    parser <- liftEffect $ newParser mempty
    renderer <- liftEffect $ newHtmlRenderer $
      safe := true
    let
      input = "<script>alert()</script>"
      output = "<!-- raw HTML omitted -->\n"
    parsed <- liftEffect $ parse input parser
    html <- liftEffect $ render parsed renderer
    expectToEqual html output
