class ProgressesController < ApplicationController
  before_action :set_team, only: [:index, :update, :create]
  before_action :set_goal, only: [:index, :create, :update]
  before_action :set_progress, only: [:edit, :update, :destroy]

  def index
    @progresses = @team.goals.find(params[:goal_id]).progresses.order('start_date asc')
  end

  def new
    @start_date = last_monday
    @end_date = last_monday + 4
  end

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      @progress.update(progress_params)
      @progress.topic.update(topic_params)
    end
    redirect_to team_path(params[:team_id]), notice: '更新されました'
  rescue
    redirect_to edit_team_goal_progress_path(team_id: params[:team_id], goal_id: params[:goal_id]),  alert: '入力に不備があります'
  end

  def create
    ActiveRecord::Base.transaction do
      @progress = Progress.create!(progress_params)
      Topic.create!(progress_id: @progress.id, content: topic_params[:content])
    end
    redirect_to team_path(params[:team_id]), notice: '作成されました'
  rescue
    redirect_to new_team_goal_progress_path(team_id: params[:team_id], goal_id: params[:goal_id]),  alert: '入力に不備があります'
  end

  def destroy
    @progress.destroy
    respond_to do |format|
      format.html { redirect_to team_goal_progresses_path(team_id: params[:team_id], goal_id: params[:goal_id]), notice: '削除されました' }
    end
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end

  def set_progress
    @progress = Progress.find(params[:id])
  end

  def graph_params
    params.require(:graph).permit(:year,:month)
  rescue
    { year: Time.current.year, month: Time.current.month }
  end

  def progress_params
    params.require(:progress).permit(:amount, :start_date, :end_date).merge(goal: @goal)
  end

  def topic_params
    params.require(:topic).permit(:content)
  end

  def last_monday
    today = Date.today
    if today.wday > 1
      today - (today.wday - 1)
    else
      today - (8 - today.wday)
    end
  end
end
