class UserGoalsController < ApplicationController
  before_action :set_user_goal, only: [:show, :edit, :update, :destroy]

  def index
    @user_goals = UserGoal.all
  end

  def show
  end

  def new
    @user_goal = UserGoal.new
  end

  def edit
  end

  def create
    @user_goal = UserGoal.new(user_goal_params)
    @user_goal.user_id = current_user.id

    if @user_goal.activity_id.nil?
      @user_goal.activity = Activity.new(activity_params)
    end

    if @user_goal.save
      redirect_to root_path, notice: 'Goal was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user_goal.update(user_goal_params)
      redirect_to root_path, notice: 'Goal was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user_goal.destroy
    redirect_to root_path notice: 'Goal was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_goal
      @user_goal = UserGoal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permitted_params
      params
        .require(:user_goal)
        .permit(:year, :activity_id, :activity_name, :activity_unit, :target)
    end

    def user_goal_params
      permitted_params.except(:activity_name, :activity_unit)
    end

    def activity_params
      { name: permitted_params[:activity_name], unit: permitted_params[:activity_unit] }
    end
end
