class GoalsController < ApplicationController
  before_action :set_team
  before_action :set_goal, only: [:edit]
  before_action :set_entity, only: [:new, :edit]

  def index
    @goals = @team.goals
  end

  def new
    @goal = @team.goals.new
  end

  def create
    goal = @team.goals.new(goal_params)

    respond_to do |format|
      if goal.save
        format.html { redirect_to team_goals_path(@team), notice: '新しい目標が作成されました' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def set_entity
    if @team.order?
      @entity = '件'
    else
      @entity = '円'
    end
  end

  def goal_params
    params.require(:goal).permit(:date, :goal)
  end
end
