module Items exposing (Items(..), add, init, new, toItems)

import Item exposing (Item)


type Items
    = Items (List Item)


toItems : Items -> List Item
toItems (Items items) =
    items


init : Items
init =
    Items []


new : List Item -> Items
new items =
    Items items


add : Item -> Items -> Items
add newItem items =
    let
        items_ =
            toItems items

        itemsLength =
            List.length items_

        newItemTitle =
            "Item" ++ (String.fromInt <| itemsLength + 1)

        nextItems =
            items_
                ++ [ Item.updateTitle newItemTitle newItem ]
                |> List.sortBy Item.toTitle
    in
    Items nextItems
