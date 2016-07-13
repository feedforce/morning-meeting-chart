class ProgressesController < ApplicationController
  before_action :set_team, only: [:index] 
  before_action :set_progress, only: [:destroy]

  def index
    @graph = LazyHighCharts::HighChart.new('graph')
    @graph = @team.graph if @team.graph
    @progresses = Progress.where(team_id: @team.id).order('start_date DESC')
  end

  def new
    @start_date = last_monday
  end

  def create
    ActiveRecord::Base.transaction do
      @progress = Progress.create!(progress_params)
      topic_params[:content].each do |_key, val|
        Topic.create!(content: val, progress: @progress)
      end
    end
    redirect_to team_progresses_path(params[:team_id])
  rescue => e
    redirect_to new_team_progress_path(params[:team_id]),  alert: '入力に不備があります'
  end

  def destroy
    @progress.destroy
    respond_to do |format|
      format.html { redirect_to team_progresses_path(team_id: params[:team_id]), notice: 'Progress was successfully destroyed.' }
    end
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_progress
    @progress = Progress.find(params[:id])
  end

  def progress_params
    params.require(:progress).permit(:amount, :start_date).merge(team: Team.find(params[:team_id]))
  end

  def topic_params
    params.require(:topic).permit(content: ['1', '2', '3'])
  end
  
  def last_monday
    this_day = Date.today
    (this_day - (this_day.wday - 1)) - 7
  end
end
