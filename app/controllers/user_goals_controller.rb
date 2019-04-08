class UserGoalsController < ApplicationController
  before_action :set_user_goal, only: [:show, :edit, :update, :destroy]

  def index
    @user_goals = UserGoal.all
  end

  def show
  end

  def new
    @url = goals_path
    @user_goal = UserGoal.new
  end

  def edit
    flash[:referrer] = request.referer
    @url = goal_path(params[:id])
  end

  def create
    @user_goal = UserGoal.new(user_goal_params)
    @user_goal.user_id = current_user.id

    if @user_goal.activity_id.nil?
      @user_goal.activity = Activity.new(activity_params)
    end

    if @user_goal.save
      redirect_to dashboard_index_path, notice: 'Goal was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user_goal.update(user_goal_params)
      flash[:notice] = 'Goal was successfully updated.'
      redirect_to flash[:referrer] || dashboard_index_path
    else
      render :edit
    end
  end

  def destroy
    @user_goal.destroy
    flash[:notice] = 'Goal was successfully destroyed.'
    redirect_back fallback_location: dashboard_index_path
  end

  def card_list
    activity_most_recent = UserActivity.current_year.by_user(current_user.id).group(:activity_id).maximum(:performed_at)
    goals = UserGoal.includes(:activity).where(user: current_user, year: Time.now.year) #fixed on current year for now...

    @goals = goals.map { |g| GoalPresenter.new(g, view_context, activity_most_recent[g.activity_id]) }
    @goals.sort_by!{ |g| g.sorting_order(sort_column) }
    @goals.reverse! if sort_direction == "desc"

    render partial: "goals/list"
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

    def sort_column
      %w[magic name progress].include?(params[:sort]) ? params[:sort] : "magic"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
