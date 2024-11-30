module Main exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

main = Browser.sandbox { init = 0, update = update, view = view}

update msg modal = 
    case msg of 
        Increment ->
            modal + 1

        Decrement ->
            modal - 1

type Msg = Increment | Decrement

view model = 
    div [ class "jumbotron"]
        [ div [class "main-title"]
            [ h1 [] [ text "Welcome to Dunder Mifflin!"]
            , p []
                [ text "Dunder Mifflin Inc. (stock symbol "
                , strong [] [text "DMI"]
                , text <|
                    """
                    ) is a micro-cap regional paper and office supply
                    distributor with an emphasis on servicing small-business
                    """
                ]
            , div [class "buttonCta"] [
                button [onClick Decrement] [text "-"]
                , div [] [text (String.fromInt model)]
                , button [onClick Increment] [text "+"]
                ]
            ]
        ]

