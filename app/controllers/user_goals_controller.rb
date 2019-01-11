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

    if params[:activity_id].nil?
      @user_goal.activity = Activity.new(name: params[:activity_name], unit: params[:activity_unit])
    end

    respond_to do |format|
      if @user_goal.save
        format.html { redirect_to @user_goal, notice: 'Goal was successfully created.' }
        format.json { render :show, status: :created, location: @user_goal }
      else
        format.html { render :new }
        format.json { render json: @user_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_goal.update(user_goal_params)
        format.html { redirect_to @user_goal, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_goal }
      else
        format.html { render :edit }
        format.json { render json: @user_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_goal.destroy
    respond_to do |format|
      format.html { redirect_to user_goals_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_goal
      @user_goal = UserGoal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_goal_params
      params.require(:user_goal).permit(:year, :count)
    end
end
