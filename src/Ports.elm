port module Ports exposing (..)

import Model exposing (Note)

port play : Note -> Cmd msg
