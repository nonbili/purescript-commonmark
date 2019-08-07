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

import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)

data Parser

data Node

data HtmlRenderer

-- | Parse and render markdown string to html string.
renderString :: String -> Effect String
renderString = runEffectFn1 renderString_
foreign import renderString_ :: EffectFn1 String String

-- | Create a new CommonMark Parser.
foreign import newParser :: Effect Parser

-- | Create a new CommonMark HtmlRenderer.
foreign import newHtmlRenderer :: Effect HtmlRenderer

-- | Parse markdown string to CommonMark Node.
parse :: String -> Parser -> Effect Node
parse = runEffectFn2 parse_
foreign import parse_ :: EffectFn2 String Parser Node

-- | Render CommonMark Node to html string.
render :: Node -> HtmlRenderer -> Effect String
render = runEffectFn2 render_
foreign import render_ :: EffectFn2 Node HtmlRenderer String
