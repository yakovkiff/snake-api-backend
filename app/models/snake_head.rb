class SnakeHead < ApplicationRecord
	has_many :tails
	belongs_to :game
end
