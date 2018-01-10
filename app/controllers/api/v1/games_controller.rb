class Api::V1::GamesController < ApplicationController

  def index
    game = Game.last

    moves = game.snake_head.moves.map do |move|
      {
        bearing: move.bearing,
        coordinates: [move.x, move.y]
      }
    end

    tail = game.tails.map do |tail|
      {
        bearing: tail.bearing,
        coordinates: [tail.x, tail.y],
        nextMoveIndex: tail.next_move_index
      }
    end

    render json: {
      snakeHead: {
        bearing: game.snake_head.bearing,
        coordinates: [game.snake_head.x, game.snake_head.y],
        moves: moves
      },
      tail: tail
    }
  end

  def create_or_update_game
    user = User.create(name: params[:userName])
    game = Game.create(user_id: user.id)
    create_snake_head_and_tail(game)
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
    moves = params[:snakeCoordinatesAndBearing][:snake][:moves]
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
