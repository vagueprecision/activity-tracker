class DashboardController < ApplicationController

  def index
    current_date = Time.now
    goals = UserGoal.where(user: current_user, year: current_date.year)
		activities = UserActivity.current_year.exclude_goal.where(user: current_user).group_by_activity.count
    @goals = goals.map { |g| GoalPresenter.new(g, view_context) }
    @activities = activities.map { |a| ActivityWithCountPresenter.new(a, view_context) }
  end

  # Show goals and their progress
  # Show quick way to log activities
  # Show non-goal activity totals for the year
end
