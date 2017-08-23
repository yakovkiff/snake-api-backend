class Api::V1::GamesController < ApplicationController

  def index

    games = Game.all
    render json: games
  end

  def createOrUpdate
  	game = Game.find(frontend_id: game_params[:id])
    if game 
      game.update(game_params)
    else
      game = Game.create(game_params)
    end
    
    render json: game
  end

  def update
    
  end

  private
  def game_params
  	params.require(:game).permit(:user, :tailSize, :tailCoordinatesAndBearing, :id)
  end

end
