class Activity < ApplicationRecord
	has_many :user_activities
	has_many :user_goals

	scope :exclude_goals, ->(goals) { where.not(id: goals.map(&:activity_id)) }
end
