class GoalActivitiesController < ApplicationController
  def index
    goal = UserGoal.find(params[:goal_id])
    @user_activities = UserActivities.where(activity_id: goal.activity_id, year: goal.year)
  end
end
