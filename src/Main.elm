module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Matrix exposing (..)


--import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type SquareState = Blank | XMarked | CircleMarked
type alias Board = Matrix SquareState
type alias Model = Board


initialModel : Model
initialModel =
    square 3 (\_ -> Blank )


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE

type Msg
    = NoOp | Mark Int Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        Mark posX posY ->
            ( model, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


boardContent : Board -> Int -> Int -> String
boardContent board posX posY =
    case get (loc posX posY) board of
        Just value ->
            value |> toString
        Nothing ->
            Blank |> toString

-- VIEW

view : Board -> Html Msg
view board =
    div [ id "container" ]
        [ div [ id "board" ]
            [ div [ class "board-row" ]
                [ button [ class "square", onClick <| Mark 0 0 ] [text <| boardContent board 0 0]
                , button [ class "square", onClick <| Mark 0 1 ] [text <| boardContent board 0 1]
                , button [ class "square", onClick <| Mark 0 2 ] [text <| boardContent board 0 2]
                ]
             , div [class "board-row" ]
                [ button [ class "square", onClick <| Mark 1 0 ] [text <| boardContent board 1 0]
                , button [ class "square", onClick <| Mark 1 1 ] [text <| boardContent board 1 1]
                , button [ class "square", onClick <| Mark 1 2 ] [text <| boardContent board 1 2]
                ]
             , div [class "board-row" ]
                [ button [ class "square", onClick <| Mark 2 0 ] [text <| boardContent board 2 0]
                , button [ class "square", onClick <| Mark 2 1 ] [text <| boardContent board 2 1]
                , button [ class "square", onClick <| Mark 2 2 ] [text <| boardContent board 2 2]
                ]
            ]
        ]
