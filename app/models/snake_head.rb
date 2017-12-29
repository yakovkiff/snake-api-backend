class SnakeHead < ApplicationRecord
	has_many :tails
	has_many :moves
	belongs_to :game

	# def bearing
	# 	snakeCoordinatesAndBearing[:snake][:bearing]
	# end

	# def x
	# 	snakeCoordinatesAndBearing[:snake][:coordinates][0]
	# end

	# def y
	# 	snakeCoordinatesAndBearing[:snake][:coordinates][1]
	# end

end
