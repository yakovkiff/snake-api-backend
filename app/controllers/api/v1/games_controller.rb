class Api::V1::GamesController < ApplicationController

  def index

    game = Game.first
    # byebug
    render json: { game: game, snake_head: game.snake_head, tail: game.tails }
  end

  def create_or_update_game
  	game = Game.find_by(frontend_id: game_params[:id])
    if game
      game.update(user_id: game_params[:user][:id], frontend_id: game_params[:id])
      update_snake_head_and_tail(game)
    else
      byebug
      game = Game.create(user_id: game_params[:user][:id], frontend_id: game_params[:id])
      create_snake_head_and_tail(game)
    end
    render json: { game: game, snake_head: game.snake_head, tail: game.tails }
    # ask an instructor why we can't do game.snake_head.tails
  end


  private
  def game_params
  	params.require(:game).permit({:user => {}}, {:snakeCoordinatesAndBearing => {}}, :id)
  end

  def create_snake_head_and_tail(game)
    snake_head = SnakeHead.new(game_id: game.id)
    snake_head.bearing = game_params[:snakeCoordinatesAndBearing][:snake][:bearing]
    snake_head.x = game_params[:snakeCoordinatesAndBearing][:snake][:coordinates][0]
    snake_head.y = game_params[:snakeCoordinatesAndBearing][:snake][:coordinates][1]
    snake_head.save
    create_tail(snake_head)
  end

  def update_snake_head_and_tail(game)
    snake_head = game.snake_head
    snake_head.bearing = game_params[:snakeCoordinatesAndBearing][:snake][:bearing]
    snake_head.x = game_params[:snakeCoordinatesAndBearing][:snake][:coordinates][0]
    snake_head.y = game_params[:snakeCoordinatesAndBearing][:snake][:coordinates][1]
    snake_head.save
    update_tail(snake_head)
  end

  # {snake: snakeHead.coordinatesAndBearing(), tail: snakeHead.tailCoordinatesAndBearing()}

  def create_tail(snake_head)
    tail_array_of_hashes = game_params[:snakeCoordinatesAndBearing][:tail]
    tail_array_of_hashes.each do |tail_hash|
      # byebug
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
