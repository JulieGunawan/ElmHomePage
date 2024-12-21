module Pages.Home_ exposing (Model, Msg, page)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import View exposing (View)
import Page exposing (Page)
import Components.Sidebar
import Json.Decode as Decode
import Route exposing (Route)
import Shared

--Main


page : Shared.Model -> Route () -> Page Model Msg
page shared route =
    Page.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions  model =
    Sub.none

type alias Model = 
    {
        catImageUrl: Maybe String
        , error: Maybe String
    }

-- INIT

init: (Model, Cmd Msg)
init _ = 
    ( {catImageUrl = Nothing
        , error = Nothing
      }
      , Cmd.none
    )


--UPDATE
type Msg 
    = FetchCatImage
        | GotImg (Result Http.Error String)


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FetchCatImage ->
            ( model
            ,fetchCatImage
            )
        GotImg result ->
            case result of 
                Ok imgUrl ->
                    ( { model | catImageUrl = Just imgUrl, error = Nothing}
                    , Cmd.none)

                Err _ ->
                    ( {model | catImageUrl = Nothing, error = Just "Failed to fetch cat image"}
                    , Cmd.none
                    )


apiUrl : String
apiUrl = "https://api.thecatapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=1"

--API DECODER
catImageDecoder: Decode.Decoder String
catImageDecoder = 
    Decode.at["0", "url"] Decode.string

--Fetch Image
fetchCatImage : Cmd Msg
fetchCatImage = 
    Http.get
    { url = apiUrl
    , expect = Http.expectJson GotImg catImageDecoder
    }

-- VIEW
type alias View msg = 
    {
        title: String
        , body: List (Html msg)
    }
view : Model -> View Msg
view model =
    Components.Sidebar.view
        { title = "Homepage"
        , body = 
            [
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
                            , button[onClick FetchCatImage] [text "Click Me"]
                            , case model.catImageUrl of
                                Just url ->
                                    img [src url, style "max-width" "300px", style "margin-top" "10px"] []

                                Nothing ->
                                    text (Maybe.withDefault "" model.error)
                        ]
                    ]
                ]  
            ]     
        }