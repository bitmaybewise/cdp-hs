{-# LANGUAGE OverloadedStrings, RecordWildCards, TupleSections #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE DeriveGeneric #-}

module CDP.Domains.Cast (module CDP.Domains.Cast) where

import           Control.Applicative  ((<$>))
import           Control.Monad
import           Control.Monad.Loops
import           Control.Monad.Trans  (liftIO)
import qualified Data.Map             as M
import           Data.Maybe          
import Data.Functor.Identity
import Data.String
import qualified Data.Text as T
import qualified Data.List as List
import qualified Data.Text.IO         as TI
import qualified Data.Vector          as V
import Data.Aeson.Types (Parser(..))
import           Data.Aeson           (FromJSON (..), ToJSON (..), (.:), (.:?), (.=), (.!=), (.:!))
import qualified Data.Aeson           as A
import qualified Network.HTTP.Simple as Http
import qualified Network.URI          as Uri
import qualified Network.WebSockets as WS
import Control.Concurrent
import qualified Text.Casing as C
import qualified Data.ByteString.Lazy as BS
import qualified Data.Map as Map
import Data.Proxy
import System.Random
import GHC.Generics
import Data.Char
import Data.Default

import CDP.Internal.Runtime
import CDP.Handle




data CastSink = CastSink {
   castSinkName :: String,
   castSinkId :: String,
   castSinkSession :: Maybe String
} deriving (Generic, Eq, Show, Read)
instance ToJSON CastSink  where
   toJSON = A.genericToJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 8 , A.omitNothingFields = True}

instance FromJSON  CastSink where
   parseJSON = A.genericParseJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 8 }





data CastSinksUpdated = CastSinksUpdated {
   castSinksUpdatedSinks :: [CastSink]
} deriving (Generic, Eq, Show, Read)
instance ToJSON CastSinksUpdated  where
   toJSON = A.genericToJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 16 , A.omitNothingFields = True}

instance FromJSON  CastSinksUpdated where
   parseJSON = A.genericParseJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 16 }



data CastIssueUpdated = CastIssueUpdated {
   castIssueUpdatedIssueMessage :: String
} deriving (Generic, Eq, Show, Read)
instance ToJSON CastIssueUpdated  where
   toJSON = A.genericToJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 16 , A.omitNothingFields = True}

instance FromJSON  CastIssueUpdated where
   parseJSON = A.genericParseJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 16 }





data PCastEnable = PCastEnable {
   pCastEnablePresentationUrl :: Maybe String
} deriving (Generic, Eq, Show, Read)
instance ToJSON PCastEnable  where
   toJSON = A.genericToJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 11 , A.omitNothingFields = True}

instance FromJSON  PCastEnable where
   parseJSON = A.genericParseJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 11 }


castEnable :: Handle ev -> PCastEnable -> IO (Maybe Error)
castEnable handle params = sendReceiveCommand handle "Cast.enable" (Just params)


castDisable :: Handle ev -> IO (Maybe Error)
castDisable handle = sendReceiveCommand handle "Cast.disable" (Nothing :: Maybe ())



data PCastSetSinkToUse = PCastSetSinkToUse {
   pCastSetSinkToUseSinkName :: String
} deriving (Generic, Eq, Show, Read)
instance ToJSON PCastSetSinkToUse  where
   toJSON = A.genericToJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 17 , A.omitNothingFields = True}

instance FromJSON  PCastSetSinkToUse where
   parseJSON = A.genericParseJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 17 }


castSetSinkToUse :: Handle ev -> PCastSetSinkToUse -> IO (Maybe Error)
castSetSinkToUse handle params = sendReceiveCommand handle "Cast.setSinkToUse" (Just params)



data PCastStartDesktopMirroring = PCastStartDesktopMirroring {
   pCastStartDesktopMirroringSinkName :: String
} deriving (Generic, Eq, Show, Read)
instance ToJSON PCastStartDesktopMirroring  where
   toJSON = A.genericToJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 26 , A.omitNothingFields = True}

instance FromJSON  PCastStartDesktopMirroring where
   parseJSON = A.genericParseJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 26 }


castStartDesktopMirroring :: Handle ev -> PCastStartDesktopMirroring -> IO (Maybe Error)
castStartDesktopMirroring handle params = sendReceiveCommand handle "Cast.startDesktopMirroring" (Just params)



data PCastStartTabMirroring = PCastStartTabMirroring {
   pCastStartTabMirroringSinkName :: String
} deriving (Generic, Eq, Show, Read)
instance ToJSON PCastStartTabMirroring  where
   toJSON = A.genericToJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 22 , A.omitNothingFields = True}

instance FromJSON  PCastStartTabMirroring where
   parseJSON = A.genericParseJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 22 }


castStartTabMirroring :: Handle ev -> PCastStartTabMirroring -> IO (Maybe Error)
castStartTabMirroring handle params = sendReceiveCommand handle "Cast.startTabMirroring" (Just params)



data PCastStopCasting = PCastStopCasting {
   pCastStopCastingSinkName :: String
} deriving (Generic, Eq, Show, Read)
instance ToJSON PCastStopCasting  where
   toJSON = A.genericToJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 16 , A.omitNothingFields = True}

instance FromJSON  PCastStopCasting where
   parseJSON = A.genericParseJSON A.defaultOptions{A.fieldLabelModifier = uncapitalizeFirst . drop 16 }


castStopCasting :: Handle ev -> PCastStopCasting -> IO (Maybe Error)
castStopCasting handle params = sendReceiveCommand handle "Cast.stopCasting" (Just params)


