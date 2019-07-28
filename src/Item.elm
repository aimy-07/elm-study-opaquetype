module Item exposing (Item, LabelColor(..), initItem)


type alias Item =
    { title : String
    , text : String
    , textCount : Int
    , labelColor : LabelColor
    }


type LabelColor
    = Red
    | Blue


initItem =
    { title = ""
    , text = ""
    , textCount = 0
    , labelColor = Red
    }
