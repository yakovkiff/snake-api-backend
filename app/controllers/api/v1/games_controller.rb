class Api::V1::GamesController < ApplicationController

  def index
    game = Game.last
    byebug
    render json: { game: game, snake_head: game.snake_head, tail: game.snake_head.tails }
  end

  def create_or_update_game
    byebug
  	# game = Game.last
    # if game
      # game.update(user_id: params[:user][:id])
      # update_snake_head_and_tail(game)
    # else
      # game = Game.create(user_id: params[:user][:id])
      game = Game.create
      create_snake_head_and_tail(game)
    # end
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
  end

  def update_snake_head_and_tail(game)
    snake_head = game.snake_head
    snake_head.bearing = params[:snakeCoordinatesAndBearing][:snake][:bearing]
    snake_head.x = params[:snakeCoordinatesAndBearing][:snake][:coordinates][0]
    snake_head.y = params[:snakeCoordinatesAndBearing][:snake][:coordinates][1]
    snake_head.save
    update_tail(snake_head)
  end

  # {snake: snakeHead.coordinatesAndBearing(), tail: snakeHead.tailCoordinatesAndBearing()}

  def create_tail(snake_head)
    tail_array_of_hashes = params[:snakeCoordinatesAndBearing][:tail]
    tail_array_of_hashes.each do |tail_hash|
      byebug
      tail_block = Tail.new(snake_head_id: snake_head.id)
      tail_block.bearing = tail_hash[:bearing]
      tail_block.x = tail_hash[:coordinates][0]
      tail_block.y = tail_hash[:coordinates][1]
      tail_block.save
    end
  end

  def update_tail(snake_head)
    snake_head.tails.clear
    snake_head.save
    create_tail(snake_head)
  end


end
