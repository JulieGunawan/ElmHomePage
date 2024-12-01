module Pages.About exposing (page)

import Html exposing (..)
import Html.Attributes exposing (..)
import View exposing (View)
import Components.Sidebar

page : View msg
page =
    Components.Sidebar.view
    { title = "Pages.About"
    , body = 
        [text "About this page"]    
    }
