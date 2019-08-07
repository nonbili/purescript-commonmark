module CommonMark
  ( renderString
  , Parser
  , Node
  , HtmlRenderer
  , newParser
  , newHtmlRenderer
  , parse
  , render
  ) where

import Data.Function.Uncurried (Fn0, Fn2, runFn0, runFn2)

data Parser

data Node

data HtmlRenderer

-- | Parse and render markdown string to html string.
foreign import renderString :: String -> String

-- | Create a new CommonMark Parser.
newParser :: Parser
newParser = runFn0 newParser_
foreign import newParser_ :: Fn0 Parser

-- | Create a new CommonMark HtmlRenderer.
newHtmlRenderer :: HtmlRenderer
newHtmlRenderer = runFn0 newHtmlRenderer_
foreign import newHtmlRenderer_ :: Fn0 HtmlRenderer

-- | Parse markdown string to CommonMark Node.
parse :: String -> Parser -> Node
parse = runFn2 parse_
foreign import parse_ :: Fn2 String Parser Node

-- | Render CommonMark Node to html string.
render :: Node -> HtmlRenderer -> String
render = runFn2 render_
foreign import render_ :: Fn2 Node HtmlRenderer String
