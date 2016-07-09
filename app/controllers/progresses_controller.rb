class ProgressesController < ApplicationController
  before_action :set_team, only: [:index]

  def index
    @graph = LazyHighCharts::HighChart.new('graph')
    @graph = @team.graph if @team.graph
    @progresses = Progress.where(team_id: @team.id)
  end

  def create
    ActiveRecord::Base.transaction do
      @progress = Progress.create!(progress_params)
      Topic.create!(topic_params)
    end
    redirect_to team_progresses_path(params[:team_id])
  rescue => e
    redirect_to new_team_progress_path(params[:team_id]),  alert: '入力に不備があります'
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def progress_params
    params.require(:progress).permit(:amount).merge(team: Team.find(params[:team_id]))
  end

  def topic_params
    params.require(:topic).permit(:content).merge(progress: @progress)
  end
end
