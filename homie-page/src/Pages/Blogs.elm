module Pages.Blogs exposing (page)

import Html exposing (Html)
import View exposing (View)


page : View msg
page =
    { title = "Pages.Blogs"
    , body = [ Html.text "/blogs" ]
    }
