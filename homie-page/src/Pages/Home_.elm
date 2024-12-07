module Pages.Home_ exposing (page)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import View exposing (View)
import Components.Sidebar
import Json.Decode as Decode
import Array exposing (initialize)
import Components.Sidebar exposing (view)
import Dict exposing (update)


page : View msg
page =
    Components.Sidebar.view
        { title = "Homepage"
        , body = [ 
                div [class "home-container"] [
                    div [class "home-div"] 
                    [
                        h1[] [text "Welcome to My Homie Page!"]
                        , p [] [
                            text "Homie Page Inc. (stock symbol:" 
                            , strong[] [text "HPI"]
                            , text <|
                                """
                                ) is a micro-cap regional food and dessert supply with an emphasis on servicing pets, especially cats and dogs
                                """
                        ]
                        , div [] 
                        [
                            h3[][text "Wanna see some cats? Click this button to get different cats"]
                            , button[] [text "Click Me"]
                        ]
                    ]
                ]
            ] 
        }

main: Program Never Model Msg
main =
    Html.program
    {
        init = init
        , view = view
        , update =update
        , subcriptions = \_ -> Sub.none
    }

initialModel : Model
initialModel = 
    { gifUrl = "waiting.gif"
    , error= Nothing
    }

init: (Model, Cmd Msg)
init = 
    (initialModel, getRandomCatGif)


apiUrl : String
apiUrl = "https://api.thecatapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=1"

getRandomCatGif: Cmd Msg
getRandomCatGif = 
    Http.get apiUrl decodeGifUrl
        |> Http.send NewGif

decodeGifUrl: Decode.Decoder String
decodeGifUrl =
    Decode.at ["data", "image_url"] Decode.string