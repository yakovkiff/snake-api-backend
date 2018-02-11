class User < ApplicationRecord
	has_many :games
	# validate :hello

	# def hello
	# 	if high_score <= 0
	# 		errors.add(:high_score, "cannot be 0")
	# 		return false
	# 	end
	# end
end
