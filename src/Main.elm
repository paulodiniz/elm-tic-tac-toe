module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Matrix exposing (..)

main : Program Never Game Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type SquareState = Blank | XMarked | CircleMarked
type Player = Player1 | Player2
type alias Board = Matrix SquareState
type alias Game =
        { board: Board
        , turn: Player
        }


initialGame : Game
initialGame =
    { board = square 3 (\_ -> Blank )
    , turn = Player1
    }


init : ( Game, Cmd Msg )
init =
    ( initialGame, Cmd.none )


-- UPDATE

type Msg = NoOp | Mark Int Int

update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
    case msg of
        NoOp ->
            ( game, Cmd.none )
        Mark posX posY ->
            ( { game | board = set (loc posX posY) (mark game.turn) game.board, turn = otherPlayer game.turn }, Cmd.none )


mark : Player -> SquareState
mark player =
    case player of
        Player1 ->
            XMarked
        Player2 ->
            CircleMarked

otherPlayer : Player -> Player
otherPlayer player =
    case player of
        Player1 ->
            Player2
        Player2 ->
            Player1


-- SUBSCRIPTIONS

subscriptions : Game -> Sub Msg
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

view : Game -> Html Msg
view game =
    div [ id "container" ]
        [ div [ id "board" ]
            [ div [ class "board-row" ]
                [ button [ class "square", onClick <| Mark 0 0 ] [text <| boardContent game.board 0 0]
                , button [ class "square", onClick <| Mark 0 1 ] [text <| boardContent game.board 0 1]
                , button [ class "square", onClick <| Mark 0 2 ] [text <| boardContent game.board 0 2]
                ]
             , div [class "board-row" ]
                [ button [ class "square", onClick <| Mark 1 0 ] [text <| boardContent game.board 1 0]
                , button [ class "square", onClick <| Mark 1 1 ] [text <| boardContent game.board 1 1]
                , button [ class "square", onClick <| Mark 1 2 ] [text <| boardContent game.board 1 2]
                ]
             , div [class "board-row" ]
                [ button [ class "square", onClick <| Mark 2 0 ] [text <| boardContent game.board 2 0]
                , button [ class "square", onClick <| Mark 2 1 ] [text <| boardContent game.board 2 1]
                , button [ class "square", onClick <| Mark 2 2 ] [text <| boardContent game.board 2 2]
                ]
            ]
        ]
