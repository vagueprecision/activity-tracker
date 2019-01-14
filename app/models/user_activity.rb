class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  has_many :user_activity_categories
  has_many :categories, through: :user_activity_categories

  before_create :increment_goals
  before_destroy :decrement_goals
  before_update :update_goals

	scope :current_year, -> { where('performed_at > ?', Time.now.beginning_of_year) } #utc or local?
	# scope :exclude_goal, -> { joins("LEFT JOIN user_goals ON user_activities.id = user_goals.activity_id and user_activities.user_id = user_goals.user_id").where(user_goals: {id: nil}) }
  scope :group_by_activity, -> { group(:activity_id).includes(:activity) }

	def increment_goals
		related_goals(performed_at).each{ |g| g.increment(perform_count) }
	end

  def decrement_goals
		related_goals(performed_at).each{ |g| g.decrement(perform_count_was) }
	end

  def update_goals
    related_goals(performed_at_was).each{ |g| g.decrement(perform_count_was) }
    related_goals(performed_at).each{ |g| g.increment(perform_count) }
  end

  def related_goals(datetime)
    UserGoal.where(user_id: user_id, activity_id: activity_id).for(datetime)
  end
end
