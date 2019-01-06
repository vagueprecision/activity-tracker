class DashboardController < ApplicationController

  def index
    current_date = Time.now
    @goals = Goal.where(user: current_user, year: current_date.year)
		@activities = Activity.current_year.non_goal.where(user: current_user).group(:name).count
  end

  # Show goals and their progress
  # Show quick way to log activities
  # Show non-goal activity totals for the year
end
