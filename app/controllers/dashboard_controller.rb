class DashboardController < ApplicationController

  def index
    current_date = Time.now
    goals = UserGoal.includes(:activity).where(user: current_user, year: current_date.year)

    activities = Activity.where.not(id: goals.map(&:activity_id))
      .joins(:user_activities).where(user_activities: { user_id: current_user.id })
      .where('user_activities.performed_at > ?', current_date.beginning_of_year)
      .group(:id, :name).count

    @goals = goals.map { |g| GoalPresenter.new(g, view_context) }

    @activities = activities.map { |a| ActivityWithCountPresenter.new(a, view_context) }
  end
end
