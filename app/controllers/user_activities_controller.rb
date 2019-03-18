class UserActivitiesController < ApplicationController
  before_action :set_user_activity, only: [:edit, :update, :destroy]

  def index
    if params[:goal_id]
      goal = UserGoal.find(params[:goal_id])
      year = goal.year
      activity_id = goal.activity_id
    else
      activity_id = params[:activity_id]
      year = params[:year]
    end

    @user_activities = UserActivity.where(activity_id: activity_id).in_year(year).order(performed_at: :desc)
    @activity = Activity.find(activity_id)

    if @activity
      @title = @activity.name
    else
      @title = 'Activities'
    end

    @title = @title.prepend(year.to_s + ' - ') if year
  end

  def new
    @url = activities_path
    @user_activity = UserActivity.new
  end

  def edit
    flash[:referrer] = request.referer
    @url = activity_path(params[:id])
  end

  def create
    @user_activity = UserActivity.new(user_activity_params)
    @user_activity.user_id = current_user.id

    if @user_activity.activity_id.nil?
      @user_activity.activity = Activity.new(activity_params)
    end

    if @user_activity.save
      redirect_to dashboard_index_path, notice: 'Activity was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user_activity.update(user_activity_params)
      flash[:notice] = 'Activity was successfully updated.'
      redirect_to flash[:referrer] || dashboard_index_path
    else
      render :edit
    end
  end

  def destroy
    @user_activity.destroy
    flash[:notice] = 'Activity was successfully destroyed.'
    redirect_back fallback_location: dashboard_index_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_activity
    @user_activity = UserActivity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permitted_params
    params
      .require(:user_activity)
      .permit(:performed_at, :perform_count, :details, :activity_id, :activity_name, :activity_unit)
  end

  def user_activity_params
    permitted_params.except(:activity_name, :activity_unit)
  end

  def activity_params
    { name: permitted_params[:activity_name], unit: permitted_params[:activity_unit] }
  end
end
