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

type Msg = NoOp | Mark Int Int


update : Msg -> Board -> ( Board, Cmd Msg )
update msg board =
    case msg of
        NoOp ->
            ( board, Cmd.none )
        Mark posX posY ->
            ( set (loc posX posY) XMarked board, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


boardContent : Board -> Int -> Int -> String
boardContent board posX posY =
    case get (loc posX posY) board of
        Just value ->
            value |> squareToString
        Nothing ->
            Blank |> squareToString

squareToString: SquareState -> String
squareToString square =
  case square of
      Blank ->
          String.fromChar ' '
      XMarked ->
          String.fromChar 'X'
      CircleMarked ->
          String.fromChar 'O'

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
