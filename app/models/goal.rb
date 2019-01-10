class Goal < ApplicationRecord
	belongs_to :user
	has_many :categories

	# after: :create, :populate_count
end
