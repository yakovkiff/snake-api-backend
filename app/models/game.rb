class Game < ApplicationRecord
	belongs_to :user, optional: true
	has_one :snake_head
	has_many :tails, through: :snake_head
end
