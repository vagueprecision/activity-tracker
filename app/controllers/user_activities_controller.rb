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

    if params[:activity_id].nil?
      @user_activity.activity.build(name: params[:activity_name], unit: params[:activity_unit])
    end

    respond_to do |format|
      if @user_activity.save
        format.html { redirect_to @user_activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @user_activity }
      else
        format.html { render :new }
        format.json { render json: @user_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_activity.update(user_activity_params)
        format.html { redirect_to @user_activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_activity }
      else
        format.html { render :edit }
        format.json { render json: @user_activity.errors, status: :unprocessable_entity }
      end
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
    def user_activity_params
      params.require(:user_activity).permit(:performed_at, :activity_id, :activity_name, :activity_unit)
    end
end
