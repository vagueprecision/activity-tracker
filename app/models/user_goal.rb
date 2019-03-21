class UserGoal < ApplicationRecord
	belongs_to :user
	belongs_to :activity
	has_many :categories

	validate :attr_not_changed, on: :update
	#allow target to change

	before_create :update_count

	COMPLETE = 'COMPLETE'
	ON_TRACK = 'ON_TRACK'
	SLIGHTLY_BEHIND = 'SLIGHTLY_BEHIND'
	WAY_BEHIND = 'WAY_BEHIND'

	scope :for, ->(datetime) { where(year: datetime.year) } #utc or local?

  def attr_not_changed
    errors.add(:user_id, "Change of user_id not allowed!") if user_id_changed?
		errors.add(:activity_id, "Change of activity_id not allowed!") if activity_id_changed?
		errors.add(:year, "Change of year not allowed!") if year_changed?
  end

	def current_progress
		return COMPLETE if met?
		return ON_TRACK if current_percent >= on_track_percent
		return SLIGHTLY_BEHIND if on_track_percent - current_percent < 0.1
		WAY_BEHIND
	end

	def duration_days
		(ends_at.to_date - starts_at.to_date).to_i
	end

	def current_days
		(Time.now.to_date - starts_at.to_date).to_i
	end

	def on_track_percent
		current_days.to_f / duration_days
	end

	def current_percent
		count / target
	end

	def met?
		current_percent >= 1
	end

	#inclusive
	def starts_at
		Time.new(year, 1, 1)
	end

	# exclusive
	def ends_at
		starts_at + 1.year
	end

	def update_count
		self.count = UserActivity.where(user_id: user_id, activity_id: activity_id, performed_at: starts_at...ends_at).count
	end

	def increment(amount)
		self.count += amount
		save!
	end

	def decrement(amount)
		self.count -= amount
		save!
	end

  # TODO update to compare where progress should be thru year
  def on_track?
	  true
  end

	def percent_complete
		count / target * 100
	end
end
