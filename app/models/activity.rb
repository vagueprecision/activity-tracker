class Activity < ApplicationRecord
	belongs_to :user

	scope :current_year, -> { where('performed_at > ?', Time.now.beginning_of_year) }

	scope :non_goal, -> { joins("LEFT JOIN goals ON activities.id = goals.activity_id").where(goals: {activity_id: nil}) }
end
