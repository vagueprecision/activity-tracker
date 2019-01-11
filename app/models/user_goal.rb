class UserGoal < ApplicationRecord
	belongs_to :user
	belongs_to :activity
	has_many :categories

	validate :attr_not_changed, on: :update
	#allow target to change

	before_create :update_count

	scope :for, ->(datetime) { where(year: datetime.year) } #utc or local?

  def attr_not_changed
    errors.add(:user_id, "Change of user_id not allowed!") if user_id_changed?
		errors.add(:activity_id, "Change of activity_id not allowed!") if activity_id_changed?
		errors.add(:year, "Change of year not allowed!") if year_changed?
  end

	def met?
		count >= target
	end

	#inclusive
	def starts_at
		new DateTime(year, 1, 1)
	end

	# exclusive
	def ends_at
		starts_at.add_year(1)
	end

	def update_count
		count = UserActivity.where(user_id: user_id, activity_id: activity_id, performed_at: between(starts_at, ends_at)).count
	end

	def increment
		count += 1
		save
	end

	def decrement
		count -= 1
		save
	end
end
