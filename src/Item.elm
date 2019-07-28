module Item exposing (Item(..), init, new, toLabelColor, toStringLabelColor, toText, toTextCount, toTitle, updateLabelColor, updateText, updateTitle)


type Item
    = Item
        { title : String
        , text : String
        , textCount : Int
        , labelColor : LabelColor
        }


type LabelColor
    = Red
    | Blue


new : String -> String -> Int -> LabelColor -> Item
new title text textCount labelColor =
    Item
        { title = title
        , text = text
        , textCount = textCount
        , labelColor = labelColor
        }


toTitle : Item -> String
toTitle (Item { title }) =
    title


toText : Item -> String
toText (Item { text }) =
    text


toTextCount : Item -> Int
toTextCount (Item { textCount }) =
    textCount


toLabelColor : Item -> LabelColor
toLabelColor (Item { labelColor }) =
    labelColor


updateTitle : String -> Item -> Item
updateTitle title (Item item) =
    Item
        { item | title = title }


updateText : String -> Item -> Item
updateText text (Item item) =
    Item
        { item | text = text, textCount = String.length text }


updateLabelColor : Item -> Item
updateLabelColor (Item item) =
    let
        nextLabelColor =
            case item.labelColor of
                Red ->
                    Blue

                Blue ->
                    Red
    in
    Item
        { item | labelColor = nextLabelColor }


toStringLabelColor : Item -> String
toStringLabelColor (Item item) =
    case item.labelColor of
        Red ->
            "red"

        Blue ->
            "blue"


init : Item
init =
    Item
        { title = ""
        , text = ""
        , textCount = 0
        , labelColor = Red
        }
