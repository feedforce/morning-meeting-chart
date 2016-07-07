class ProgressesController < ApplicationController
  def index
    @progresses = Progress.where(team_id: params[:team_id])
  end

  def create
    ActiveRecord::Base.transaction do
      @progress = Progress.create!(progress_params)
      Topic.create!(topic_params)
    end
    redirect_to team_progresses_path(params[:team_id])
  end

  private

  def progress_params
    params.require(:progress).permit(:amount).merge(team: Team.find(params[:team_id]))
  end

  def topic_params
    params.require(:topic).permit(:content).merge(progress: @progress)
  end
end
