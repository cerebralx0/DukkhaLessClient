module Intl.Locales.Swedish where

import Intl.Terms (j, n)
import Intl.Terms as Term
import Intl.Terms.Introduction as Intro
import Intl.Terms.Resources as Resource
import Intl.Terms.NotFound as NotFound

import Data.Maybe (Maybe)

localise :: Term.Term -> Maybe String
localise (Term.Intro intro) = localiseIntro intro
localise (Term.Resource resource) = localiseResource resource
localise (Term.Session session) = n
localise (Term.NotFound notFound) = n

localiseIntro :: Intro.Introduction -> Maybe String
localiseIntro Intro.Title = j "Dukkhaless Sjävvård"
localiseIntro Intro.Explanation = n

localiseResource :: Resource.Resources -> Maybe String
localiseResource Resource.Title = n
