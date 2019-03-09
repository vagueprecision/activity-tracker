class UserActivitiesController < ApplicationController
  before_action :set_user_activity, only: [:edit, :update, :destroy]

  def index
    @user_activities = UserActivity.where(activity_id: params[:activity_id]).in_year(params[:year])
    @activity = Activity.find(params[:activity_id])

    if @activity
      @title = @activity.name
    else
      @title = 'Activities'
    end

    @title = @title.prepend(params[:year] + '\'s ') if params[:year]
  end

  def new
    @url = activities_path
    @user_activity = UserActivity.new
  end

  def edit
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
      .permit(:performed_at, :perform_count, :details, :activity_id, :activity_name, :activity_unit)
  end

  def user_activity_params
    permitted_params.except(:activity_name, :activity_unit)
  end

  def activity_params
    { name: permitted_params[:activity_name], unit: permitted_params[:activity_unit] }
  end
end
