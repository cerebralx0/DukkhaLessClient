module Intl
  (localiseString
  ) where

import Prelude       (map)
import Control.Alt   ((<|>))
import Data.Array    (foldr)
import Data.Maybe    (Maybe(..), fromMaybe)
import Intl.Terms    (Term)
import Intl.Locales  (Language(..))
import Intl.English  (localiseEnglishString)

localiseString :: Array Language -> Term -> String
localiseString languages term = fromMaybe "Could not translate term." bestTerm where
  maybeTerms = map toTerm languages
  bestTerm :: Maybe String
  bestTerm = foldr (<|>) Nothing maybeTerms

  -- | Language function mappings
  toTerm :: Language -> Maybe String
  toTerm English = localiseEnglishString term
  toTerm Swedish = Nothing

