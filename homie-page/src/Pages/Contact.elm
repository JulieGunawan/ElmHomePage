module Pages.Contact exposing (page)

import Html exposing (Html)
import View exposing (View)


page : View msg
page =
    { title = "Pages.Contact"
    , body = [ Html.text "/contact" ]
    }
