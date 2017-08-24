class Tail < ApplicationRecord
	belongs_to :snake_head
	belongs_to :game, through: :snake_head

end
