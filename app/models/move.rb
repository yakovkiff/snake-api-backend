class Move < ApplicationRecord
  belongs_to :snake_head

  default_scope order(:id)
end
