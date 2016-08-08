class GoalsController < ApplicationController
  before_action :set_team
  before_action :set_goal, only: [:edit, :update, :destroy]
  before_action :set_entity, only: [:new, :edit]

  def index
    @goals = @team.goals
    @graph = Graph.create(graph_params) unless @goals.order(:date).last.progresses.empty?
  end

  def edit
  end

  def new
    @goal = @team.goals.new
  end

  def create
    goal = @team.goals.new(goal_params)

    respond_to do |format|
      if goal.save
        format.html { redirect_to team_goals_path(@team), notice: '新しい目標が作成されました。' }
      else
        format.html { redirect_to new_team_goal_path(@team), alert: '入力に不備があります。' }
      end
    end
  end

  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to team_goals_path(@team), notice: '目標の更新に成功しました。' }
      else
        format.html { redirect_to edit_team_goal_path(@team), alert: '入力に不備があります。' }
      end
    end
  end

  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to team_goals_path(@team), notice: '削除されました' }
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
    param = params.require(:goal).permit(:date, :goal)
    param[:date] += '-01' if param[:date]
    param
  end

  def graph_params
    #params.require(:graph).permit(:data)
    @goals.order(:date).last
  end
end
