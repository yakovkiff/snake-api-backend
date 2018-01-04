class Tail < ApplicationRecord
	belongs_to :snake_head
	# has_one :game, through: :snake_head
	# belongs_to :game, through: :snake_head

	default_scope {order(:id)}

end
