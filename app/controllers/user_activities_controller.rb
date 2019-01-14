class UserActivitiesController < ApplicationController
  before_action :set_user_goal, only: [:show, :edit, :update, :destroy]

  def index
    @user_activities = UserActivities.all
  end

  def show
  end

  def new
    @user_activity = UserActivity.new
  end

  def edit
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
      redirect_to root_path, notice: 'Activity was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user_activity.destroy
    respond_to do |format|
      format.html { redirect_to user_activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
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
      .permit(:performed_at, :perform_count, :activity_id, :activity_name, :activity_unit)
  end

  def user_activity_params
    permitted_params.except(:activity_name, :activity_unit)
  end

  def activity_params
    { name: permitted_params[:activity_name], unit: permitted_params[:activity_unit] }
  end
end
