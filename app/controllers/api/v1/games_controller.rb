class Api::V1::GamesController < ApplicationController

  def index
    game = Game.last
    tail = game.tails.map do |tail|
      moves = tail.moves.map do |move|
        {
          bearing: move.bearing,
          coordinates: [move.x, move.y]
        }
      end.reverse
      # the moves have been reversed somehow so this is to un-reverse them
      {
        bearing: tail.bearing,
        coordinates: [tail.x, tail.y],
        moves: moves
      }
    end
    render json: {
      snakeHead: {
        bearing: game.snake_head.bearing,
        coordinates: [game.snake_head.x, game.snake_head.y]
      },
      tail: tail
    }
  end

  def create_or_update_game

    game = Game.create
    create_snake_head_and_tail(game)
    byebug
    render json: { game: game, snake_head: game.snake_head, tail: game.tails }
    # why can't we do game.snake_head.tails
  end


  private
  # def params
  # 	params.require(:game).permit({:user => {}}, {:snakeCoordinatesAndBearing => {}}, :id)
  # end

  def create_snake_head_and_tail(game)
    snake_head = SnakeHead.new(game_id: game.id)
    snake_head.bearing = params[:snakeCoordinatesAndBearing][:snake][:bearing]
    snake_head.x = params[:snakeCoordinatesAndBearing][:snake][:coordinates][0]
    snake_head.y = params[:snakeCoordinatesAndBearing][:snake][:coordinates][1]
    snake_head.save
    create_tail(snake_head)
    create_moves(snake_head)
  end


  def create_tail(snake_head)
    tail_array_of_hashes = params[:snakeCoordinatesAndBearing][:tail]
    tail_array_of_hashes.each do |tail_hash|
      # byebug
      tail_block = Tail.new(snake_head_id: snake_head.id)
      tail_block.bearing = tail_hash[:bearing]
      tail_block.x = tail_hash[:coordinates][0]
      tail_block.y = tail_hash[:coordinates][1]
      tail_block.next_move_index = tail_hash[:nextMoveIndex]
      tail_block.save
    end
  end

  def create_moves(snake_head)
    moves = params[:snakeCoordinatesAndBearing][:moves]
      moves.each do |move|
        move_instance = Move.new(snake_head_id: snake_head.id)
        move_instance.bearing = move[:bearing]
        move_instance.x = move[:coordinates][0]
        move_instance.y = move[:coordinates][1]
        move_instance.save 
      end
  end

  # def update_tail(snake_head)
  #   snake_head.tails.clear
  #   snake_head.save
  #   create_tail(snake_head)
  # end


end
