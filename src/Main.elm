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

type alias Board = Matrix Char

type alias Model = Board


initialModel : Model
initialModel =
    square 3 (\_ -> 'X')


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE

type Msg
    = NoOp | Mark Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        Mark pos->
            ( model, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW

view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ div [ id "board" ]
            [ div [ class "board-row" ]
                [ button [ class "square", onClick ( Mark 0 )] []
                , button [ class "square", onClick ( Mark 1 )] []
                , button [ class "square", onClick ( Mark 2 )] []
                ]
             , div [class "board-row" ]
                [ button [ class "square", onClick ( Mark 3) ] []
                , button [ class "square", onClick ( Mark 4) ] []
                , button [ class "square", onClick ( Mark 5) ] []
                ]
             , div [class "board-row" ]
                [ button [ class "square", onClick ( Mark 6) ] []
                , button [ class "square", onClick ( Mark 7) ] []
                , button [ class "square", onClick ( Mark 8) ] []
                ]
            ]
        ]
