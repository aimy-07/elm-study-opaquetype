module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Item exposing (Item)
import Items exposing (Items)



---- MODEL ----


type alias Model =
    { items : Items
    , newItem : Item
    }


init : ( Model, Cmd Msg )
init =
    ( { items = Items.init
      , newItem = Item.init
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
            ( { model | newItem = Item.updateText text newItem }, Cmd.none )

        ChangeLabel ->
            let
                newItem =
                    model.newItem
            in
            ( { model | newItem = Item.updateLabelColor newItem }, Cmd.none )

        AddItem ->
            let
                nextItems =
                    Items.add model.newItem model.items
            in
            ( { model | items = nextItems, newItem = Item.init }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        color =
            Item.toStringLabelColor model.newItem
    in
    div []
        [ h1 [] [ text "ItemList" ]
        , div []
            (List.map (\item -> viewItem item) (Items.toItems model.items))
        , input [ onInput ChangeNewItemText, style "color" color, value <| Item.toText model.newItem ] []
        , button [ onClick ChangeLabel ] [ text "Change LabelColor" ]
        , button [ onClick AddItem ] [ text "Add Item" ]
        ]


viewItem : Item -> Html msg
viewItem item =
    let
        color =
            Item.toStringLabelColor item

        itemText =
            Item.toText item

        itemTextCount =
            Item.toTextCount item
    in
    div [ style "color" color ]
        [ h2 [] [ text <| Item.toTitle item ]
        , p [] [ text <| itemText ++ " (" ++ String.fromInt itemTextCount ++ ")" ]
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
