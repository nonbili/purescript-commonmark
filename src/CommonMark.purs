module CommonMark
  ( renderString
  , ParserOptions
  , smart
  , Parser
  , newParser
  , RendererOptions
  , sourcepos
  , safe
  , softbreak
  , esc
  , HtmlRenderer
  , newHtmlRenderer
  , Node
  , parse
  , render
  ) where

import Prelude

import Data.Options as O
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Foreign (Foreign)

foreign import data Parser :: Type

foreign import data Node :: Type

foreign import data HtmlRenderer :: Type

-- | Parse and render markdown string to html string.
renderString :: String -> Effect String
renderString = runEffectFn1 renderString_
foreign import renderString_ :: EffectFn1 String String

-- Check https://github.com/commonmark/commonmark.js to see available Parser
-- options.
data ParserOptions

smart :: O.Option ParserOptions Boolean
smart = O.opt "smart"

-- | Create a new CommonMark Parser.
newParser :: O.Options ParserOptions -> Effect Parser
newParser opts = runEffectFn1 newParser_ $ O.options opts
foreign import newParser_ :: EffectFn1 Foreign Parser

-- Check https://github.com/commonmark/commonmark.js to see available
-- HtmlRenderer options.
data RendererOptions

sourcepos :: O.Option RendererOptions Boolean
sourcepos = O.opt "sourcepos"

safe :: O.Option RendererOptions Boolean
safe = O.opt "safe"

softbreak :: O.Option RendererOptions String
softbreak = O.opt "softbreak"

esc :: O.Option RendererOptions (String -> Boolean -> String)
esc = O.opt "esc"

-- | Create a new CommonMark HtmlRenderer.
newHtmlRenderer :: O.Options RendererOptions -> Effect HtmlRenderer
newHtmlRenderer opts = runEffectFn1 newHtmlRenderer_ $ O.options opts
foreign import newHtmlRenderer_ :: EffectFn1 Foreign HtmlRenderer

-- | Parse markdown string to CommonMark Node.
parse :: String -> Parser -> Effect Node
parse = runEffectFn2 parse_
foreign import parse_ :: EffectFn2 String Parser Node

-- | Render CommonMark Node to html string.
render :: Node -> HtmlRenderer -> Effect String
render = runEffectFn2 render_
foreign import render_ :: EffectFn2 Node HtmlRenderer String
