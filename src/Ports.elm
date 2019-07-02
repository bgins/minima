port module Ports exposing (play)

import Model exposing (Note)


port play : Note -> Cmd msg
