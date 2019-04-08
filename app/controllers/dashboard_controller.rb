class DashboardController < ApplicationController
  def index
    current_date = Time.now

    goals = UserGoal.includes(:activity).where(user: current_user, year: current_date.year) #duplicated in goals controller

    activities = Activity.exclude_goals(goals).joins(:user_activities)
      .merge(UserActivity.current_year.by_user(current_user.id))
      .group(:id, :name, :unit).sum(:perform_count)

    @activities = activities.map { |a| ActivityWithCountPresenter.new(a, view_context) }
  end
end
