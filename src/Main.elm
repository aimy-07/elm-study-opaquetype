module Main exposing (Model, Msg(..), init, main, update, view, viewItem)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Item exposing (Item, LabelColor(..))



---- MODEL ----


type alias Model =
    { items : List Item
    , newItem : Item
    }


init : ( Model, Cmd Msg )
init =
    ( { items = []
      , newItem = Item.initItem
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ChangeNewItemText String
    | ChangeLabel
    | AddItem


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeNewItemText text ->
            let
                newItem =
                    model.newItem
            in
            ( { model | newItem = { newItem | text = text, textCount = String.length text } }, Cmd.none )

        ChangeLabel ->
            let
                newItem =
                    model.newItem

                nextLabelColor =
                    case model.newItem.labelColor of
                        Red ->
                            Blue

                        Blue ->
                            Red
            in
            ( { model | newItem = { newItem | labelColor = nextLabelColor } }, Cmd.none )

        AddItem ->
            let
                newItem =
                    model.newItem

                addingItem =
                    { newItem | title = "Item" ++ (String.fromInt <| (+) 1 <| List.length model.items) }

                nextItems =
                    model.items ++ [ addingItem ]
            in
            ( { model | items = nextItems, newItem = Item.initItem }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        color =
            case model.newItem.labelColor of
                Red ->
                    "red"

                Blue ->
                    "blue"
    in
    div []
        [ h1 [] [ text "ItemList" ]
        , div []
            (List.map (\item -> viewItem item) model.items)
        , input [ onInput ChangeNewItemText, style "color" color, value model.newItem.text ] []
        , button [ onClick ChangeLabel ] [ text "Change LabelColor" ]
        , button [ onClick AddItem ] [ text "Add Item" ]
        ]


viewItem : Item -> Html msg
viewItem item =
    let
        color =
            case item.labelColor of
                Red ->
                    "red"

                Blue ->
                    "blue"
    in
    div [ style "color" color ]
        [ h2 [] [ text item.title ]
        , p [] [ text <| item.text ++ " (" ++ String.fromInt item.textCount ++ ")" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
