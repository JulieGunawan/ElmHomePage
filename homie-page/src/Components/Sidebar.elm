module Components.Sidebar exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import View exposing (View)

view: {title: String
        , body: List (Html msg)
       } -> View msg


view props =
    { title = props.title
    , body = 
    [
        div [class "layout"]
        [
            aside [class "sidebar"]
            [
                a [href "/"][text "Home"]
                , a[href "/about"][text "About"]
                , a[href "/blogs"] [text "Blogs"]
                , a[href "/contact"][text "Contact"]
            ]
            , div [class "page"] props.body
        ]
    ]
    }
            
        
    
