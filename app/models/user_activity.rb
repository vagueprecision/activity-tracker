class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  has_many :user_activity_categories
  has_many :categories, through: :user_activity_categories

  before_create :increment_goals
  before_destroy :decrement_goals
  before_update :update_goals

	scope :current_year, -> { where('performed_at > ?', Time.now.beginning_of_year) } #utc or local?
	scope :non_goal, -> { joins("LEFT JOIN goals ON user_activities.id = goals.activity_id and user_activities.user_id = goals.user_id").where(goals: {id: nil}) }

	def increment_goals
		related_goals(performed_at).each(&:increment)
	end

  def decrement_goals
		related_goals(performed_at).each(&:decrement)
	end

  def update_goals
    related_goals(performed_at_was).each(&:decrement)
    related_goals(performed_at).each(&:increment)
  end

  def related_goals(datetime)
    UserGoal.where(user_id: user_id, activity_id: activity_id).for(datetime)
  end
end
