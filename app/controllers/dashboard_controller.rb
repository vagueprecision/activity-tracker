class DashboardController < ApplicationController
  def index
    current_date = Time.now
    goals = UserGoal.includes(:activity).where(user: current_user, year: current_date.year)

    activities = Activity.exclude_goals(goals).joins(:user_activities)
      .merge(UserActivity.current_year.by_user(current_user.id))
      .group(:id, :name, :unit).sum(:perform_count)

    @goals = goals.map { |g| GoalPresenter.new(g, view_context) }

    @activities = activities.map { |a| ActivityWithCountPresenter.new(a, view_context) }
  end
end
