class Activity < ApplicationRecord
	has_many :user_activities
	has_many :user_goals
end
