module Pages.Home_ exposing (page)

import Html exposing (..)
import View exposing (View)
import Components.Sidebar


page : View msg
page =
    Components.Sidebar.view
        { title = "Homepage"
        , body = [ 
                div [] [
                    div [] [
                        h1[] [text "Welcome to My Homie Page!"]
                        , p [] [
                            text "Homie Page Inc. (stock symbol"
                            , strong[] [text "HPI"]
                            , text <|
                                """
                                ) is a micro-cap regional food and dessert supply with an emphasis on servicing pets, especially cats and dogs
                                """
                        ]
                    ]
                ] 
            ]
        }
