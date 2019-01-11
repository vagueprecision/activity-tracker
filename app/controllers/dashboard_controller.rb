class DashboardController < ApplicationController

  def index
    current_date = Time.now
    @goals = UserGoal.where(user: current_user, year: current_date.year)
		@activities = UserActivity.current_year.non_goal.where(user: current_user).group_by_activity.count
  end

  # Show goals and their progress
  # Show quick way to log activities
  # Show non-goal activity totals for the year
end
