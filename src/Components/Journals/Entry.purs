module Components.Journals.Entry where

import Prelude

import AppM (CurrentSessionRow, EditingJournalEntryRow)
import Control.Monad.Reader.Class (class MonadAsk, asks)
import Data.Crypto.Types (DocumentId)
import Data.Default (default)
import Data.Maybe (Maybe(..), fromMaybe, maybe)
import Effect.AVar (AVar)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Intl (LocaliseFn)
import Model (Session(..))
import Model.Journal (JournalEntry(..), JournalMeta(..))
import Network.RemoteData (RemoteData(..))
import Type.Data.Boolean (kind Boolean)
import Type.Row (type (+))

data Query a = Initialize a

data Slot = Slot
derive instance eqSlot :: Eq Slot
derive instance ordSlot :: Ord Slot

data Message = MNoMsg

type State =
  { entry :: RemoteData String JournalEntry
  , desiredEntryId :: Maybe DocumentId
  , editing :: Boolean
  }

newtype Input
  = Input
  { desiredEntry :: Maybe DocumentId
  }

initialState :: Input -> State
initialState (Input input) = 
  { entry: NotAsked
  , editing: false
  , desiredEntryId: input.desiredEntry
  }

type RequiredState r =
  ( EditingJournalEntryRow
  + CurrentSessionRow
  + r
  )

component 
  :: forall m r
  . MonadAff m
  => MonadAsk (Record (RequiredState r)) m
  => LocaliseFn -> H.Component HH.HTML Query Input Message m
component t =
  H.lifecycleComponent
      { initialState
      , render
      , eval
      , receiver: const Nothing
      , initializer: Just $ H.action Initialize
      , finalizer: Nothing
      }
  where

  render :: State -> H.ComponentHTML Query
  render state = case state.entry of
    Failure e -> loadingFailed e
    Success a ->
      case state.editing of 
        false -> markdownRendered a
        true  ->  markdownEdit a
    NotAsked -> notAsked
    Loading  -> loading
    where

    markdownRendered :: JournalEntry -> H.ComponentHTML Query
    markdownRendered (JournalEntry e) = HH.text "Rendered!"

    markdownEdit :: JournalEntry -> H.ComponentHTML Query
    markdownEdit (JournalEntry e) = HH.text "Editing!"

    loadingFailed :: String -> H.ComponentHTML Query
    loadingFailed e = HH.text e

    notAsked :: H.ComponentHTML Query
    notAsked = HH.text "None requested"
    
    loading :: H.ComponentHTML Query
    loading = HH.text "Loading"

  eval :: Query ~> H.ComponentDSL State Query Message m
  eval (Initialize next) = do
    desiredEntry <- H.gets (_.desiredEntryId)
    case desiredEntry of
      Just id -> do
        H.modify_ (_{ entry = Loading })
      Nothing -> H.modify_ (_{ entry = Success default })
    pure next
    