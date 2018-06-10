module Intl
  ( localiseString
  , LocaliseFn
  ) where

import Data.Array (catMaybes, head)
import Data.Maybe (Maybe(..), fromMaybe)
import Intl.English (localiseEnglishString)
import Intl.Locales (Language(..))
import Intl.Terms (Term)
import Prelude (map, ($))

type LocaliseFn = Term -> String

localiseString :: Array Language -> Term -> String
localiseString languages term = fromMaybe ">> Translation Missing <<" bestTerm where
  maybeTerms = map toTerm languages
  bestTerm = head $ catMaybes $ maybeTerms

  -- | Language function mappings
  toTerm :: Language -> Maybe String
  toTerm English = localiseEnglishString term
  toTerm Swedish = Nothing

